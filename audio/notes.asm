FrequencyTable:
	table_width 2, FrequencyTable
	dw $f82c ; C_
	dw $f89d ; C#
	dw $f907 ; D_
	dw $f96b ; D#
	dw $f9ca ; E_
	dw $fa23 ; F_
	dw $fa77 ; F#
	dw $fac7 ; G_
	dw $fb12 ; G#
	dw $fb58 ; A_
	dw $fb9b ; A#
	dw $fbda ; B_
	assert_table_length NUM_NOTES + 1
