Music_LavenderTownHappy:
; move header to header file to port to RBY
	channel_count 4
	channel 1, Music_LavenderTownHappy_Ch1
	channel 2, Music_LavenderTownHappy_Ch2
	channel 3, Music_LavenderTownHappy_Ch3
	channel 4, Music_LavenderTownHappy_Ch4

Music_LavenderTownHappy_Ch1:
	tempo 152
	volume 7, 7
	vibrato 0, 2, 4
	duty_cycle 3
; P1-1
	note_type 12, 9, 1
	db	$cf
; P1-2
	db	$cf
; P1-3
	db	$cf
; P1-4
	db	$c7
	db	$e3,$b3
	db	$e2,$23
.mainloop:
; P1-5
	vibrato 0, 2, 4
	duty_cycle 3
	note_type 12, 9, 1
	db	$e3,$03
	db	$73
	db	$e2,$03
	db	$e3,$73
; P1-6
	db	$23
	db	$93
	db	$e2,$23
	db	$e3,$93
; P1-7
	db	$43
	db	$b3
	db	$e2,$43
	db	$e3,$b3
; P1-8
	db	$13
	db	$73
	db	$a3
	db	$73
; P1-9
	db	$03
	db	$53
	db	$e2,$03
	db	$e3,$53
; P1-10
	db	$03
	db	$63
	db	$b3
	db	$93
; P1-11
	db	$73
	db	$53
	db	$23
	db	$73
; P1-12
	db	$53
	db	$23
	db	$e4,$b3
	db	$73
; P1-13
	db	$e3,$03
	db	$73
	db	$e2,$03
	db	$e3,$73
; P1-14
	db	$23
	db	$93
	db	$e2,$23
	db	$e3,$93
; P1-15
	db	$43
	db	$b3
	db	$e2,$43
	db	$e3,$b3
; P1-16
	db	$13
	db	$73
	db	$a3
	db	$73
; P1-17
	db	$03
	db	$53
	db	$e2,$03
	db	$e3,$53
; P1-18
	db	$23
	db	$73
	db	$b3
	db	$73
; P1-19
	db	$73
	db	$53
	db	$23
	db	$73
; P1-20
	db	$e2,$03
	db	$e3,$73
	db	$43
	db	$03
; P1-21
	toggle_perfect_pitch
	vibrato 7, 5, 2
	duty_cycle 3
	note_type 12, 8, 5
	db	$e5,$51
	db	$41
	db	$51
	db	$71
	db	$93
	db	$03
; P1-22
	db	$23
	db	$03
	db	$e6,$77
; P1-23
	db	$e5,$51
	db	$41
	db	$51
	db	$71
	db	$93
	db	$03
; P1-24
	db	$93
	db	$73
	db	$53
	db	$43
; P1-25
	db	$51
	db	$41
	db	$51
	db	$71
	db	$93
	db	$43
; P1-26
	db	$23
	db	$61
	db	$71
	db	$93
	db	$43
; P1-27
	db	$57
	db	$73
	db	$43
; P1-28
	db	$27
	db	$77
	toggle_perfect_pitch
	sound_loop 0, .mainloop

Music_LavenderTownHappy_Ch2:
	vibrato 0, 2, 4
	duty_cycle 3
; P2-1
	note_type 12, 9, 1
	db	$e3,$03
	db	$73
	db	$b3
	db	$63
; P2-2
	db	$03
	db	$73
	db	$b3
	db	$63
; P2-3
	db	$03
	db	$73
	db	$b3
	db	$63
; P2-4
	db	$03
	db	$73
	duty_cycle 2
	vibrato 0, 4, 3
	note_type 12, 9, 7
	db	$e4,$43
	db	$53
.mainloop:
; P2-5
	db	$77
	db	$77
; P2-6
	db	$47
	db	$43
	db	$53
; P2-7
	db	$73
	db	$53
	db	$43
	db	$b3
; P2-8
	db	$19
	db	$11
	db	$21
	db	$41
; P2-9
	db	$59
	db	$71
	db	$51
	db	$41
; P2-10
	db	$27
	db	$e5,$93
	db	$e4,$23
; P2-11
	db	$4b
	db	$51
	db	$41
; P2-12
	db	$2b
	db	$41
	db	$51
; P2-13
	db	$77
	db	$77
; P2-14
	db	$47
	db	$43
	db	$53
; P2-15
	db	$73
	db	$53
	db	$43
	db	$b3
; P2-16
	db	$19
	db	$11
	db	$21
	db	$41
; P2-17
	db	$59
	db	$71
	db	$51
	db	$41
; P2-18
	db	$2b
	db	$01
	db	$21
; P2-19
	db	$0f
; P2-20
	db	$0f
; P2-21
	duty_cycle 3
	vibrato 0, 7, 4
	note_type 12, 11, 7
	db	$e6,$5f
; P2-22
	db	$0f
; P2-23
	db	$5f
; P2-24
	db	$0f
; P2-25
	db	$5f
; P2-26
	db	$6f
; P2-27
	db	$7f
; P2-28
	db	$77
	duty_cycle 2
	vibrato 0, 4, 3
	note_type 12, 9, 7
	db	$e4,$43
	db	$53
	sound_loop 0, .mainloop

Music_LavenderTownHappy_Ch3:
	vibrato 4, 2, 4
; P3-1
	note_type 12, 2, 2
	db	$cf
; P3-2
	db	$cf
; P3-3
	db	$cf
; P3-4
	db	$cf
.mainloop:
; P3-5
	note_type 12, 2, 2
	db	$e4,$0f
; P3-6
	db	$2f
; P3-7
	db	$4f
; P3-8
	db	$47
	db	$77
; P3-9
	db	$97
	db	$e3,$07
; P3-10
	db	$e4,$97
	db	$e3,$07
; P3-11
	db	$e4,$77
	db	$e3,$07
; P3-12
	db	$e4,$77
	db	$27
; P3-13
	db	$0f
; P3-14
	db	$2f
; P3-15
	db	$4f
; P3-16
	db	$47
	db	$77
; P3-17
	db	$e3,$07
	db	$e4,$77
; P3-18
	db	$b7
	db	$77
; P3-19
	db	$e5,$77
	db	$e4,$07
; P3-20
	db	$e5,$43
	db	$73
	db	$e4,$03
	db	$43
; P3-21
	note_type 12, 1, 3
	db	$91
	db	$71
	db	$91
	db	$b1
	db	$e3,$03
	db	$e4,$73
; P3-22
	db	$53
	db	$43
	db	$23
	db	$03
; P3-23
	db	$91
	db	$71
	db	$91
	db	$b1
	db	$e3,$03
	db	$e4,$73
; P3-24
	db	$e3,$53
	db	$43
	db	$23
	db	$03
; P3-25
	db	$e4,$91
	db	$71
	db	$91
	db	$b1
	db	$e3,$03
	db	$e4,$73
; P3-26
	db	$91
	db	$71
	db	$91
	db	$b1
	db	$e3,$03
	db	$13
; P3-27
	db	$2b
	db	$03
; P3-28
	db	$e4,$bf
	sound_loop 0, .mainloop

Music_LavenderTownHappy_Ch4:
; P4-1
	drum_speed 12
	rest 16
; P4-2
	rest 16
; P4-3
	rest 16
; P4-4
	rest 16
.mainloop:
; P4-5
	drum_speed 12
	drum_note 7, 8
	drum_note 7, 8
; P4-6
	drum_note 7, 8
	drum_note 7, 8
; P4-7
	drum_note 7, 8
	drum_note 7, 8
; P4-8
	drum_note 7, 8
	drum_note 7, 8
; P4-9
	drum_note 7, 8
	drum_note 7, 8
; P4-10
	drum_note 7, 8
	drum_note 7, 8
; P4-11
	drum_note 7, 8
	drum_note 7, 8
; P4-12
	drum_note 7, 8
	drum_note 7, 8
; P4-13
	drum_note 7, 8
	drum_note 7, 8
; P4-14
	drum_note 7, 8
	drum_note 7, 8
; P4-15
	drum_note 7, 8
	drum_note 7, 8
; P4-16
	drum_note 7, 8
	drum_note 7, 8
; P4-17
	drum_note 7, 8
	drum_note 7, 8
; P4-18
	drum_note 7, 8
	drum_note 7, 8
; P4-19
	drum_note 7, 8
	drum_note 7, 8
; P4-20
	drum_note 7, 8
	drum_note 7, 8
; P4-21
	rest 16
; P4-22
	rest 16
; P4-23
	rest 16
; P4-24
	rest 16
; P4-25
	rest 16
; P4-26
	rest 16
; P4-27
	rest 16
; P4-28
	rest 16
	sound_loop 0, .mainloop