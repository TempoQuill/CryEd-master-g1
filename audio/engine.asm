; The entire sound engine. Uses section "audio" in WRAM.

; Interfaces are in bank 0.

; Notable functions:
; 	FadeMusic
; 	PlayStereoSFX

_InitSound::
; restart sound operation
; clear all relevant hardware registers & wram
	push hl
	push de
	push bc
	push af
	call MusicOff
	ld hl, rNR50 ; channel control registers
	xor a
	ld [hli], a ; rNR50 ; volume/vin
	ld [hli], a ; rNR51 ; sfx channels
	ld a, $80 ; all channels on
	ld [hli], a ; rNR52 ; music channels

	ld hl, rNR10 ; sound channel registers
	ld e, NUM_MUSIC_CHANS
.clearsound
;   sound channel   1      2      3      4
	xor a
	ld [hli], a ; rNR10, rNR20, rNR30, rNR40 ; sweep = 0

	ld [hli], a ; rNR11, rNR21, rNR31, rNR41 ; length/wavepattern = 0
	ld a, $8
	ld [hli], a ; rNR12, rNR22, rNR32, rNR42 ; envelope = 0
	xor a
	ld [hli], a ; rNR13, rNR23, rNR33, rNR43 ; frequency lo = 0
	ld a, $80
	ld [hli], a ; rNR14, rNR24, rNR34, rNR44 ; restart sound (freq hi = 0)
	dec e
	jr nz, .clearsound

	ld hl, wAudio
	ld de, wAudioEnd - wAudio
.clearaudio
	xor a
	ld [hli], a
	dec de
	ld a, e
	or d
	jr nz, .clearaudio

	ld a, MAX_VOLUME
	ld [wVolume], a
	call MusicOn
	pop af
	pop bc
	pop de
	pop hl
	ret

MusicFadeRestart:
; restart but keep the music id to fade in to
	ld a, [wMusicFadeID + 1]
	push af
	ld a, [wMusicFadeID]
	push af
	call _InitSound
	pop af
	ld [wMusicFadeID], a
	pop af
	ld [wMusicFadeID + 1], a
	ret

MusicOn:
	ld a, 1
	ld [wMusicPlaying], a
	ret

MusicOff:
	xor a
	ld [wMusicPlaying], a
	ret

_UpdateSound::
; called once per frame
	; no use updating audio if it's not playing
	ld a, [wMusicPlaying]
	and a
	ret z
	; start at ch1
	xor a
	ld [wCurChannel], a ; just
	ld [wSoundOutput], a ; off
	ld bc, wChannel1
.loop
	; is the channel active?
	bc_offset CHANNEL_FLAGS1
	bit SOUND_RETURN, [hl]
	jr z, .is_ch_on
	call UpdateRetCounterAfterFF
	jp .nextchannel
.is_ch_on
	bc_offset CHANNEL_FLAGS1
	bit SOUND_CHANNEL_ON, [hl]
	jp z, .nextchannel
	; check time left in the current note
	bc_offset CHANNEL_NOTE_DURATION
	ld a, [hl]
	cp 2 ; 1 or 0?
	jr c, .noteover
	dec [hl]
	jr .continue_sound_update

.noteover
	; reset vibrato delay
	bc_offset CHANNEL_VIBRATO_DELAY
	ld a, [hl]
	bc_offset CHANNEL_VIBRATO_DELAY_COUNT
	ld [hl], a
	; turn vibrato off for now
	bc_offset CHANNEL_FLAGS2
	res SOUND_PITCH_SLIDE, [hl]
	; get next note
	call ParseMusic
.continue_sound_update
	call UpdateRetCounter
	call ApplyPitchSlide
	; duty cycle
	bc_offset CHANNEL_DUTY_CYCLE
	ld a, [hli]
	ld [wCurTrackDuty], a
	; volume envelope
	ld a, [hli]
	ld [wCurTrackVolumeEnvelope], a
	; frequency
	ld a, [hli]
	ld [wCurTrackFrequency], a
	ld a, [hl]
	ld [wCurTrackFrequency + 1], a
	; vibrato, noise
	call HandleTrackVibrato ; handle vibrato and other things
	call HandleNoise
	; turn off music when playing sfx?
	ld a, [wSFXPriority]
	and a
	jr z, .next
	; are we in a sfx channel right now?
	ld a, [wCurChannel]
	cp NUM_MUSIC_CHANS
	jr nc, .next
	; are any sfx channels active?
	; if so, mute
	ld hl, wChannel5Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .restnote
	ld hl, wChannel6Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .restnote
	ld hl, wChannel7Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .restnote
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .next
.restnote
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_TEMP_MUTE, [hl] ; Rest
.next
	; are we in a sfx channel right now?
	ld a, [wCurChannel]
	cp NUM_MUSIC_CHANS
	jr nc, .sfx_channel
	bc_offset CHANNEL_STRUCT_LENGTH * NUM_MUSIC_CHANS + CHANNEL_FLAGS1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .sound_channel_on
.sfx_channel
	call UpdateChannels
	bc_offset CHANNEL_TRACKS
	ld a, [wSoundOutput]
	or [hl]
	ld [wSoundOutput], a
.sound_channel_on
	; clear note flags
	bc_offset CHANNEL_NOTE_FLAGS
	xor a
	ld [hl], a
.nextchannel
	; next channel
	bc_offset CHANNEL_STRUCT_LENGTH
	ld c, l
	ld b, h
	ld a, [wCurChannel]
	inc a
	ld [wCurChannel], a
	cp NUM_CHANNELS ; are we done?
	jp nz, .loop ; do it all again

	call PlayDanger
	; fade music in/out
	call FadeMusic
	; write volume to hardware register
	ld a, [wVolume]
	ldh [rNR50], a
	; write SO on/off to hardware register
	ld a, [wSoundOutput]
	ldh [rNR51], a
	ret

UpdateChannels:
	ld hl, .ChannelFunctions
	ld a, [wCurChannel]
	maskbits NUM_CHANNELS
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.ChannelFunctions:
	table_width 2, UpdateChannels.ChannelFunctions
; music channels
	dw .Channel1
	dw .Channel2
	dw .Channel3
	dw .Channel4
	assert_table_length NUM_MUSIC_CHANS
; sfx channels
; identical to music channels, except .Channel5 is not disabled by the low-HP danger sound
; (instead, PlayDanger does not play the danger sound if sfx is playing)
	dw .Channel5
	dw .Channel6
	dw .Channel7
	dw .Channel8
	assert_table_length NUM_CHANNELS

.Channel1:
.Channel5:
	ld a, [wLowHealthAlarm]
	bit DANGER_ON_F, a
	ret nz
	bc_offset CHANNEL_NOTE_FLAGS
	bit NOTE_PITCH_SWEEP, [hl]
	jr z, .noPitchSweep
	;
	ld a, [wPitchSweep]
	ldh [rNR10], a
.noPitchSweep
	bit NOTE_TEMP_MUTE, [hl]
	ret nz
	bit NOTE_REST, [hl] ; rest
	jr nz, .ch1_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch1_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	jr nz, .ch1_frequency_override
	bit NOTE_VIBRATO_OVERRIDE, [hl]
	jr nz, .ch1_vibrato_override
	jr .ch1_check_duty_override

.ch1_frequency_override
	ld a, [wCurTrackFrequency]
	ldh [rNR13], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR14], a
.ch1_check_duty_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	ret z
	ld a, [wCurTrackDuty]
	ld d, a
	ldh a, [rNR11]
	and $3f ; sound length
	or d
	ldh [rNR11], a
	ret

.ch1_vibrato_override
	ld a, [wCurTrackDuty]
	ld d, a
	ldh a, [rNR11]
	and $3f ; sound length
	or d
	ldh [rNR11], a
	ld a, [wCurTrackFrequency]
	ldh [rNR13], a
	ret

.ch1_rest
	ldh a, [rNR52]
	and %10001110 ; ch1 off
	ldh [rNR52], a
	ld hl, rNR10
	jp ClearChannel

.ch1_noise_sampling
	ld hl, wCurTrackDuty
	ld a, $3f ; sound length
	or [hl]
	ldh [rNR11], a
	ld a, [wCurTrackVolumeEnvelope]
	ldh [rNR12], a
	ld a, [wCurTrackFrequency]
	ldh [rNR13], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR14], a
	jp InitRetCounter

.Channel2:
.Channel6:
	bc_offset CHANNEL_NOTE_FLAGS
	bit NOTE_TEMP_MUTE, [hl]
	ret nz
	bit NOTE_REST, [hl] ; rest
	jr nz, .ch2_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch2_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	jr nz, .ch2_frequency_override
	bit NOTE_VIBRATO_OVERRIDE, [hl]
	jr nz, .ch2_vibrato_override
.ch2_check_duty_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	ret z
	ld a, [wCurTrackDuty]
	ld d, a
	ldh a, [rNR21]
	and $3f ; sound length
	or d
	ldh [rNR21], a
	ret

.ch2_frequency_override ; unreferenced
	ld a, [wCurTrackFrequency]
	ldh [rNR23], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR24], a
	jr .ch2_check_duty_override

.ch2_vibrato_override
	ld a, [wCurTrackDuty]
	ld d, a
	ldh a, [rNR21]
	and $3f ; sound length
	or d
	ldh [rNR21], a
	ld a, [wCurTrackFrequency]
	ldh [rNR23], a
	ret

.ch2_rest
	ldh a, [rNR52]
	and %10001101 ; ch2 off
	ldh [rNR52], a
	ld hl, rNR20
	jp ClearChannel

.ch2_noise_sampling
	ld hl, wCurTrackDuty
	ld a, $3f ; sound length
	or [hl]
	ldh [rNR21], a
	ld a, [wCurTrackVolumeEnvelope]
	ldh [rNR22], a
	ld a, [wCurTrackFrequency]
	ldh [rNR23], a
	ld a, [wCurTrackFrequency + 1]
	or $80 ; initial (restart)
	ldh [rNR24], a
	jp InitRetCounter

.Channel3:
.Channel7:
	bc_offset CHANNEL_NOTE_FLAGS
	bit NOTE_TEMP_MUTE, [hl]
	jr nz, .ch3_rest
	bit NOTE_REST, [hl]
	jr nz, .ch3_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch3_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	jr nz, .ch3_frequency_override
	bit NOTE_VIBRATO_OVERRIDE, [hl]
	jr nz, .ch3_vibrato_override
	ret

.ch3_frequency_override ; unreferenced
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR34], a
	ret

.ch3_vibrato_override
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ret

.ch3_rest
	ldh a, [rNR52]
	and %10001011 ; ch3 off
	ldh [rNR52], a
	ld hl, rNR30
	jp ClearChannel

.ch3_noise_sampling
	ld a, $3f ; sound length
	ldh [rNR31], a
	xor a
	ldh [rNR30], a
	call .load_wave_pattern
	ld a, $80
	ldh [rNR30], a
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR34], a
	ret

.load_wave_pattern
	push hl
	ld a, [wCurTrackVolumeEnvelope]
	and $f ; only 0-9 are valid
	ld l, a
	ld h, 0
	; hl << 4
	; each wavepattern is $f bytes long
	; so seeking is done in $10s
rept 4
	add hl, hl
endr
	ld de, WaveSamples
	add hl, de
	; load wavepattern into rWave_0-rWave_f
	ld a, [hli]
	ldh [rWave_0], a
	ld a, [hli]
	ldh [rWave_1], a
	ld a, [hli]
	ldh [rWave_2], a
	ld a, [hli]
	ldh [rWave_3], a
	ld a, [hli]
	ldh [rWave_4], a
	ld a, [hli]
	ldh [rWave_5], a
	ld a, [hli]
	ldh [rWave_6], a
	ld a, [hli]
	ldh [rWave_7], a
	ld a, [hli]
	ldh [rWave_8], a
	ld a, [hli]
	ldh [rWave_9], a
	ld a, [hli]
	ldh [rWave_a], a
	ld a, [hli]
	ldh [rWave_b], a
	ld a, [hli]
	ldh [rWave_c], a
	ld a, [hli]
	ldh [rWave_d], a
	ld a, [hli]
	ldh [rWave_e], a
	ld a, [hli]
	ldh [rWave_f], a
	pop hl
	ld a, [wCurTrackVolumeEnvelope]
	and $f0
	sla a
	ldh [rNR32], a
	ret

.Channel4:
.Channel8:
	bc_offset CHANNEL_NOTE_FLAGS
	bit NOTE_TEMP_MUTE, [hl]
	ret nz
	bit NOTE_REST, [hl]
	jr nz, .ch4_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	ret z
	ld a, $3f ; sound length
	ldh [rNR41], a
	ld a, [wCurTrackVolumeEnvelope]
	ldh [rNR42], a
	ld a, [wCurTrackFrequency]
	ldh [rNR43], a
	ld a, $80
	ldh [rNR44], a
	jp InitRetCounter

.ch4_rest
	ldh a, [rNR52]
	and %10000111 ; ch4 off
	ldh [rNR52], a
	ld hl, rNR40
	jp ClearChannel

_CheckSFX:
; return carry if any sfx channels are active
	ld hl, wChannel5Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .sfxon
	ld hl, wChannel6Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .sfxon
	ld hl, wChannel7Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .sfxon
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .sfxon
	and a
	ret

.sfxon
	scf
	ret

PlayDanger:
	ld a, [wLowHealthAlarm]
	bit DANGER_ON_F, a
	jr z, .disable

	; Don't do anything if SFX is being played
	and $ff ^ (1 << DANGER_ON_F)
	ld d, a

	; Play the high tone
	and a
	jr z, .begin

	; Play the low tone
	cp 10
	jr z, .halfway

	jr .increment

.halfway
	ld hl, DangerSoundLow
	jr .applychannel

.begin
	ld hl, DangerSoundHigh

.applychannel
	xor a
	ldh [rNR10], a
	ld a, [hli]
	ldh [rNR11], a
	ld a, [hli]
	ldh [rNR12], a
	ld a, [hli]
	ldh [rNR13], a
	ld a, [hli]
	ldh [rNR14], a

.increment
	ld a, d
	inc a
	cp 30 ; Ending frame
	jr c, .noreset
	xor a
.noreset
	; Make sure the danger sound is kept on
	or 1 << DANGER_ON_F
	ld [wLowHealthAlarm], a

	; Enable channel 1 if it's off
	ld a, [wSoundOutput]
	and $11
	ret nz
	ld a, [wSoundOutput]
	or $11
	ld [wSoundOutput], a
	ret

.disable
	and a
	ret z
	xor a
	ld [wLowHealthAlarm], a
	ldh [rNR10], a
	ld hl, DangerSilence
	ld a, [hli]
	ldh [rNR11], a
	ld a, [hli]
	ldh [rNR12], a
	ld a, [hli]
	ldh [rNR13], a
	ld a, [hli]
	ldh [rNR14], a
	ret

DangerSoundHigh:
	db $a0 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $50 ; frequency: $750
	db $87 ; restart sound

DangerSoundLow:
	db $b0 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $ee ; frequency: $6ee
	db $86 ; restart sound

DangerSilence:
	db $00 ; duty 12.5%
	db $00 ; volume 0, envelope decrease sweep 0
	db $00 ; frequency: $000
	db $80 ; restart sound

FadeMusic:
; fade music if applicable
; usage:
;	write to wMusicFade
;	song fades out at the given rate
;	load song id in wMusicFadeID
;	fade new song in
; notes:
;	max # frames per volume level is $3f

	; fading?
	ld a, [wMusicFade]
	and a
	ret z
	; has the count ended?
	ld a, [wMusicFadeCount]
	and a
	jr z, .update
	; count down
	dec a
	ld [wMusicFadeCount], a
	ret

.update
	ld a, [wMusicFade]
	ld d, a
	; get new count
	and $3f
	ld [wMusicFadeCount], a
	; get SO1 volume
	ld a, [wVolume]
	and VOLUME_SO1_LEVEL
	; which way are we fading?
	bit MUSIC_FADE_IN_F, d
	jr nz, .fadein
	; fading out
	and a
	jr z, .novolume
	dec a
	jr .updatevolume

.novolume
	; make sure volume is off
	xor a
	ld [wVolume], a
	; did we just get on a bike?
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr z, .bicycle
	; don't overwrite channel pointer
	push bc
	; restart sound
	call MusicFadeRestart
	; get new song id
	ld a, [wMusicFadeID]
	and a
	jr z, .quit ; this assumes there are fewer than 256 songs!
	ld e, a
	ld a, [wMusicFadeID + 1]
	ld d, a
	; load new song
	call _PlayMusic
.quit
	; cleanup
	pop bc
	; stop fading
	xor a
	ld [wMusicFade], a
	ret

.bicycle
	push bc
	; restart sound
	call MusicFadeRestart
	; this turns the volume up
	; turn it back down
	xor a
	ld [wVolume], a
	; get new song id
	ld a, [wMusicFadeID]
	ld e, a
	ld a, [wMusicFadeID + 1]
	ld d, a
	; load new song
	call _PlayMusic
	pop bc
	; fade in
	ld hl, wMusicFade
	set MUSIC_FADE_IN_F, [hl]
	ret

.fadein
	; are we done?
	cp MAX_VOLUME & $f
	jr nc, .maxvolume
	; inc volume
	inc a
	jr .updatevolume

.maxvolume
	; we're done
	xor a
	ld [wMusicFade], a
	ret

.updatevolume
	; hi = lo
	ld d, a
	swap a
	or d
	ld [wVolume], a
	ret

LoadNote:
	; wait for pitch slide to finish
	bc_offset CHANNEL_FLAGS2
	bit SOUND_PITCH_SLIDE, [hl]
	ret z
	; get note duration
	bc_offset CHANNEL_NOTE_DURATION
	ld a, [hl]
	ld hl, wCurNoteDuration
	sub [hl]
	jr nc, .ok
	ld a, 1
.ok
	ld [hl], a
	; get frequency
	bc_offset CHANNEL_FREQUENCY
	ld e, [hl]
	inc hl
	ld d, [hl]
	; get direction of pitch slide
	ld hl, CHANNEL_PITCH_SLIDE_TARGET
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	ld hl, CHANNEL_PITCH_SLIDE_TARGET + 1
	add hl, bc
	sub [hl]
	jr nc, .greater_than
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	set SOUND_PITCH_SLIDE_DIR, [hl]
	; get frequency
	bc_offset CHANNEL_FREQUENCY
	ld e, [hl]
	inc hl
	ld d, [hl]
	; ????
	ld hl, CHANNEL_PITCH_SLIDE_TARGET
	add hl, bc
	ld a, [hl]
	sub e
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	; ????
	ld hl, CHANNEL_PITCH_SLIDE_TARGET + 1
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	jr .resume

.greater_than
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	res SOUND_PITCH_SLIDE_DIR, [hl]
	; get frequency
	bc_offset CHANNEL_FREQUENCY
	ld e, [hl]
	inc hl
	ld d, [hl]
	; get distance from pitch slide target
	ld hl, CHANNEL_PITCH_SLIDE_TARGET
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	ld hl, CHANNEL_PITCH_SLIDE_TARGET + 1
	add hl, bc
	sub [hl]
	ld d, a
.resume
	; de = x * [wCurNoteDuration] + y
	; x + 1 -> d
	; y -> a
	push bc
	ld hl, wCurNoteDuration
	ld b, 0 ; quotient
.loop
	inc b
	ld a, e
	sub [hl]
	ld e, a
	jr nc, .loop
	ld a, d
	and a
	jr z, .quit
	dec d
	jr .loop

.quit
	ld a, e ; remainder
	add [hl]
	ld d, b ; quotient
	pop bc
	ld hl, CHANNEL_PITCH_SLIDE_AMOUNT
	add hl, bc
	ld [hl], d ; quotient
	ld hl, CHANNEL_PITCH_SLIDE_AMOUNT_FRACTION
	add hl, bc
	ld [hl], a ; remainder
	ld hl, CHANNEL_FIELD25
	add hl, bc
	xor a
	ld [hl], a
	ret

HandleTrackVibrato:
; handle duty, cry pitch, and vibrato
	bc_offset CHANNEL_FLAGS2
	bit SOUND_DUTY_LOOP, [hl] ; duty cycle looping
	jr z, .next
	ld hl, CHANNEL_DUTY_CYCLE_PATTERN
	add hl, bc
	ld a, [hl]
	rlca
	rlca
	ld [hl], a
	and $c0
	ld [wCurTrackDuty], a
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_DUTY_OVERRIDE, [hl]
.next
	bc_offset CHANNEL_FLAGS2
	bit SOUND_PITCH_OFFSET, [hl]
	jr z, .pitch_inc
	ld hl, CHANNEL_PITCH_OFFSET
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wCurTrackFrequency
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, wCurTrackFrequency
	ld [hl], e
	inc hl
	ld [hl], d
.pitch_inc
	; is pitch inc on?
	bc_offset CHANNEL_FLAGS1
	bit SOUND_PITCH_INC_SWITCH, [hl]
	jr z, .vibrato
	; frenquency is now de
	ld hl, wCurTrackFrequency
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_PITCH_INC_SWITCH
	add hl, bc
	; is the byte active?
	ld a, [hl]
	and a
	jr z, .skip
	; if so, inc the pitch by 1
	inc e
	jr nc, .skip
	; inc d if e rolls over
	inc d
.skip
	ld hl, wCurTrackFrequency
	ld [hl], e
	inc hl
	ld [hl], d
.vibrato
	; is vibrato on?
	bc_offset CHANNEL_FLAGS2
	bit SOUND_VIBRATO, [hl] ; vibrato
	jr z, .quit
	; is vibrato active for this note yet?
	; is the delay over?
	bc_offset CHANNEL_VIBRATO_DELAY_COUNT
	ld a, [hl]
	and a
	jr nz, .subexit
	; is the extent nonzero?
	ld hl, CHANNEL_VIBRATO_EXTENT
	add hl, bc
	ld a, [hl]
	and a
	jr z, .quit
	; save it for later
	ld d, a
	; is it time to toggle vibrato up/down?
	ld hl, CHANNEL_VIBRATO_RATE
	add hl, bc
	ld a, [hl]
	and $f ; count
	jr z, .toggle
.subexit
	dec [hl]
	jr .quit

.toggle
	; refresh count
	ld a, [hl]
	swap [hl]
	or [hl]
	ld [hl], a
	; ????
	ld a, [wCurTrackFrequency]
	ld e, a
	; toggle vibrato up/down
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	bit SOUND_VIBRATO_DIR, [hl] ; vibrato up/down
	jr z, .down
; up
	; vibrato down
	res SOUND_VIBRATO_DIR, [hl]
	; get the delay
	ld a, d
	and $f ; lo
	;
	ld d, a
	ld a, e
	sub d
	jr nc, .no_carry
	ld a, 0
	jr .no_carry

.down
	; vibrato up
	set SOUND_VIBRATO_DIR, [hl]
	; get the delay
	ld a, d
	and $f0 ; hi
	swap a ; move it to lo
	;
	add e
	jr nc, .no_carry
	ld a, $ff
.no_carry
	ld [wCurTrackFrequency], a
	;
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_VIBRATO_OVERRIDE, [hl]
.quit
	ret

ApplyPitchSlide:
	; quit if pitch slide inactive
	bc_offset CHANNEL_FLAGS2
	bit SOUND_PITCH_SLIDE, [hl]
	ret z
	; de = Frequency
	bc_offset CHANNEL_FREQUENCY
	ld e, [hl]
	inc hl
	ld d, [hl]
	; check whether pitch slide is going up or down
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	bit SOUND_PITCH_SLIDE_DIR, [hl]
	jr z, .decreasing
	; frequency += [Channel*PitchSlideAmount]
	ld hl, CHANNEL_PITCH_SLIDE_AMOUNT
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, de
	ld d, h
	ld e, l
	; [Channel*Field25] += [Channel*PitchSlideAmountFraction]
	; if rollover: Frequency += 1
	ld hl, CHANNEL_PITCH_SLIDE_AMOUNT_FRACTION
	add hl, bc
	ld a, [hl]
	ld hl, CHANNEL_FIELD25
	add hl, bc
	add [hl]
	ld [hl], a
	; could have done "jr nc, .no_rollover / inc de / .no_rollover"
	ld a, 0
	adc e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	; Compare the dw at [Channel*PitchSlideTarget] to de.
	; If frequency is greater, we're finished.
	; Otherwise, load the frequency and set two flags.
	ld hl, CHANNEL_PITCH_SLIDE_TARGET + 1
	add hl, bc
	ld a, [hl]
	cp d
	jp c, .finished_pitch_slide
	jr nz, .continue_pitch_slide
	ld hl, CHANNEL_PITCH_SLIDE_TARGET
	add hl, bc
	ld a, [hl]
	cp e
	jp c, .finished_pitch_slide
	jr .continue_pitch_slide

.decreasing
	; frequency -= [Channel*PitchSlideAmount]
	ld a, e
	ld hl, CHANNEL_PITCH_SLIDE_AMOUNT
	add hl, bc
	ld e, [hl]
	sub e
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	; [Channel*Field25] *= 2
	; if rollover: Frequency -= 1
	ld hl, CHANNEL_PITCH_SLIDE_AMOUNT_FRACTION
	add hl, bc
	ld a, [hl]
	add a
	ld [hl], a
	; could have done "jr nc, .no_rollover / dec de / .no_rollover"
	ld a, e
	sbc 0
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	; Compare the dw at [Channel*PitchSlideTarget] to de.
	; If frequency is lower, we're finished.
	; Otherwise, load the frequency and set two flags.
	ld hl, CHANNEL_PITCH_SLIDE_TARGET + 1
	add hl, bc
	ld a, d
	cp [hl]
	jr c, .finished_pitch_slide
	jr nz, .continue_pitch_slide
	ld hl, CHANNEL_PITCH_SLIDE_TARGET
	add hl, bc
	ld a, e
	cp [hl]
	jr nc, .continue_pitch_slide
.finished_pitch_slide
	bc_offset CHANNEL_FLAGS2
	res SOUND_PITCH_SLIDE, [hl]
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	res SOUND_PITCH_SLIDE_DIR, [hl]
	ret

.continue_pitch_slide
	bc_offset CHANNEL_FREQUENCY
	ld [hl], e
	inc hl
	ld [hl], d
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_FREQ_OVERRIDE, [hl]
	set NOTE_DUTY_OVERRIDE, [hl]
	ret

HandleNoise:
	; is noise sampling on?
	bc_offset CHANNEL_FLAGS1
	bit SOUND_NOISE, [hl] ; noise sampling
	ret z
	; are we in a sfx channel?
	ld a, [wCurChannel]
	bit NOISE_CHAN_F, a
	jr nz, .next
	; is ch8 on? (noise)
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl] ; on?
	jr z, .next
	; is ch8 playing noise?
	bit SOUND_NOISE, [hl]
	ret nz ; quit if so
.next
	ld a, [wNoiseSampleDelay]
	and a
	jr z, ReadNoiseSample
	dec a
	ld [wNoiseSampleDelay], a
	ret

ReadNoiseSample:
; sample struct:
;	[wx] [yy] [zz]
;	w: ? either 2 or 3
;	x: duration
;	zz: volume envelope
;       yy: frequency

	; de = [wNoiseSampleAddress]
	ld hl, wNoiseSampleAddress
	ld e, [hl]
	inc hl
	ld d, [hl]

	; is it empty?
	ld a, e
	or d
	jr z, .quit

	ld a, [de]
	inc de

	cp sound_ret_cmd
	jr z, .quit

	and $f
;	inc a
	ld [wNoiseSampleDelay], a
	ld a, [de]
	inc de
	ld [wCurTrackVolumeEnvelope], a
	ld a, [de]
	inc de
	ld [wCurTrackFrequency], a
	xor a
	ld [wCurTrackFrequency + 1], a

	ld hl, wNoiseSampleAddress
	ld [hl], e
	inc hl
	ld [hl], d

	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_NOISE_SAMPLING, [hl]

.quit
	ret

ParseMusic:
; parses until a note is read or the song is ended
	call GetMusicByte ; store next byte in a
	cp sound_ret_cmd
	jr z, .sound_ret
	cp FIRST_MUSIC_CMD
	jr c, .readnote
.readcommand
	call ParseMusicCommand
	jr ParseMusic ; start over

.readnote
	bc_offset CHANNEL_NOTE_FLAGS
	res NOTE_TEMP_MUTE, [hl] ; Rest
; wCurMusicByte contains current note
; special notes
	bc_offset CHANNEL_FLAGS1
	bit SOUND_READING_MODE, [hl]
	jp nz, ParseSFXOrCry
	bit SOUND_CRY, [hl]
	jp nz, ParseSFXOrCry
	bit SOUND_NOISE, [hl]
	jp nz, GetNoiseSample
; normal note
	; set note duration (bottom nybble)
	ld a, [wCurMusicByte]
	and $f
	call SetNoteDuration
	; get note pitch (top nybble)
	ld a, [wCurMusicByte]
	swap a
	and $f
	cp NUM_NOTES + 1
	jr z, .rest ; pitch 12 -> rest
	; update pitch
	bc_offset CHANNEL_PITCH
	ld [hl], a
	; store pitch in e
	ld e, a
	; store octave in d
	bc_offset CHANNEL_OCTAVE
	ld d, [hl]
	; update frequency
	call GetFrequency
	bc_offset CHANNEL_FREQUENCY
	ld [hl], e
	inc hl
	ld [hl], d
	; ????
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_NOISE_SAMPLING, [hl]
	jp LoadNote

.rest
; note = rest
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_REST, [hl] ; Rest
	ret

.sound_ret
; $ff is reached in music data
	bc_offset CHANNEL_FLAGS1
	bit SOUND_SUBROUTINE, [hl] ; in a subroutine?
	jr nz, .readcommand ; execute
	; sfx channel?
	ld a, [wCurChannel]
	cp CHAN5
	jr nc, .chan_5to8
	; currently in a music channel
	; check if the sfx equivalent is on
	bc_offset CHANNEL_STRUCT_LENGTH * NUM_MUSIC_CHANS + CHANNEL_FLAGS1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .ok
.chan_5to8
	bc_offset CHANNEL_FLAGS1
	bit SOUND_CRY, [hl]
	call nz, RestoreVolume
	; end music
	ld a, [wCurChannel]
	cp CHAN5
	jr nz, .ok
	; no sweep
	xor a
	ldh [rNR10], a ; sweep = 0
.ok
; stop playing
	; turn channel off
	bc_offset CHANNEL_FLAGS1
	res SOUND_CHANNEL_ON, [hl]
	ld a, [wCurChannel]
	bit NOISE_CHAN_F, a
	jr z, .music_chan
	maskbits NUM_MUSIC_CHANS
	cp CHAN3
	jr z, .wav
	bc_offset CHANNEL_FLAGS1
	set SOUND_RETURN, [hl]
	bc_offset CHANNEL_NOTE_FLAGS
	res NOTE_REST, [hl]
	jr .skip_rest
.wav
.music_chan
	; note = rest
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_REST, [hl]
.skip_rest
	; clear music id & bank
	bc_offset CHANNEL_MUSIC_ID
	xor a
	ld [hli], a ; id hi
	ld [hli], a ; id lo
	ld [hli], a ; bank
	ret

RestoreVolume:
	; ch5 only
	ld a, [wCurChannel]
	cp CHAN5
	ret nz
	xor a
	ld hl, wChannel6PitchOffset
	ld [hli], a
	ld [hl], a
	ld hl, wChannel8PitchOffset
	ld [hli], a
	ld [hl], a
	ld a, [wLastVolume]
	ld [wVolume], a
	xor a
	ld [wLastVolume], a
	ld [wSFXPriority], a
	ret

InitRetCounter:
	ld a, [wCurTrackVolumeEnvelope]
	swap a
	and $f
	ld d, a
	ld a, [wCurTrackVolumeEnvelope]
	and $7
	ret z
	ld e, a
	ld a, -1
.loop1
	add d
	dec e
	jr nz, .loop1
	bc_offset CHANNEL_RET_COUNTER
	ld [hl], a
	ret

UpdateRetCounter:
	bc_offset CHANNEL_RET_COUNTER
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

UpdateRetCounterAfterFF:
	bc_offset CHANNEL_RET_COUNTER
	ld a, [hl]
	and a
	jr z, .reset_flag
	dec [hl]
	jr z, .reset_flag
	bc_offset CHANNEL_TRACKS
	ld a, [wSoundOutput]
	or [hl]
	ld [wSoundOutput], a
	ret
.reset_flag
	bc_offset CHANNEL_FLAGS1
	res SOUND_CHANNEL_ON, [hl]
	res SOUND_RETURN, [hl]
	ret

GotSweep:
	call Music_PitchSweep
	jp ParseMusic

ParseSFXOrCry:
	ld a, [wCurMusicByte]
	cp pitch_sweep_cmd
	jr z, GotSweep
	; turn noise sampling on
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_NOISE_SAMPLING, [hl] ; noise sample
	; update note duration
	ld a, [wCurMusicByte]
	and $0f
	call SetNoteDuration
	; update volume envelope from next param
	call GetMusicByte
	bc_offset CHANNEL_VOLUME_ENVELOPE
	ld [hl], a
	; update lo frequency from next param
	call GetMusicByte
	bc_offset CHANNEL_FREQUENCY
	ld [hl], a
	; are we on the last channel? (noise sampling)
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp CHAN4
	ret z
	; update hi frequency from next param
	call GetMusicByte
	bc_offset CHANNEL_FREQUENCY  + 1
	ld [hl], a
	ret

GetNoiseSample:
; load ptr to sample header in wNoiseSampleAddress
	; are we on the last channel?
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp CHAN4
	; ret if not
	ret nz
	; update note duration
	ld a, [wCurMusicByte]
	and $f
	call SetNoteDuration
	ld a, [wCurMusicByte]
	swap a
	and $f
	cp NUM_NOTES + 1
	jr z, .rest
	cp B_
	jr nz, .getnoise
	call GetMusicByte
.getnoise
	bc_offset CHANNEL_PITCH
	ld [hl], a
	push af
	; check current channel
	ld a, [wCurChannel]
	bit NOISE_CHAN_F, a
	jr nz, .music
	pop af
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl] ; is ch8 on? (noise)
	jr z, .sfx
	ret
.rest
	xor a
	bc_offset CHANNEL_PITCH
	ld [hl], a
	ret
.music
	pop af
.sfx
	; load noise sample set id into de
	ld e, a
	ld d, 0
	; load ptr to noise sample set in hl
	ld hl, Drumkits
	add hl, de
	add hl, de
	; load sample pointer into wNoiseSampleAddress
	ld a, [hli]
	ld [wNoiseSampleAddress], a
	ld a, [hl]
	ld [wNoiseSampleAddress + 1], a
	; clear ????
	xor a
	ld [wNoiseSampleDelay], a
	ret

ParseMusicCommand:
	; reload command
	ld a, [wCurMusicByte]
	; get command #
	sub FIRST_MUSIC_CMD
	ld e, a
	ld d, 0
	; seek command pointer
	ld hl, MusicCommands
	add hl, de
	add hl, de
	; jump to the new pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

MusicCommands:
; entries correspond to audio constants (see macros/scripts/audio.asm)
	table_width 2, MusicCommands
	dw Music_NoteType ; note length + volume envelope
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_NoteType
	dw Music_Octave
	dw Music_Octave
	dw Music_Octave
	dw Music_Octave
	dw Music_Octave
	dw Music_Octave
	dw Music_Octave
	dw Music_Octave
	dw Music_PerfectPitch
	dw MusicDummy ; nothing
	dw Music_Vibrato
	dw Music_PitchSlide
	dw Music_DutyCycle
	dw Music_Tempo
	dw Music_GlobalStereoPanning
	dw Music_NewSong
	dw Music_Volume
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw Music_ExecuteMusic
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw MusicDummy ; nothing
	dw Music_DutyCyclePattern
	dw Music_Call
	dw Music_Loop
	dw Music_Ret
	assert_table_length $100 - FIRST_MUSIC_CMD

MusicDummy:
	ret

Music_Ret:
; called when $ff is encountered w/ subroutine flag set
; end music stream
; return to caller of the subroutine
	; reset subroutine flag
	bc_offset CHANNEL_FLAGS1
	res SOUND_SUBROUTINE, [hl]
	; copy LastMusicAddress to MusicAddress
	ld hl, CHANNEL_LAST_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Music_Call:
; call music stream (subroutine)
; parameters: ll hh ; pointer to subroutine
	; get pointer from next 2 bytes
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	push de
	; copy MusicAddress to LastMusicAddress
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_LAST_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	; load pointer into MusicAddress
	pop de
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	; set subroutine flag
	bc_offset CHANNEL_FLAGS1
	set SOUND_SUBROUTINE, [hl]
	ret

Music_Loop:
; loops xx - 1 times
; 	00: infinite
; params: 3
;	xx ll hh
;		xx : loop count
;   	ll hh : pointer

	; get loop count
	call GetMusicByte
	bc_offset CHANNEL_FLAGS1
	bit SOUND_LOOPING, [hl] ; has the loop been initiated?
	jr nz, .checkloop
	and a ; loop counter 0 = infinite
	jr z, .loop
	; initiate loop
	dec a
	set SOUND_LOOPING, [hl] ; set loop flag
	ld hl, CHANNEL_LOOP_COUNT
	add hl, bc
	ld [hl], a ; store loop counter
.checkloop
	ld hl, CHANNEL_LOOP_COUNT
	add hl, bc
	ld a, [hl]
	and a ; are we done?
	jr z, .endloop
	dec [hl]
.loop
	; get pointer
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	; load new pointer into MusicAddress
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.endloop
	; reset loop flag
	bc_offset CHANNEL_FLAGS1
	res SOUND_LOOPING, [hl]
	; skip to next command
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de ; skip
	inc de ; pointer
	ld [hl], d
	dec hl
	ld [hl], e
	ret

Music_Vibrato:
; vibrato
; params: 2
;	1: [xx]
	; delay in frames
;	2: [yz]
	; y: extent
	; z: rate (# frames per cycle)

	; set vibrato flag?
	bc_offset CHANNEL_FLAGS2
	set SOUND_VIBRATO, [hl]
	; start at lower frequency (extent is positive)
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	res SOUND_VIBRATO_DIR, [hl]
	; get delay
	call GetMusicByte
; update delay
	bc_offset CHANNEL_VIBRATO_DELAY
	ld [hl], a
; update delay count
	bc_offset CHANNEL_VIBRATO_DELAY_COUNT
	ld [hl], a
; update extent
; this is split into halves only to get added back together at the last second
	; get extent/rate
	call GetMusicByte
	ld hl, CHANNEL_VIBRATO_EXTENT
	add hl, bc
	ld d, a
	; get top nybble
	and $f0
	swap a
	srl a ; halve
	ld e, a
	adc 0 ; round up
	swap a
	or e
	ld [hl], a
; update rate
	ld hl, CHANNEL_VIBRATO_RATE
	add hl, bc
	; get bottom nybble
	ld a, d
	and $f
	ld d, a
	swap a
	or d
	ld [hl], a
	ret

Music_PitchSlide:
; set the target for pitch slide
; params: 2
; note duration
; target note
	call GetMusicByte
	ld [wCurNoteDuration], a

	call GetMusicByte
	; pitch in e
	ld d, a
	and $f
	ld e, a

	; octave in d
	ld a, d
	swap a
	and $f
	ld d, a
	call GetFrequency
	ld hl, CHANNEL_PITCH_SLIDE_TARGET
	add hl, bc
	ld [hl], e
	ld hl, CHANNEL_PITCH_SLIDE_TARGET + 1
	add hl, bc
	ld [hl], d
	bc_offset CHANNEL_FLAGS2
	set SOUND_PITCH_SLIDE, [hl]
	ret

Music_PerfectPitch:
; RSC equivalent to toggle_perfect_pitch
	bc_offset CHANNEL_FLAGS1
	set SOUND_PITCH_INC_SWITCH, [hl]
	ld hl, CHANNEL_PITCH_INC_SWITCH
	add hl, bc
	ld a, [hl]
	xor TRUE
	ld [hl], a ; flip bit 0 of CHANNEL_PITCH_INC_SWITCH
	ret

Music_DutyCyclePattern:
; sequence of 4 duty cycles to be looped
; params: 1 (4 2-bit duty cycle arguments)
	bc_offset CHANNEL_FLAGS2
	set SOUND_DUTY_LOOP, [hl] ; duty cycle looping
	; sound duty sequence
	call GetMusicByte
	rrca
	rrca
	ld hl, CHANNEL_DUTY_CYCLE_PATTERN
	add hl, bc
	ld [hl], a
	; update duty cycle
	and $c0 ; only uses top 2 bits
	bc_offset CHANNEL_DUTY_CYCLE
	ld [hl], a
	ret

Music_ExecuteMusic:
; execute_music
; params: none
	bc_offset CHANNEL_FLAGS1
	res SOUND_READING_MODE, [hl]
	ret

Music_PitchSweep:
; update pitch sweep
; params: 1
	call GetMusicByte
	ld [wPitchSweep], a
	bc_offset CHANNEL_NOTE_FLAGS
	set NOTE_PITCH_SWEEP, [hl]
	ret

Music_DutyCycle:
; duty cycle
; params: 1
	call GetMusicByte
	rrca
	rrca
	and $c0
	bc_offset CHANNEL_DUTY_CYCLE
	ld [hl], a
	ret

Music_NoteType:
; note length
;	# frames per 16th note
; params: 2
;	hi: volume
;	lo: fade
	; note length
	ld a, [wCurMusicByte]
	and $f
	ld hl, CHANNEL_NOTE_LENGTH
	add hl, bc
	ld [hl], a
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp CHAN4
	ret z
	; volume envelope
	call GetMusicByte
	bc_offset CHANNEL_VOLUME_ENVELOPE
	ld [hl], a
	ret

Music_Tempo:
; global tempo
; params: 2
;	de: tempo
	call GetMusicByte
	ld d, a
	call GetMusicByte
	ld e, a
	call SetGlobalTempo
	ret

Music_Octave:
; set octave based on lo nybble of the command
	bc_offset CHANNEL_OCTAVE
	ld a, [wCurMusicByte]
	and 7
	ld [hl], a
	ret

Music_GlobalStereoPanning:
; global panning
; present in pokered/yoshi
; only used in red
; params: 1
	call GetMusicByte
	ld e, a
	ld hl, SpeakerTracks
	ld a, [wCurChannel]
	and NUM_MUSIC_CHANS
	ld a, [hli]
	jr nz, .sfx
	and e
	ld [wChannel1Tracks], a
	ld a, [hli]
	and e
	ld [wChannel2Tracks], a
	ld a, [hli]
	and e
	ld [wChannel3Tracks], a
	ld a, [hl]
	and e
	ld [wChannel4Tracks], a
	ret
.sfx
	and e
	ld [wChannel5Tracks], a
	ld a, [hli]
	and e
	ld [wChannel6Tracks], a
	ld a, [hli]
	and e
	ld [wChannel7Tracks], a
	ld a, [hl]
	and e
	ld [wChannel8Tracks], a
	ret

Music_Volume:
; set volume
; params: 1
;	see Volume
	; read param even if it's not used
	call GetMusicByte
	; is the song fading?
	ld a, [wMusicFade]
	and a
	ret nz
	; reload param
	ld a, [wCurMusicByte]
	; set volume
	ld [wVolume], a
	ret

Music_NewSong:
; new song
; params: 2
;	de: song id
	call GetMusicByte
	ld e, a
	ld d, 0
	push bc
	call _PlayMusic
	pop bc
	ret

GetMusicByte:
; returns byte from current address in a
; advances to next byte in music data
; input: bc = start of current channel
	push hl
	push de
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld hl, CHANNEL_MUSIC_BANK
	add hl, bc
	ld a, [hl]
	call _LoadMusicByte ; load data into [wCurMusicByte]
	inc de ; advance to next byte for next time this is called
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	pop de
	pop hl
	ld a, [wCurMusicByte]
	ret

GetFrequency:
; generate frequency
; input:
; 	d: octave
;	e: pitch
; output:
; 	de: frequency

; get octave
	; get octave
	ld a, d
	push af ; we'll use this later
	; add pitch
	ld a, e
	rla
	ld l, a
	ld h, 0
	ld de, FrequencyTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop af ; retrieve octave
	; shift right by [7 - octave] bits
.loop
	; [7 - octave] loops
	cp $7
	jr nc, .ok
	; sra de
	sra d
	rr e
	inc a
	jr .loop

.ok
	ld a, d
	and $7 ; top 3 bits for frequency (11 total)
	ld d, a
	ret

SetNoteDuration:
; input: a = note duration in 16ths
	; store delay units in de
	inc a
	ld e, a
	ld d, 0
	ld hl, CHANNEL_NOTE_LENGTH
	add hl, bc
	ld a, [hl]
	; multiply NoteLength by delay units
	ld l, 0 ; just multiply
	call .Multiply
	ld a, l ; low
	; store Tempo in de
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	; add ???? to the next result
	ld hl, CHANNEL_NOTE_DURATION + 1
	add hl, bc
	ld l, [hl]
	; multiply Tempo by last result (NoteLength * LOW(delay))
	call .Multiply
	; copy result to de
	ld e, l
	ld d, h
	; store result in ????
	ld hl, CHANNEL_NOTE_DURATION + 1
	add hl, bc
	ld [hl], e
	; store result in NoteDuration
	bc_offset CHANNEL_NOTE_DURATION
	ld [hl], d
	ret

.Multiply:
; multiplies a and de
; adds the result to l
; stores the result in hl
	ld h, 0
.loop
	; halve a
	srl a
	; is there a remainder?
	jr nc, .skip
	; add it to the result
	add hl, de
.skip
	; add de, de
	sla e
	rl d
	; are we done?
	and a
	jr nz, .loop
	ret

SetGlobalTempo:
	push bc ; save current channel
	; are we dealing with music or sfx?
	ld a, [wCurChannel]
	cp CHAN5
	jr nc, .sfxchannels
	ld bc, wChannel1
	call Tempo
	ld bc, wChannel2
	call Tempo
	ld bc, wChannel3
	call Tempo
	ld bc, wChannel4
	call Tempo
	jr .end

.sfxchannels
	ld bc, wChannel5
	call Tempo
	ld bc, wChannel6
	call Tempo
	ld bc, wChannel7
	call Tempo
	ld bc, wChannel8
	call Tempo
.end
	pop bc ; restore current channel
	ret

Tempo:
; input:
; 	de: note length
	; update Tempo
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	; clear subdivision sum
	xor a
	ld hl, CHANNEL_NOTE_DURATION + 1
	add hl, bc
	ld [hl], a
	ret

StartChannel:
	call SetLRTracks
	bc_offset CHANNEL_FLAGS1
	set SOUND_CHANNEL_ON, [hl] ; turn channel on
	ret

SetLRTracks:
; set tracks for a the current channel to default
; seems to be redundant since this is overwritten by stereo data later
	push de
	; store current channel in de
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	ld e, a
	ld d, 0
	ld hl, SpeakerTracks
	add hl, de ; de = channel 0-3
	ld a, [hl]
	; load lr tracks into Tracks
	bc_offset CHANNEL_TRACKS
	ld [hl], a
	pop de
	ret

_PlayMusic::
; load music
	call MusicOff
	ld hl, wMusicID
	ld [hl], e ; song number
	inc hl
	ld [hl], d ; (always 0)
	ld hl, Music
	add hl, de ; three
	add hl, de ; byte
	add hl, de ; pointer
	ld a, [hli]
	ld [wMusicBank], a
	ld e, [hl]
	inc hl
	ld d, [hl] ; music header address
	call LoadMusicByte ; store first byte of music header in a
	rlca
	rlca
	maskbits NUM_MUSIC_CHANS
	inc a
.loop
; start playing channels
	push af
	call LoadChannel
	call StartChannel
	pop af
	dec a
	jr nz, .loop
	xor a
	ld [wChannel1JumpCondition], a
	ld [wChannel2JumpCondition], a
	ld [wChannel3JumpCondition], a
	ld [wChannel4JumpCondition], a
	ld [wNoiseSampleAddress], a
	ld [wNoiseSampleAddress + 1], a
	ld [wNoiseSampleDelay], a
	call MusicOn
	ret

_PlayCry::
; Play cry de using parameters:
;	wCryPitch
;	wCryLength

	call MusicOff

	ld hl, rNR10
	ld [hl], 0

; Overload the music id with the cry id
	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d

; 3-byte pointers (bank, address)
	ld hl, Cries
	add hl, de
	add hl, de
	add hl, de

	ld a, [hli]
	ld [wMusicBank], a

	ld e, [hl]
	inc hl
	ld d, [hl]

; Read the cry's sound header
	call LoadMusicByte
	; Top 2 bits contain the number of channels
	rlca
	rlca
	maskbits NUM_MUSIC_CHANS

; For each channel:
	inc a
.loop
	push af
	call LoadChannel ; bc = current channel

	ld a, [wLowHealthAlarm]
	bit DANGER_ON_F, a
	jr nz, .start

	bc_offset CHANNEL_FLAGS1
	set SOUND_CRY, [hl]

	bc_offset CHANNEL_FLAGS2
	set SOUND_PITCH_OFFSET, [hl]

	ld hl, CHANNEL_PITCH_OFFSET
	add hl, bc
	ld a, [wCryPitch]
	ld [hli], a
	ld a, [wCryPitch + 1]
	ld [hl], a

; No tempo for channel 4
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp CHAN4
	jr nc, .start

; Tempo is effectively length
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld a, [wCryLength]
	ld [hli], a
	ld a, [wCryLength + 1]
	ld [hl], a
.start
	call StartChannel
	pop af
	dec a
	jr nz, .loop

; Cries play at max volume, so we save the current volume for later.
	ld a, [wLastVolume]
	and a
	jr nz, .end

	ld a, [wVolume]
	ld [wLastVolume], a
	ld a, MAX_VOLUME
	ld [wVolume], a

.end
	ld a, 1 ; stop playing music
	ld [wSFXPriority], a
	call MusicOn
	ret

_PlaySFX::
; clear channels if they aren't already
	call MusicOff
.chscleared
; start reading sfx header for # chs
	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, SFX
	add hl, de ; three
	add hl, de ; byte
	add hl, de ; pointers
	; get bank
	ld a, [hli]
	ld [wMusicBank], a
	; get address
	ld e, [hl]
	inc hl
	ld d, [hl]
	; get # channels
	call LoadMusicByte
	rlca ; top 2
	rlca ; bits
	maskbits NUM_MUSIC_CHANS
	inc a ; # channels -> # loops
.startchannels
	push af
	call LoadChannel ; bc = current channel

	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	jr nz, .cant_cancel

	ld a, [wLowHealthAlarm]
	bit DANGER_ON_F, a
	jr nz, .cancel

.cant_cancel
	ld a, [wLowHealthAlarm]
	bit DANGER_ON_F, a
	jr nz, .start

	bc_offset CHANNEL_FLAGS2
	set SOUND_PITCH_OFFSET, [hl]

	ld hl, CHANNEL_PITCH_OFFSET
	add hl, bc
	ld a, [wSfxPitch]
	ld [hli], a
	ld a, [wSfxPitch + 1]
	ld [hl], a

; Tempo is effectively length
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld a, [wSfxLength]
	ld [hli], a
	ld a, [wSfxLength + 1]
	ld [hl], a
.start
	bc_offset CHANNEL_FLAGS1
	set SOUND_READING_MODE, [hl]
	call StartChannel
.cancel
	pop af
	dec a
	jr nz, .startchannels
	call MusicOn
	xor a
	ld [wSFXPriority], a
	ret

LoadChannel:
; input: de = audio pointer
; sets bc to current channel pointer
	call LoadMusicByte
	inc de
	maskbits NUM_CHANNELS
	ld [wCurChannel], a
	ld c, a
	ld b, 0
	ld hl, ChannelPointers
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl] ; bc = channel pointer
	bc_offset CHANNEL_FLAGS1
	res SOUND_CHANNEL_ON, [hl] ; channel off
	call ChannelInit
	; load music pointer
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	call LoadMusicByte
	ld [hli], a
	inc de
	call LoadMusicByte
	ld [hl], a
	inc de
	; load music id
	bc_offset CHANNEL_MUSIC_ID
	ld a, [wMusicID]
	ld [hli], a
	ld a, [wMusicID + 1]
	ld [hl], a
	; load music bank
	ld hl, CHANNEL_MUSIC_BANK
	add hl, bc
	ld a, [wMusicBank]
	ld [hl], a
	ret

ChannelInit:
; make sure channel is cleared
; set default tempo and note length in case nothing is loaded
; input:
;   bc = channel struct pointer
	push de
	xor a
	; get channel struct location and length
	ld hl, CHANNEL_MUSIC_ID ; start
	add hl, bc
	ld e, CHANNEL_STRUCT_LENGTH ; channel struct length
	; clear channel
.loop
	ld [hli], a
	dec e
	jr nz, .loop
	; set tempo to default ($100)
	ld hl, CHANNEL_TEMPO
	add hl, bc
	xor a
	ld [hli], a
	inc a
	ld [hl], a
	; set note length to default ($1) (fast)
	ld hl, CHANNEL_NOTE_LENGTH
	add hl, bc
	ld [hl], a
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	jr nz, .nosweep
	ldh [rNR10], a
.nosweep
	cp CHAN4
	jr nz, .skip_bit_set
	bc_offset CHANNEL_FLAGS1
	set SOUND_NOISE, [hl]
.skip_bit_set
	ld a, [wCurChannel]
	ld e, a
	ld d, 0
	ld hl, wSavedOctaves
	add hl, de
	ld a, [hl]
	bc_offset CHANNEL_OCTAVE
	ld [hl], a
	pop de
	ret

LoadMusicByte::
; input:
;   de = current music address
; output:
;   a = wCurMusicByte
	ld a, [wMusicBank]
	call _LoadMusicByte
	ld a, [wCurMusicByte]
	ret

INCLUDE "audio/notes.asm"

INCLUDE "audio/wave_samples.asm"

INCLUDE "audio/drumkits.asm"

SpeakerTracks:
; bit corresponds to track #
; hi: left channel
; lo: right channel
	db $11, $22, $44, $88

ChannelPointers:
	table_width 2, ChannelPointers
; music channels
	dw wChannel1
	dw wChannel2
	dw wChannel3
	dw wChannel4
	assert_table_length NUM_MUSIC_CHANS
; sfx channels
	dw wChannel5
	dw wChannel6
	dw wChannel7
	dw wChannel8
	assert_table_length NUM_CHANNELS

ClearChannels::
; runs ClearChannel for all 4 channels
; doesn't seem to be used, but functionally identical to InitSound
	ld hl, rNR50
	xor a
	ld [hli], a
	ld [hli], a
	ld a, $80
	ld [hli], a
	ld hl, rNR10
	ld e, NUM_MUSIC_CHANS
.loop
	call ClearChannel
	dec e
	jr nz, .loop
	ret

ClearChannel:
; input: hl = beginning hw sound register (rNR10, rNR20, rNR30, rNR40)
; output: 00 00 80 00 80

;   sound channel   1      2      3      4
	xor a
	ld [hli], a ; rNR10, rNR20, rNR30, rNR40 ; sweep = 0

	ld [hli], a ; rNR11, rNR21, rNR31, rNR41 ; length/wavepattern = 0
	ld a, $8
	ld [hli], a ; rNR12, rNR22, rNR32, rNR42 ; envelope = 0
	xor a
	ld [hli], a ; rNR13, rNR23, rNR33, rNR43 ; frequency lo = 0
	ld a, $80
	ld [hli], a ; rNR14, rNR24, rNR34, rNR44 ; restart sound (freq hi = 0)
	ret

PlayTrainerEncounterMusic::
; input: e = trainer type
	; turn fade off
	xor a
	ld [wMusicFade], a
	; play nothing for one frame
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	; play new song
	call MaxVolume
	pop de
	ld d, $00
	ld hl, TrainerEncounterMusic
	add hl, de
	ld e, [hl]
	call PlayMusic
	ret
