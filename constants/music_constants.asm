; song ids
; Music indexes (see audio/music_pointers.asm)
	const_def

	const MUSIC_NONE                         ; 00
	const MUSIC_TITLE                        ; 01
	const MUSIC_ROUTE_1                      ; 02
	const MUSIC_ROUTE_3                      ; 03
	const MUSIC_ROUTE_12                     ; 04
	const MUSIC_RBY_POKEMON_CHANNEL          ; 05
	const MUSIC_KANTO_GYM_LEADER_BATTLE      ; 06
	const MUSIC_KANTO_TRAINER_BATTLE         ; 07
	const MUSIC_KANTO_WILD_BATTLE            ; 08
	const MUSIC_POKEMON_CENTER               ; 09
	const MUSIC_BAD_GUY_ENCOUNTER            ; 0a
	const MUSIC_GIRL_ENCOUNTER               ; 0b
	const MUSIC_BOY_ENCOUNTER                ; 0c
	const MUSIC_HEAL                         ; 0d
	const MUSIC_LAVENDER_TOWN_HAPPY          ; 0e
	const MUSIC_VIRIDIAN_FOREST              ; 0f
	const MUSIC_MT_MOON                      ; 10
	const MUSIC_SHOW_ME_AROUND               ; 11
	const MUSIC_GAME_CORNER                  ; 12
	const MUSIC_GSC_BICYCLE                  ; 13
	const MUSIC_HALL_OF_FAME                 ; 14
	const MUSIC_VIRIDIAN_CITY                ; 15
	const MUSIC_CELADON_CITY                 ; 16
	const MUSIC_TRAINER_VICTORY              ; 17
	const MUSIC_WILD_VICTORY                 ; 18
	const MUSIC_GYM_VICTORY                  ; 19
	const MUSIC_MT_MOON_SQUARE               ; 1a
	const MUSIC_GYM                          ; 1b
	const MUSIC_PALLET_TOWN                  ; 1c
	const MUSIC_OAK_S_LAB                    ; 1d
	const MUSIC_PROF_OAK                     ; 1e
	const MUSIC_RIVAL_ENCOUNTER              ; 1f
	const MUSIC_RIVAL_AFTER                  ; 20
	const MUSIC_GS_SURF                      ; 21
	const MUSIC_EVOLUTION                    ; 22
	const MUSIC_ROUTE_24                     ; 23
	const MUSIC_GS_CREDITS                   ; 24
	const MUSIC_AZALEA_TOWN                  ; 25
	const MUSIC_CHERRYGROVE_CITY             ; 26
	const MUSIC_FINAL_BATTLE                 ; 27
	const MUSIC_UNION_CAVE                   ; 28
	const MUSIC_JOHTO_WILD_BATTLE            ; 29
	const MUSIC_JOHTO_TRAINER_BATTLE         ; 2a
	const MUSIC_ROUTE_30                     ; 2b
	const MUSIC_ECRUTEAK_CITY                ; 2c
	const MUSIC_VIOLET_CITY                  ; 2d
	const MUSIC_JOHTO_GYM_LEADER_BATTLE      ; 2e
	const MUSIC_CHAMPION_BATTLE              ; 2f
	const MUSIC_CERULEAN_CITY                ; 30
	const MUSIC_CINNABAR_ISLAND              ; 31
	const MUSIC_PROF_ELM                     ; 32
	const MUSIC_LAVENDER_TOWN                ; 33
	const MUSIC_ROUTE_29                     ; 34
	const MUSIC_ROUTE_36                     ; 35
	const MUSIC_SS_ANNE                      ; 36
	const MUSIC_TRADE_1                      ; 37
	const MUSIC_TRADE_2                      ; 38
	const MUSIC_RIVAL_ENCOUNTER_ROUTE_22     ; 39
	const MUSIC_RIVAL_AFTER_ROUTE_22         ; 3a
	const MSUIC_CINNABAR_MANSION             ; 3b
	const MUSIC_NEW_BARK_TOWN                ; 3c
	const MUSIC_GOLDENROD_CITY               ; 3d
	const MUSIC_VERMILION_CITY               ; 3e
	const MUSIC_VIRIDIAN_CITY_FAME           ; 3f
	const MUSIC_POKE_FLUTE_CHANNEL           ; 40
	const MUSIC_TIN_TOWER                    ; 41
	const MUSIC_SPROUT_TOWER                 ; 42
	const MUSIC_BURNED_TOWER                 ; 43
	const MUSIC_LIGHTHOUSE                   ; 44
	const MUSIC_LAKE_OF_RAGE                 ; 45
	const MUSIC_INDIGO_PLATEAU               ; 46
	const MUSIC_ROUTE_37                     ; 47
	const MUSIC_ROCKET_HIDEOUT               ; 48
	const MUSIC_DRAGONS_DEN                  ; 49
	const MUSIC_JOHTO_WILD_BATTLE_NIGHT      ; 4a
	const MUSIC_RUINS_OF_ALPH_RADIO          ; 4b
	const MUSIC_CAPTURE                      ; 4c
	const MUSIC_ROUTE_26                     ; 4d
	const MUSIC_STARMAN                      ; 4e
	const MUSIC_POKEMON_TOWER                ; 4f
	const MUSIC_POKEMON_LULLABY              ; 50
	const MUSIC_RBY_SURF                     ; 51
	const MUSIC_GS_OPENING                   ; 52
	const MUSIC_RBY_OPENING                  ; 53
	const MUSIC_JIGGLYPUFF_S_SONG            ; 54
	const MUSIC_RUINS_OF_ALPH_INTERIOR       ; 55
	const MUSIC_SILPH_CO                     ; 56
	const MUSIC_RBY_CREDITS                  ; 57
	const MUSIC_VS_MENU                      ; 58
	const MUSIC_RBY_BIKE                     ; 59
	const MUSIC_LAKE_OF_RAGE_ROCKET_RADIO    ; 5a
	const MUSIC_PRINTER                      ; 5b
	const MUSIC_POST_CREDITS                 ; 5c
NUM_MUSIC_TRACKS EQU const_value

; GetMapMusic picks music for this value (see home/map.asm)
MUSIC_MAHOGANY_MART EQU $64

MUSIC_MAGNET_TRAIN                 EQU MUSIC_RBY_POKEMON_CHANNEL
MUSIC_POKEMON_TALK                 EQU MUSIC_OAK_S_LAB
MUSIC_SURF                         EQU MUSIC_GS_SURF
MUSIC_NATIONAL_PARK                EQU MUSIC_ROUTE_24
MUSIC_CREDITS                      EQU MUSIC_GS_CREDITS
MUSIC_KIMONO_ENCOUNTER             EQU MUSIC_FINAL_BATTLE
MUSIC_RIVAL_BATTLE                 EQU MUSIC_CERULEAN_CITY
MUSIC_ROCKET_BATTLE                EQU MUSIC_CINNABAR_ISLAND
MUSIC_DARK_CAVE                    EQU MUSIC_LAVENDER_TOWN
MUSIC_SS_AQUA                      EQU MUSIC_SS_ANNE
MUSIC_YOUNGSTER_ENCOUNTER          EQU MUSIC_TRADE_1
MUSIC_BEAUTY_ENCOUNTER             EQU MUSIC_TRADE_2
MUSIC_ROCKET_ENCOUNTER             EQU MUSIC_RIVAL_ENCOUNTER_ROUTE_22
MUSIC_POKEMANIAC_ENCOUNTER         EQU MUSIC_RIVAL_AFTER_ROUTE_22
MUSIC_SAGE_ENCOUNTER               EQU MSUIC_CINNABAR_MANSION
MUSIC_POKEMON_CHANNEL              EQU MUSIC_VIRIDIAN_CITY_FAME
MUSIC_MOM                          EQU MUSIC_STARMAN
MUSIC_VICTORY_ROAD                 EQU MUSIC_POKEMON_TOWER
MUSIC_POKEMON_MARCH                EQU MUSIC_RBY_SURF
MUSIC_GS_OPENING_2                 EQU MUSIC_RBY_OPENING
MUSIC_MAIN_MENU                    EQU MUSIC_JIGGLYPUFF_S_SONG
MUSIC_ROCKET_OVERTURE              EQU MUSIC_SILPH_CO
MUSIC_DANCING_HALL                 EQU MUSIC_RBY_CREDITS
MUSIC_BUG_CATCHING_CONTEST_RANKING EQU MUSIC_VS_MENU
MUSIC_BUG_CATCHING_CONTEST         EQU MUSIC_RBY_BIKE

; ExitPokegearRadio_HandleMusic uses these values
RESTART_MAP_MUSIC EQU $fe
ENTER_MAP_MUSIC   EQU $ff

; GetMapMusic picks music for this bit flag
RADIO_TOWER_MUSIC_F EQU 7
RADIO_TOWER_MUSIC EQU 1 << RADIO_TOWER_MUSIC_F