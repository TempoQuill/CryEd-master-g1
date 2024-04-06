Music_Route34:
; move header to header file to port to RBY
	channel_count 4
	channel 1, Music_Route34_Ch1
	channel 2, Music_Route34_Ch2
	channel 3, Music_Route34_Ch3
	channel 4, Music_Route34_Ch4

Music_Route34_Ch1:
	tempo 145
	volume 7, 7
	toggle_perfect_pitch
	duty_cycle 2
	note_type 12, 10, 2
	octave 3
	note G_, 3
	note G#, 1
	note_type 12, 11, 5
	note A#, 6
	note D#, 1
	note G_, 1
	note A#, 4
	note_type 12, 10, 2
	note A#, 3
	note G#, 1
	note_type 12, 11, 5
	note G_, 6
	note F_, 1
	note D#, 1
	note D_, 4
.mainloop:
	duty_cycle 0
	note_type 12, 11, 3
	note D#, 6
	note D#, 1
	note F_, 1
	note G_, 2
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note C#, 3
	octave 2
	note G#, 1
	note G#, 4
	note_type 12, 11, 5
	octave 3
	note C#, 8
	note_type 12, 11, 3
	note D#, 6
	note D#, 1
	note F_, 1
	note G_, 2
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note F_, 3
	note G_, 1
	note G#, 4
	note C#, 2
	octave 2
	note G#, 2
	octave 3
	note C#, 4
	note D#, 6
	octave 2
	note A#, 4
	octave 3
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note F_, 3
	note D#, 1
	note C#, 4
	note F_, 4
	note C#, 4
	note_type 12, 13, 1
	note C_, 3
	note D_, 1
	note_type 12, 11, 5
	note E_, 8
	note C_, 4
	note_type 12, 13, 1
	note G_, 3
	note B_, 1
	note_type 12, 11, 5
	octave 4
	note C_, 12
	note_type 12, 13, 1
	octave 3
	note C_, 3
	note D_, 1
	note_type 12, 11, 5
	note E_, 8
	note C_, 4
	note_type 12, 13, 1
	note D_, 3
	note C_, 1
	note_type 12, 11, 5
	octave 2
	note A#, 2
	octave 3
	note C_, 6
	note D_, 4
	note C_, 6
	note G_, 6
	note F_, 4
	note E_, 6
	note C_, 6
	octave 2
	note B_, 4
	note_type 12, 13, 1
	octave 3
	note C_, 3
	note D_, 1
	note_type 12, 11, 5
	note E_, 8
	note C_, 4
	note_type 12, 13, 1
	note D_, 3
	note E_, 1
	note_type 12, 11, 5
	note F_, 8
	note D_, 4
	note E_, 6
	note G_, 6
	note F_, 4
	note E_, 6
	note D_, 6
	note C_, 4
	note_type 12, 13, 1
	note D_, 2
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note_type 12, 11, 5
	note F_, 4
	note F_, 4
	note D#, 4
	note D_, 4
	octave 2
	note A#, 4
	octave 3
	note F_, 4
	note G_, 4
	note C_, 2
	note G_, 4
	note E_, 6
	note D_, 2
	note C_, 2
	note_type 12, 13, 1
	note G_, 3
	note F_, 1
	note_type 12, 11, 5
	note E_, 8
	note D_, 4
	sound_loop 0, .mainloop

Music_Route34_Ch2:
	duty_cycle 1
	vibrato 17, 3, 3
	note_type 12, 11, 2
	octave 3
	note D#, 2
	octave 2
	note A#, 1
	octave 3
	note D#, 1
	note_type 12, 14, 5
	note G_, 8
	note D#, 4
	note_type 12, 11, 2
	note A#, 2
	note G_, 1
	note A#, 1
	note_type 12, 14, 5
	octave 4
	note D#, 8
	octave 3
	note F_, 4
.mainloop:
	note_type 12, 14, 6
	octave 3
	note A#, 10
	note_type 12, 13, 3
	note G_, 2
	note A#, 2
	octave 4
	note G_, 2
	note_type 12, 13, 1
	note F_, 3
	note C#, 1
	note_type 12, 14, 6
	note C#, 4
	note_type 12, 11, 4
	octave 3
	note F_, 4
	note G#, 4
	note_type 12, 14, 6
	note A#, 10
	note_type 12, 13, 3
	note G_, 2
	note A#, 2
	octave 4
	note D#, 2
	note C#, 3
	note D#, 1
	note_type 12, 14, 6
	note F_, 4
	note_type 12, 11, 4
	octave 3
	note F_, 4
	note G#, 4
	note_type 12, 14, 6
	octave 4
	note G_, 10
	note_type 12, 13, 3
	note D#, 2
	note G_, 2
	note A#, 2
	note G#, 3
	note G_, 1
	note_type 12, 14, 6
	note F_, 4
	note_type 12, 11, 4
	octave 2
	note G#, 4
	octave 4
	note G#, 4
	note_type 12, 14, 0
	note G_, 16
	note_type 12, 14, 7
	note G_, 16
	duty_cycle 2
	note_type 12, 11, 6
	octave 3
	note G_, 6
	note F_, 6
	note E_, 4
	note D_, 6
	note E_, 6
	note F_, 4
	note_type 12, 11, 2
	note G_, 2
	note E_, 1
	note G_, 1
	note_type 12, 13, 5
	octave 4
	note C_, 12
	note_type 12, 11, 2
	octave 3
	note E_, 2
	note C_, 1
	note E_, 1
	note_type 12, 13, 5
	note G_, 8
	duty_cycle 1
	note_type 12, 11, 5
	note G_, 4
	duty_cycle 2
	note_type 12, 11, 6
	octave 3
	note G_, 6
	note F_, 6
	note E_, 4
	note A_, 6
	note G_, 6
	note F_, 4
	note_type 12, 11, 2
	octave 3
	note G_, 2
	note E_, 1
	note G_, 1
	note_type 12, 13, 5
	octave 4
	note C_, 12
	note_type 12, 11, 2
	octave 3
	note G_, 2
	note E_, 1
	note G_, 1
	note_type 12, 13, 5
	octave 4
	note C_, 12
	note_type 12, 11, 2
	octave 3
	note F_, 2
	note D_, 1
	note F_, 1
	note_type 12, 13, 5
	note A#, 12
	note_type 12, 11, 2
	note F_, 2
	note D_, 1
	note F_, 1
	note_type 12, 13, 5
	note A#, 8
	note B_, 4
	octave 4
	note C_, 6
	note G_, 6
	note F_, 2
	note E_, 2
	note C_, 12
	duty_cycle 1
	octave 2
	note B_, 4
	sound_loop 0, .mainloop

Music_Route34_Ch3:
	note_type 12, 1, 2
	octave 4
	note D#, 1
	rest 3
	note D#, 1
	rest 3
	note D#, 1
	rest 3
	note G_, 4
	note D#, 1
	rest 3
	note D#, 1
	rest 3
	note D#, 1
	rest 3
	octave 3
	note A#, 2
	octave 4
	note D_, 2
.mainloop:
	note D#, 1
	rest 1
	note G_, 4
	note D#, 1
	note D#, 1
	note D#, 1
	rest 1
	note D#, 1
	rest 1
	note G_, 4
	note C#, 1
	rest 1
	note F_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	rest 1
	note C#, 1
	rest 1
	note F_, 4
	note D#, 1
	rest 1
	note G_, 4
	note D#, 1
	note D#, 1
	note D#, 1
	rest 1
	note D#, 1
	rest 1
	note G_, 4
	note C#, 1
	rest 1
	note F_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	rest 1
	note C#, 1
	rest 1
	note F_, 4
	note D#, 1
	rest 1
	note G_, 4
	note D#, 1
	note D#, 1
	note D#, 1
	rest 1
	note D#, 1
	rest 1
	note G_, 4
	note C#, 1
	rest 1
	note F_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	rest 1
	note C#, 1
	rest 1
	note F_, 2
	note C#, 2
	note C_, 1
	rest 1
	note G_, 4
	note C_, 1
	note C_, 1
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note G_, 4
	note C_, 1
	rest 1
	note E_, 4
	note C_, 1
	note C_, 1
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note E_, 4
	note C_, 1
	rest 1
	note G_, 4
	note C_, 1
	note C_, 1
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note G_, 4
	note D_, 1
	rest 1
	note F_, 4
	note D_, 1
	note D_, 1
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 4
	note E_, 1
	rest 1
	note G_, 4
	note E_, 1
	note E_, 1
	note E_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 4
	note C_, 1
	rest 1
	note E_, 4
	note C_, 1
	note C_, 1
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note D_, 2
	note F_, 2
	note E_, 1
	rest 1
	note G_, 4
	note E_, 1
	note E_, 1
	note E_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 4
	note F_, 1
	rest 1
	note A_, 4
	note F_, 1
	note F_, 1
	note F_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 4
	note E_, 1
	rest 1
	note G_, 4
	note E_, 1
	note E_, 1
	note E_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 4
	note E_, 1
	rest 1
	note G_, 4
	note E_, 1
	note E_, 1
	note E_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 4
	note D_, 1
	rest 1
	note F_, 4
	note D_, 1
	note D_, 1
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 4
	note D_, 1
	rest 1
	note F_, 4
	note D_, 1
	note D_, 1
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 2
	note D_, 2
	note E_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note G_, 2
	sound_loop 0, .mainloop

Music_Route34_Ch4:
	drum_speed 6
	rest 16
	rest 16
	rest 16
	rest 8
	drum_note 4, 2
	drum_note 3, 2
	drum_note 2, 2
	drum_note 1, 2
.mainloop:
	drum_note 3, 8
	drum_note 2, 2
	drum_note 3, 2
	drum_note 4, 2
	drum_note 3, 2
	drum_note 2, 4
	drum_note 2, 8
	drum_note 4, 4
	drum_note 3, 4
	drum_note 2, 8
	drum_note 2, 2
	drum_note 4, 2
	drum_note 2, 4
	drum_note 2, 4
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 1
	drum_note 1, 1
	sound_loop 0, .mainloop
