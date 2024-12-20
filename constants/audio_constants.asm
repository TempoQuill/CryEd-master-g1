; pitch
; FrequencyTable indexes (see audio/notes.asm)
	const_def
	const C_ ; 1
	const C# ; 2
	const D_ ; 3
	const D# ; 4
	const E_ ; 5
	const F_ ; 6
	const F# ; 7
	const G_ ; 8
	const G# ; 9
	const A_ ; a
	const A# ; b
	const B_ ; c
NUM_NOTES EQU const_value - 1

; channel
; ChannelPointers indexes (see audio/engine.asm)
	const_def
	const CHAN1 ; 0
	const CHAN2 ; 1
	const CHAN3 ; 2
	const CHAN4 ; 3
NUM_MUSIC_CHANS EQU const_value
	const CHAN5 ; 4
	const CHAN6 ; 5
	const CHAN7 ; 6
	const CHAN8 ; 7
NUM_NOISE_CHANS EQU const_value - NUM_MUSIC_CHANS
NUM_CHANNELS EQU const_value

; channel_struct members (see macros/wram.asm)
rsreset
CHANNEL_MUSIC_ID                    rw
CHANNEL_MUSIC_BANK                  rb
CHANNEL_FLAGS1                      rb
CHANNEL_FLAGS2                      rb
CHANNEL_FLAGS3                      rb
CHANNEL_MUSIC_ADDRESS               rw
CHANNEL_LAST_MUSIC_ADDRESS          rw
                                    rb_skip 2
CHANNEL_NOTE_FLAGS                  rb
CHANNEL_RET_COUNTER                 rb
CHANNEL_DUTY_CYCLE                  rb
CHANNEL_VOLUME_ENVELOPE             rb
CHANNEL_FREQUENCY                   rw
CHANNEL_PITCH                       rb
CHANNEL_OCTAVE                      rb
CHANNEL_TRANSPOSITION               rb
CHANNEL_NOTE_DURATION               rw
CHANNEL_PITCH_INC_SWITCH            rb
CHANNEL_LOOP_COUNT                  rb
CHANNEL_TEMPO                       rw
CHANNEL_TRACKS                      rb
CHANNEL_DUTY_CYCLE_PATTERN          rb
CHANNEL_VIBRATO_DELAY_COUNT         rb
CHANNEL_VIBRATO_DELAY               rb
CHANNEL_VIBRATO_EXTENT              rb
CHANNEL_VIBRATO_RATE                rb
CHANNEL_PITCH_SLIDE_TARGET          rw
CHANNEL_PITCH_SLIDE_AMOUNT          rb
CHANNEL_PITCH_SLIDE_AMOUNT_FRACTION rb
CHANNEL_PITCH_SLIDE_TEMPO           rb
                                    rb_skip
CHANNEL_PITCH_OFFSET                rw
                                    rb_skip 4
CHANNEL_NOTE_LENGTH                 rb
                                    rb_skip 4
CHANNEL_STRUCT_LENGTH EQU _RS

NOISE_CHAN_F EQU 2 ; bit set in CHAN5-CHAN7

; Flags1
	const_def
	const SOUND_CHANNEL_ON       ; 0
	const SOUND_SUBROUTINE       ; 1
	const SOUND_LOOPING          ; 2
	const SOUND_READING_MODE     ; 3
	const SOUND_NOISE            ; 4
	const SOUND_CRY              ; 5
	const SOUND_PITCH_INC_SWITCH ; 6
	const SOUND_RETURN           ; 7

; Flags2
	const_def
	const SOUND_VIBRATO      ; 0
	const SOUND_PITCH_SLIDE  ; 1
	const SOUND_DUTY_LOOP    ; 2
	const_skip
	const SOUND_PITCH_OFFSET ; 4

; Flags3
	const_def
	const SOUND_VIBRATO_DIR     ; 0
	const SOUND_PITCH_SLIDE_DIR ; 1

; NoteFlags
	const_def
	const NOTE_DUTY_OVERRIDE    ; 0
	const NOTE_FREQ_OVERRIDE    ; 1
	const NOTE_TEMP_MUTE        ; 2
	const NOTE_PITCH_SWEEP      ; 3
	const NOTE_NOISE_SAMPLING   ; 4
	const NOTE_REST             ; 5
	const NOTE_VIBRATO_OVERRIDE ; 6

; wVolume
VOLUME_SO1_F     EQU 3
VOLUME_SO2_F     EQU 7
VOLUME_SO1_LEVEL EQU %00000111
VOLUME_SO2_LEVEL EQU %01110000
MAX_VOLUME       EQU $77

; wSoundInput
SOUND_INPUT_CH1_F    EQU 0
SOUND_INPUT_CH2_F    EQU 1
SOUND_INPUT_CH3_F    EQU 2
SOUND_INPUT_CH4_F    EQU 3
SOUND_INPUT_GLOBAL_F EQU 7

; wLowHealthAlarm
DANGER_PITCH_F EQU 4
DANGER_ON_F    EQU 7

; wMusicFade
MUSIC_FADE_IN_F EQU 7
