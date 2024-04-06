Music_Surf:
; move header to header file to port to RBY
	channel_count 3
	channel 1, Music_Surf_Ch1
	channel 2, Music_Surf_Ch2
	channel 3, Music_Surf_Ch3
	channel 4 ; unused

Music_Surf_Ch1:
	tempo 256
	volume 7, 7
	toggle_perfect_pitch
	duty_cycle 3
	note_type 8, 10, 2
	rest 2
	octave 3
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	note E_, 2
	note F#, 2
.mainloop:
	rest 2
	octave 4
	note C#, 2
	note C#, 4
	note C#, 2
	octave 3
	note B_, 2
	rest 2
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	note A_, 2
	note A_, 4
	note A_, 2
	note A_, 2
	vibrato 8, 3, 2
	note_type 8, 10, 4
	octave 4
	note F#, 4
	note E_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	vibrato 0, 0, 0
	note_type 8, 10, 2
	octave 4
	note C#, 2
	note C#, 4
	note C#, 2
	octave 3
	note B_, 2
	rest 2
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	note A_, 2
	note A_, 4
	note A_, 2
	note A_, 2
	vibrato 8, 3, 2
	note_type 8, 10, 4
	octave 4
	note F#, 4
	note E_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	vibrato 0, 0, 0
	note_type 8, 10, 2
	note A_, 2
	note A_, 4
	note A_, 2
	note A_, 2
	rest 2
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	octave 4
	note C#, 2
	note C#, 4
	note C#, 2
	note C#, 2
	rest 2
	octave 3
	note A_, 2
	note A_, 4
	note A_, 2
	note A_, 2
	rest 2
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	octave 4
	note C#, 2
	note C#, 4
	note C#, 2
	note C#, 2
	rest 2
	octave 3
	note B_, 2
	note B_, 4
	octave 4
	note C#, 2
	note C#, 2
	rest 2
	octave 3
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	note A_, 2
	note A_, 4
	note A_, 2
	note A_, 2
	rest 2
	note A_, 2
	note A_, 4
	octave 4
	note D_, 2
	note D_, 2
	rest 2
	octave 3
	note B_, 2
	note B_, 4
	octave 4
	note C#, 2
	note C#, 2
	rest 2
	octave 3
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 2
	rest 2
	note A_, 2
	note A_, 4
	note A_, 2
	note A_, 2
	rest 2
	note A_, 2
	note A_, 4
	note A_, 2
	note B_, 2
	sound_loop 0, .mainloop

Music_Surf_Ch2:
	duty_cycle 3
	vibrato 16, 4, 4
	note_type 8, 12, 7
	octave 3
	note E_, 6
	note F#, 6
	note G#, 4
	note A_, 2
	note B_, 2
	vibrato 20, 2, 4
	octave 4
	note C#, 2
	note D_, 2
.mainloop:
	duty_cycle 2
	octave 4
	note E_, 8
	note E_, 2
	note D_, 2
	note C#, 6
	octave 3
	note B_, 4
	note E_, 2
	octave 4
	note D_, 8
	note D_, 2
	note C#, 2
	octave 3
	note B_, 6
	note A_, 4
	note B_, 2
	octave 4
	note E_, 8
	note E_, 2
	note D_, 2
	note C#, 6
	octave 3
	note B_, 4
	note E_, 2
	octave 4
	note D_, 8
	note D_, 2
	note C#, 2
	octave 3
	note B_, 6
	note A_, 6
	duty_cycle 3
	octave 4
	note F#, 8
	note G#, 2
	note A_, 2
	note A_, 6
	note G#, 4
	note F#, 2
	note E_, 6
	note E_, 2
	note F#, 2
	note G#, 2
	note B_, 6
	note A_, 4
	note G#, 2
	note F#, 8
	note G#, 2
	note A_, 2
	note A_, 6
	note G#, 4
	note F#, 2
	note E_, 6
	note E_, 2
	note F#, 2
	note G#, 2
	note B_, 6
	octave 5
	note C#, 6
	octave 3
	note B_, 2
	octave 4
	note C#, 6
	note E_, 2
	note F#, 2
	note G_, 6
	note F#, 6
	note C#, 2
	note D_, 6
	note C#, 2
	note D_, 2
	note E_, 4
	note D_, 2
	octave 3
	note A_, 6
	octave 3
	note B_, 2
	octave 4
	note C#, 6
	note E_, 2
	note F#, 2
	note G_, 6
	note F#, 6
	note C#, 2
	note D_, 6
	note C#, 2
	note D_, 2
	note E_, 4
	note D_, 2
	octave 3
	note A_, 2
	duty_cycle 2
	octave 4
	note C#, 2
	note D_, 2
	sound_loop 0, .mainloop

Music_Surf_Ch3:
	vibrato 16, 2, 3
	note_type 8, 1, 0
	octave 4
	note E_, 2
	note G#, 2
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	note G#, 2
.mainloop:
	note E_, 2
	note A_, 2
	note A_, 2
	note C#, 2
	note A_, 2
	note A_, 2
	note E_, 2
	note G_, 2
	note G_, 2
	note C#, 2
	note G_, 2
	note G_, 2
	note D_, 2
	note F#, 2
	note F#, 2
	octave 3
	note A_, 2
	octave 4
	note F#, 2
	note F#, 2
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	note F#, 4
	note A_, 2
	note E_, 2
	note A_, 2
	note A_, 2
	note C#, 2
	note A_, 2
	note A_, 2
	note E_, 2
	note G_, 2
	note G_, 2
	note C#, 2
	note G_, 2
	note G_, 2
	note D_, 2
	note F#, 2
	note F#, 2
	octave 3
	note A_, 2
	octave 4
	note F#, 2
	note F#, 2
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	note F#, 4
	note A_, 2
	note D_, 2
	note F#, 2
	note F#, 2
	octave 3
	note A_, 2
	octave 4
	note F#, 2
	note F#, 2
	note E_, 2
	note G#, 2
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	note G#, 2
	note E_, 2
	note A_, 2
	note A_, 2
	note C#, 2
	note A_, 2
	note A_, 2
	note D_, 2
	note F#, 2
	note F#, 2
	octave 3
	note A_, 2
	octave 4
	note F#, 2
	note F#, 2
	note E_, 2
	note G#, 2
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	note G#, 2
	note E_, 2
	note G#, 2
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	note G#, 2
	note E_, 2
	note A_, 2
	note A_, 2
	note C#, 2
	note A_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note A_, 2
	note C#, 2
	note A_, 2
	note A_, 2
	note E_, 2
	note G_, 2
	note G_, 2
	note C#, 2
	note G_, 2
	note G_, 2
	note D_, 2
	note F#, 2
	note F#, 2
	octave 3
	note A_, 2
	octave 4
	note F#, 2
	note F#, 2
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	note F#, 4
	note A_, 2
	note E_, 2
	note A_, 2
	note A_, 2
	note C#, 2
	note A_, 2
	note A_, 2
	note E_, 2
	note G_, 2
	note G_, 2
	note C#, 2
	note G_, 2
	note G_, 2
	note D_, 2
	note F#, 2
	note F#, 2
	octave 3
	note A_, 2
	octave 4
	note F#, 2
	note F#, 2
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	note F#, 4
	note A_, 2
	sound_loop 0, .mainloop
