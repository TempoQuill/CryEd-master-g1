Drumkits:
	dw Drum00
	dw Snare1
	dw Snare2
	dw Snare3
	dw Snare4
	dw Drum05
	dw Triangle1
	dw Triangle2
	dw HiHat1
	dw Snare5
	dw Snare6
	dw Snare7
	dw HiHat2
	dw HiHat3
	dw Snare8
	dw Triangle3
	dw Triangle4
	dw Snare9
	dw Snare10
	dw Snare11

Drum00:
	sound_ret

Snare1:
	noise_note 0, 12, 1, 51
	sound_ret

Snare2:
	noise_note 0, 11, 1, 51
	sound_ret

Snare3:
	noise_note 0, 10, 1, 51
	sound_ret

Snare4:
	noise_note 0, 8, 1, 51
	sound_ret

Drum05:
	noise_note 7, 8, 4, 55
	noise_note 6, 8, 4, 54
	noise_note 5, 8, 3, 53
	noise_note 4, 8, 3, 52
	noise_note 3, 8, 2, 51
	noise_note 2, 8, 1, 50
	sound_ret

Triangle1:
	noise_note 0, 5, 1, 42
	sound_ret

Triangle2:
	noise_note 1, 4, 1, 43
	noise_note 0, 6, 1, 42
	sound_ret

HiHat1:
	noise_note 0, 8, 1, 16
	sound_ret

Snare5:
	noise_note 0, 8, 2, 35
	sound_ret

Snare6:
	noise_note 0, 8, 2, 37
	sound_ret

Snare7:
	noise_note 0, 8, 2, 38
	sound_ret

HiHat2:
	noise_note 0, 10, 1, 16
	sound_ret

HiHat3:
	noise_note 0, 10, 2, 17
	sound_ret

Snare8:
	noise_note 0, 10, 2, 80
	sound_ret

Triangle3:
	noise_note 0, 10, 1, 24
	noise_note 0, 3, 1, 51
	sound_ret

Triangle4:
	noise_note 2, 9, 1, 40
	noise_note 0, 7, 1, 24
	sound_ret

Snare9:
	noise_note 0, 9, 1, 34
	sound_ret

Snare10:
	noise_note 0, 7, 1, 34
	sound_ret

Snare11:
	noise_note 0, 6, 1, 34
	sound_ret
