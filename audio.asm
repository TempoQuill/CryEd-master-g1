section "Audio stubs",rom0
; Audio interfaces.

SaveOctaves::
	push hl
	push de
	push bc
	push af
	ld a, [wChannel1Octave]
	ld [wSavedOctaves], a
	ld a, [wChannel2Octave]
	ld [wSavedOctaves + 1], a
	ld a, [wChannel3Octave]
	ld [wSavedOctaves + 2], a
	ld a, [wChannel5Octave]
	ld [wSavedSFXOctaves], a
	ld a, [wChannel6Octave]
	ld [wSavedSFXOctaves + 1], a
	ld a, [wChannel7Octave]
	ld [wSavedSFXOctaves + 2], a
	pop af
	pop bc
	pop de
	pop hl
	ret

InitSound::
	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSound)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	call _InitSound

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	pop af
	pop bc
	pop de
	pop hl
	ret

UpdateSound::
	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_UpdateSound)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	call _UpdateSound

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	pop af
	pop bc
	pop de
	pop hl
	ret

_LoadMusicByte::
; [wCurMusicByte] = [a:de]
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld a, [de]
	ld [wCurMusicByte], a
	ld a, BANK(LoadMusicByte)

	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret

PlayMusic::
; Play music de.

	push hl
	push de
	push bc
	push af

	call SaveOctaves
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic) ; aka BANK(_InitSound)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	call _InitSound
	ld a, e
	and a
	jr z, .nomusic

	call _PlayMusic
.nomusic
.end
	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

PlayCry::
; Play cry de.

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af

	; Cries are stuck in one bank.
	ld a, BANK(PokemonCries)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld hl, PokemonCries
rept MON_CRY_LENGTH
	add hl, de
endr

	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a

	ld a, BANK(_PlayCry)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	call _PlayCry

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	pop af
	pop bc
	pop de
	pop hl
	ret

PlayFlexibleSFX::
	push hl
	push de
	push bc
	push af
	; Is something already playing?
	call CheckSFX
	jr nc, .play

	; Does it have priority?
	ld a, [wCurSFX]
	cp e
	jr c, .done

.play
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlaySFX)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld a, e
	ld [wCurSFX], a
	call _PlaySFX

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a
.done
	pop af
	pop bc
	pop de
	pop hl
	ret

PlaySFX::
; Play sound effect de.
; Sound effects are ordered by priority (highest to lowest)

	push hl
	push de
	push bc
	push af

	; Is something already playing?
	call CheckSFX
	jr nc, .play

	; Does it have priority?
	ld a, [wCurSFX]
	cp e
	jr c, .done

.play
	push hl
	ld hl, wSfxPitch
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	inc a
	ld [hl], a
	pop hl
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlaySFX)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld a, e
	ld [wCurSFX], a
	call _PlaySFX

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

.done
	pop af
	pop bc
	pop de
	pop hl
	ret

WaitPlaySFX::
	call WaitSFX
	call PlaySFX
	ret

WaitSFX::
; infinite loop until sfx is done playing

	push hl

.wait
	ld hl, wChannel5Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel6Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel7Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel8Flags1
	bit 0, [hl]
	jr nz, .wait

	pop hl
	ret

IsSFXPlaying::
; Return carry if no sound effect is playing.
; The inverse of CheckSFX.
	push hl

	ld hl, wChannel5Flags1
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel6Flags1
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel7Flags1
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel8Flags1
	bit 0, [hl]
	jr nz, .playing

	pop hl
	scf
	ret

.playing
	pop hl
	and a
	ret

MaxVolume::
	ld a, MAX_VOLUME
	ld [wVolume], a
	ret

LowVolume::
	ld a, $33 ; 50%
	ld [wVolume], a
	ret

MinVolume::
	xor a
	ld [wVolume], a
	ret

FadeOutToMusic:: ; unreferenced
	ld a, 4
	ld [wMusicFade], a
	ret

FadeInToMusic::
	ld a, 4 | (1 << MUSIC_FADE_IN_F)
	ld [wMusicFade], a
	ret

CheckSFX::
; Return carry if any SFX channels are active.
	ld a, [wChannel5Flags1]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel6Flags1]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel7Flags1]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel8Flags1]
	bit 0, a
	jr nz, .playing
	and a
	ret
.playing
	scf
	ret

TerminateExpBarSound::
	xor a
	ld [wChannel5Flags1], a
	ld [wPitchSweep], a
	ldh [rNR10], a
	ldh [rNR11], a
	ldh [rNR12], a
	ldh [rNR13], a
	ldh [rNR14], a
	ret

ChannelsOff::
; Quickly turn off music channels
	xor a
	ld [wChannel1Flags1], a
	ld [wChannel2Flags1], a
	ld [wChannel3Flags1], a
	ld [wChannel4Flags1], a
	ld [wPitchSweep], a
	ret

SFXChannelsOff::
; Quickly turn off sound effect channels
	xor a
	ld [wChannel5Flags1], a
	ld [wChannel6Flags1], a
	ld [wChannel7Flags1], a
	ld [wChannel8Flags1], a
	ld [wPitchSweep], a
	ret


SECTION "Audio", ROMX[$4000],bank[1]

INCLUDE "audio/engine.asm"
INCLUDE "encounter_music.asm"
INCLUDE "audio/music_pointers.asm"
INCLUDE "audio/music/nothing.asm"
INCLUDE "audio/cry_pointers.asm"
INCLUDE "audio/sfx_pointers.asm"

SECTION "Songs 1", ROMX, bank[1]

INCLUDE "audio/music/route34.asm"
INCLUDE "audio/music/elmslab.asm"
INCLUDE "audio/music/gymbattle.asm"
INCLUDE "audio/music/championbattle.asm"
INCLUDE "audio/music/rby/finalbattle.asm"
INCLUDE "audio/music/rby/ssanne.asm"
INCLUDE "audio/music/silenthills.asm"
INCLUDE "audio/music/goldenrodcity.asm"
INCLUDE "audio/music/rby/vermilion.asm"
INCLUDE "audio/music/rby/titlescreen.asm"
INCLUDE "audio/music/alphinterior.asm"
INCLUDE "audio/music/rby/defeatedtrainer.asm"
INCLUDE "audio/music/rby/dungeon1.asm"
INCLUDE "audio/music/yoshi/starman.asm"
INCLUDE "audio/music/yoshi/vsmenu.asm"
SongsEnd1:

SECTION "Songs 2", ROMX, bank[2]

INCLUDE "audio/music/rby/routes1.asm"
INCLUDE "audio/music/rby/routes3.asm"
INCLUDE "audio/music/rby/routes4.asm"
INCLUDE "audio/music/rby/gymleaderbattle.asm"
INCLUDE "audio/music/rby/trainerbattle.asm"
INCLUDE "audio/music/rby/wildbattle.asm"
INCLUDE "audio/music/rby/pokecenter.asm"
INCLUDE "audio/music/rby/meetfemaletrainer.asm"
INCLUDE "audio/music/rby/meetmaletrainer.asm"
INCLUDE "audio/music/rby/dungeon2.asm"
INCLUDE "audio/music/rby/dungeon3.asm"
INCLUDE "audio/music/rby/cinnabarmansion.asm"
INCLUDE "audio/music/rby/museumguy.asm"
INCLUDE "audio/music/rby/gamecorner.asm"
INCLUDE "audio/music/bicycle.asm"
INCLUDE "audio/music/pokechannel.asm"
INCLUDE "audio/music/lighthouse.asm"
INCLUDE "audio/music/lakeofrage.asm"
INCLUDE "audio/music/rby/indigoplateau.asm"
INCLUDE "audio/music/route37.asm"
INCLUDE "audio/music/dragonsden.asm"
INCLUDE "audio/music/unownsignal.asm"
INCLUDE "audio/music/route26.asm"
INCLUDE "audio/music/ecruteakcity.asm"
INCLUDE "audio/music/rocketsignal.asm"
INCLUDE "audio/music/lavendertown.asm"
INCLUDE "audio/music/route30.asm"
INCLUDE "audio/music/rby/trade.asm"
SongsEnd2:

SECTION "Songs 3", ROMX[$4000], bank[3]

INCLUDE "audio/music/violetcity.asm"
INCLUDE "audio/music/route29.asm"
INCLUDE "audio/music/rby/halloffame.asm"
INCLUDE "audio/music/heal.asm"
INCLUDE "audio/music/rby/safarizone.asm"
INCLUDE "audio/music/rby/printer.asm"
INCLUDE "audio/music/rby/jigglypuffsong.asm"
INCLUDE "audio/music/rby/routes2.asm"
INCLUDE "audio/music/rby/credits.asm"
INCLUDE "audio/music/credits.asm"
INCLUDE "audio/music/postcredits.asm"

SECTION "Songs 4", ROMX, bank[4]

INCLUDE "audio/music/rby/cities1.asm"
INCLUDE "audio/music/rby/celadon.asm"
INCLUDE "audio/music/rby/cities2.asm"
INCLUDE "audio/music/rby/cinnabar.asm"
INCLUDE "audio/music/rby/lavender.asm"
INCLUDE "audio/music/rby/defeatedwildmon.asm"
INCLUDE "audio/music/rby/defeatedgymleader.asm"
INCLUDE "audio/music/mtmoonsquare.asm"
INCLUDE "audio/music/rby/gym.asm"
INCLUDE "audio/music/rby/pallettown.asm"
INCLUDE "audio/music/rby/oakslab.asm"
INCLUDE "audio/music/rby/meetprofoak.asm"
INCLUDE "audio/music/rby/meetrival.asm"
INCLUDE "audio/music/surf.asm"
INCLUDE "audio/music/azaleatown.asm"
INCLUDE "audio/music/cherrygrovecity.asm"
INCLUDE "audio/music/ruinsofalph.asm"
INCLUDE "audio/music/wildbattle.asm"
INCLUDE "audio/music/trainerbattle.asm"
INCLUDE "audio/music/tintower.asm"
INCLUDE "audio/music/sprouttower.asm"
INCLUDE "audio/music/burnedtower.asm"
INCLUDE "audio/music/pokemonlullaby.asm"
INCLUDE "audio/music/rby/surfing.asm"
INCLUDE "audio/music/goldsilveropening.asm"
INCLUDE "audio/music/rby/introbattle.asm"
INCLUDE "audio/music/rby/meeteviltrainer.asm"
INCLUDE "audio/music/rby/pokemontower.asm"
INCLUDE "audio/music/rby/silphco.asm"
INCLUDE "audio/music/pokeflutechannel.asm"
INCLUDE "audio/music/rby/bikeriding.asm"
SongsEnd4:

SECTION "Sound Effects", ROMX,bank[3]

INCLUDE "audio/sfx.asm"
INCLUDE "audio/cries.asm"
SongsEnd3:


SECTION "Crydata", ROMX, bank[7]

INCLUDE "crydata.asm"
