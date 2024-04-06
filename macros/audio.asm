MACRO channel_count
	assert 0 < (\1) && (\1) <= NUM_MUSIC_CHANS, \
		"channel_count must be 1-{d:NUM_MUSIC_CHANS}"
	DEF _num_channels = \1 - 1
ENDM

MACRO channel
	assert 0 < (\1) && (\1) <= NUM_CHANNELS, \
		"channel id must be 1-{d:NUM_CHANNELS}"
	dn (_num_channels << 2), \1 - 1 ; channel id
	IF _NARG > 1
		dw \2 ; address
	ENDC
	DEF _num_channels = 0
ENDM

MACRO note
	dn (\1), (\2) - 1 ; pitch, length
ENDM

MACRO drum_note_short
	note \1, \2 ; drum instrument, length
ENDM

MACRO drum_note
	note 11, \2 ; length
	db \1 ; drum instrument
ENDM

MACRO rest
	note 12, \1 ; length
ENDM

MACRO square_note
	if \1 < 16
		db $20 + \1 ; length
	else
		db $2f
	endc
	if \3 < 0
		dn \2, %1000 | (\3 * -1) ; volume envelope
	else
		dn \2, \3 ; volume envelope
	endc
	dw \4 ; frequency
ENDM

MACRO noise_note
	if \1 < 16
		db $20 + \1 ; length
	else
		db $2f
	endc
	if \3 < 0
		dn \2, %1000 | (\3 * -1) ; volume envelope
	else
		dn \2, \3 ; volume envelope
	endc
	db \4 ; frequency
ENDM

; MusicCommands indexes (see audio/engine.asm)
	const_def $d0
DEF FIRST_MUSIC_CMD EQU const_value
DEF pitch_sweep_cmd EQU const_value - $c0

	const note_type_cmd ; $d0
MACRO note_type
	DEF note_type_speed = \1
	db note_type_cmd | note_type_speed ; note length
	if _NARG >= 2
		if \3 < 0
			dn \2, %1000 | (\3 * -1) ; volume envelope
		else
			dn \2, \3 ; volume envelope
		endc
	endc
ENDM

; only valid on the noise channel
MACRO drum_speed
	note_type \1 ; note length
ENDM

MACRO volume_envelope
	db note_type_cmd | note_type_speed ; note length
	if \2 < 0
		dn \1, %1000 | (\2 * -1) ; volume envelope
	else
		dn \1, \2 ; volume envelope
	endc
ENDM

	const_next $e0

	const octave_cmd ; $e0
MACRO octave
	assert 1 <= (\1) && (\1) <= 8, "octave must be 1-8"
	db octave_cmd + 8 - (\1) ; octave
ENDM

	const_next $e8

	const toggle_perfect_pitch_cmd ; $e8
MACRO toggle_perfect_pitch
	db toggle_perfect_pitch_cmd
ENDM

	const_skip

	const vibrato_cmd ; $ea
MACRO vibrato
	db vibrato_cmd
	db \1 ; delay
	if _NARG > 2
		dn \2, \3 ; extent, rate
	else
		db \2 ; LEGACY: Support for 1-arg extent
	endc
ENDM

	const pitch_slide_cmd ; $eb
MACRO pitch_slide
	db pitch_slide_cmd
	db \1 - 1 ; duration
	dn 8 - \2, \3 % 12 ; octave, pitch
ENDM

	const duty_cycle_cmd ; $ec
MACRO duty_cycle
	db duty_cycle_cmd
	db \1 ; duty cycle
ENDM

	const tempo_cmd ; $ed
MACRO tempo
	db tempo_cmd
	bigdw \1 ; tempo
ENDM

	const stereo_panning_cmd ; $ee
MACRO stereo_panning
	db stereo_panning_cmd
	dn \1, \2
ENDM

	const new_song_cmd ; $ef
MACRO new_song
	db new_song_cmd
	db \1 ; id
ENDM

	const volume_cmd ; $f0
MACRO volume
	db volume_cmd
	if _NARG > 1
		dn \1, \2 ; left volume, right volume
	else
		db \1 ; LEGACY: Support for 1-arg volume
	endc
ENDM

	const frame_swap_cmd
MACRO frame_swap
	db frame_swap_cmd
ENDM

	const_next $f8

	const set_music_cmd ; $f8
MACRO set_music
	db set_music_cmd
ENDM

	const_next $fc

	const duty_cycle_pattern_cmd ; $fc
MACRO duty_cycle_pattern
	db duty_cycle_pattern_cmd
	db (\1 << 6) | (\2 << 4) | (\3 << 2) | (\4 << 0) ; duty cycle pattern
ENDM

	const sound_call_cmd ; $fd
MACRO sound_call
	db sound_call_cmd
	dw \1 ; address
ENDM

	const sound_loop_cmd ; $fe
MACRO sound_loop
	db sound_loop_cmd
	db \1 ; count
	dw \2 ; address
ENDM

	const sound_ret_cmd ; $ff
MACRO sound_ret
	db sound_ret_cmd
ENDM

MACRO pitch_sweep
	db pitch_sweep_cmd
	if \2 < 0
		dn \1, %1000 | (\2 * -1) ; pitch sweep
	else
		dn \1, \2 ; pitch sweep
	endc
ENDM
