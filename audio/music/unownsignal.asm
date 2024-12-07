Music_UnownSignal:
	channel_count 3
	channel 1, Music_UnownSignal_Ch1
	channel 2, Music_UnownSignal_Ch2
	channel 3, Music_UnownSignal_Ch3

Music_UnownSignal_Ch1:
	tempo 160
	volume 7, 7
	toggle_perfect_pitch
	vibrato 0, 15, 0
.mainloop:
	note_type 6, 7, 1
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 8
	note_type 12, 10, 1
	rest 16
	rest 16
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 4
	note G_, 1
	octave 5
	note C_, 8
	rest 16
	rest 16
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 8
	rest 16
	sound_loop 0, .mainloop

Music_UnownSignal_Ch2:
	duty_cycle 1
	vibrato 1, 14, 0
.mainloop:
	note_type 6, 8, 1
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 8
	rest 16
	rest 16
	rest 16
	rest 16
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 4
	note G_, 1
	octave 5
	note C_, 8
	rest 16
	rest 16
	sound_loop 0, .mainloop

Music_UnownSignal_Ch3:
	note_type 6, 1, 4
.mainloop:
	octave 2
	note C_, 1
	note C#, 1
	note C_, 1
	rest 16
	sound_loop 0, .mainloop