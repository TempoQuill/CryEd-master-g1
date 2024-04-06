PlayTextSoundAndReturn:
    ld      de,SFX_READ_TEXT
    call    PlaySFX
.loop
    cease
    call    UpdateSound
    call    IsSFXPlaying
    jr      nc,.loop
    jp      InitCryEditor

InitMusicViewer:
    rst     WaitVBlank
    xor     a
    ldh     [rLCDC],a
    ; load font + graphics
    CopyTileset1BPP Font,0,98
    ld      hl,MusicViewerTilemap
    call    LoadMapText
    ; init rendering variables
    SetDMGPal   rBGP, 0,1,2,3
    SetDMGPal   rOBP0,0,0,2,3
    SetDMGPal   rOBP1,0,1,2,3
    xor     a
    ldh     [rSCX],a
    ldh     [rSCY],a
    ldh     [rWX],a
    ldh     [rWY],a
    ld      a,%10010001
    ldh     [rLCDC],a
    ld      a,IEF_VBLANK
    ldh     [rIE],a
    ei
    call    UpdateSound
    cease

MusicViewerLoop:
    call    UpdateSound
    ld      a,[sys_btnPress]
    bit     A_BUTTON_F,a
    jr      nz,.playmusic
    bit     START_F,a
    jr      nz,.playmusic
    bit     B_BUTTON_F,a
    jp      nz,PlayTextSoundAndReturn
    ld      hl,CryEdit_Music
    bit     D_UP_F,a
    jr      nz,.add16
    bit     D_DOWN_F,a
    jr      nz,.sub16
    bit     D_RIGHT_F,a
    jr      nz,.add1
    bit     D_LEFT_F,a
    jr      nz,.sub1
    jr      .continue
.playmusic
    ld      a,[CryEdit_Music]
    ld      e,a
    ld      a,[CryEdit_Music+1]
    ld      d,a
    call    PlayMusic
    jr      .continue
.add16
    ld      a,[hli]
    ld      d,[hl]
    add     16
    ld      e, a
    ld      a, 0
    adc     d
    ld      [hld],a
    ld      [hl],e
    jr      .continue
.sub16
    ld      a,[hli]
    ld      d,[hl]
    sub     16
    ld      e, a
    ld      a, d
    sbc     0
    ld      [hld],a
    ld      [hl],e
    jr      .continue
.add1
    ld      a,[hli]
    ld      d,[hl]
    ld      e, a
    inc     de
    ld      [hl],d
    dec     hl
    ld      [hl],e
    jr      .continue
.sub1
    ld      a,[hli]
    ld      d,[hl]
    ld      e, a
    dec     de
    ld      [hl],d
    dec     hl
    ld      [hl],e
.continue
    ld      de,wMusicViewerArea
    ld      bc,wChannel1
    call    SetupSquareData
    ld      bc,wChannel2
    call    SetupSquareData
    ld      hl,wDisplaySquare1Octave
    inc     [hl]
    ld      hl,wDisplaySquare2Octave
    inc     [hl]
    ld      bc,wChannel3
    call    SetupWAVAndNoise
    call    DisplaySongNames
    call    DisplayAuthors
    call    DisplaySetup
    cease
    jp      MusicViewerLoop

SetupSquareData:
    bc_offset CHANNEL_FLAGS1
    bit     SOUND_CHANNEL_ON,[hl]
    jr      z,.none
    call    PitchOctaveSetup
    bc_offset CHANNEL_DUTY_CYCLE
    ld      a,[hli]
    rlca
    rlca
    and     %00000011
    ld      [de],a
    inc     de
    ld      a,[hl]
    ld      [de],a
    inc     de
    ret
.none
    ld      a,NUM_NOTES + 1
    ld      [de],a
    inc     de
    xor     a
    ld      [de],a
    inc     de
    ld      [de],a
    inc     de
    ld      [de],a
    inc     de
    ret

SetupWAVAndNoise:
    bc_offset CHANNEL_FLAGS1
    bit     SOUND_CHANNEL_ON,[hl]
    jr      z,.none
    call    PitchOctaveSetup
    bc_offset CHANNEL_VOLUME_ENVELOPE
    ld      a,[hl]
    ld      [de],a
    inc     de
    jr      .noise
.none
    ld      a,NUM_NOTES + 1
    ld      [de],a
    inc     de
    xor     a
    ld      [de],a
    inc     de
    ld      [de],a
    inc     de
.noise
    ld      a,[wChannel4Pitch]
    ld      [de],a
    inc     de
    ld      a,[wNoiseSampleAddress]
    ld      [de],a
    inc     de
    ld      a,[wNoiseSampleAddress + 1]
    ld      [de],a
    ret

PitchOctaveSetup:
    ; look at the last byte read
    bc_offset CHANNEL_MUSIC_ADDRESS + 1
    push    de
    ld      a,[hld]
    ld      d,a
    ld      a,[hl]
    ld      e,a
    bc_offset CHANNEL_MUSIC_BANK
    ld      a,[hl]
    dec     de
    call    _LoadMusicByte
    pop     de
    ; is this previous byte a rest?
    ld      a,[wCurMusicByte]
    swap    a
    and     $f
    cp      NUM_NOTES + 1
    jr      z,.rest
    bc_offset CHANNEL_PITCH
    ld      a,[hl]
    ld      [de],a
    inc     de
    bc_offset CHANNEL_OCTAVE
    ld      a,[hl]
    xor     %00000111
    inc     a
    ld      [de],a
    inc     de
    ret
.rest:
    ld      [de],a
    inc     de
    xor     a
    ld      [de],a
    inc     de
    ret

DisplaySetup:
    ; channel 1 - pitch / octave
    ld      de,wDisplaySquare1
    call    RetrievePitchID
    ld      hl,$9907
    call    DisplayPitchAndOctave
    ; channel 1 - duty
    ld      a,[de]
    inc     de
    ld      hl,$9912
    call    DrawHexDigit
    ; channel 1 - volume envelope
    ld      a,[de]
    inc     de
    ld      hl,$990e
    call    DrawHex
    ; channel 2 - pitch / octave
    ld      de,wDisplaySquare2
    call    RetrievePitchID
    ld      hl,$9927
    call    DisplayPitchAndOctave
    ; channel 2 - duty
    ld      a,[de]
    inc     de
    ld      hl,$9932
    call    DrawHexDigit
    ; channel 2 - volume envelope
    ld      a,[de]
    inc     de
    ld      hl,$992e
    call    DrawHex
    ; channel 3 - pitch / octave
    ld      de,wDisplayWAV
    call    RetrievePitchID
    ld      hl,$9947
    call    DisplayPitchAndOctave
    ; channel 3 - WAV ID
    ld      a,[de]
    inc     de
    ld      hl,$994e
    call    DrawHex
    ; channel 4 - drum ID
    ld      a,[de]
    inc     de
    ld      hl,$9969
    call    DrawHex
    ; channel 4 - address
    ld      a,[de]
    inc     de
    push    af
    ld      a,[de]
    inc     de
    ld      hl,$996f
    call    DrawHex
    pop     af
    call    DrawHex
    ld      a,[de]
    inc     de
    ld      a,[de]
    ld      a,[CryEdit_Music+1]
    ld      hl,$984f
    call    DrawHex
    ld      a,[CryEdit_Music]
    jp      DrawHex

DisplayAuthors:
    push    bc
    ld      a,[CryEdit_Music]
    ld      l,a
    ld      a,[CryEdit_Music+1]
    ld      h,a
    and     a
    jr      nz,.null
    ld      a,NUM_MUSIC_TRACKS - 1
    cp      l
    jr      nc,.pass
.null
    ld      hl,0
.pass
    ld      de,ComposerList
    add     hl,de
    ld      d,h
    ld      e,l
    call    GetComposer
    ld      hl,$98c0
    call    AddComposer
    pop     bc
    ret

GetComposer:
    ld      a,[de]
    ld      b,0
    ld      c,a
    ld      hl,Composers
    swap    c
    add     hl,bc
    ld      b,h
    ld      c,l
    ret

AddComposer:
    push    de
    ld      e,$10
.loop
    WaitForVRAM
    ld      a,[bc]
    sub     32
    inc     bc
    ld      [hli],a
    dec     e
    jr      nz,.loop
    pop     de
    ret

RetrievePitchID:
; in - de
; out - bc, de = de+1
    ld      a,[de]
    inc     de
    ld      c,a
    ld      b,0
    ld      hl,NoteNames
    add     hl,bc
    add     hl,bc
    ld      c,l
    ld      b,h
    ret

DisplayPitchAndOctave:
; in - bc
; out - bc = bc+2
    WaitForVRAM
    ld      a,[bc]
    inc     bc
    sub     32
    ld      [hli],a
    ld      a,[bc]
    sub     32
    ld      [hli],a
    ld      a,[de]
    inc     de
    jp      DrawHexDigit

DiaplayErrerMessage:
    ld      de,MusicErrorMessage
    jr      TrackNameRowDisplay

DisplaySongNames:
    ld      a,[CryEdit_Music+1]
    and     a
    jp      nz,DiaplayErrerMessage
    ld      a,[CryEdit_Music]
    cp      NUM_MUSIC_TRACKS
    jp      nc,DiaplayErrerMessage
    ld      hl,CryEdit_Music
    ld      a,[hli]
    ld      h,[hl]
    ld      l,a
    ld      e,l
    ld      d,h
    add     hl,hl ; x2
    add     hl,hl ; x4
    add     hl,de ; x5
    add     hl,hl ; x10
    add     hl,hl ; x20
    add     hl,hl ; x40
    ld      e,l
    ld      d,h
    ld      hl,SongNames
    add     hl,de
    ld      e,l
    ld      d,h
TrackNameRowDisplay:
    ld      c,$14
    ld      hl,$9860
    call    .loop
    ld      c,$14
    ld      hl,$9880
.loop
    WaitForVRAM
    ld      a,[de]
    inc     de
    sub     32
    ld      [hli],a
    dec     c
    jr      nz,.loop
    ret

MusicErrorMessage:
    db  "You're too far on   "
    db  "the list there, pal!"
