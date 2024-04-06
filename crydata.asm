MACRO mon_cry
; index, pitch, length
	dw \1, \2, \3
ENDM

PokemonCries::
; entries correspond to constants/pokemon_constants.asm
	mon_cry CRY_BULBASAUR,   $080,  $081 ; BULBASAUR
	mon_cry CRY_BULBASAUR,   $020,  $100 ; IVYSAUR
	mon_cry CRY_BULBASAUR,   $000,  $140 ; VENUSAUR
	mon_cry CRY_CHARMANDER,  $060,  $0c0 ; CHARMANDER
	mon_cry CRY_CHARMANDER,  $020,  $0c0 ; CHARMELEON
	mon_cry CRY_CHARMANDER,  $000,  $100 ; CHARIZARD
	mon_cry CRY_SQUIRTLE,    $060,  $0c0 ; SQUIRTLE
	mon_cry CRY_SQUIRTLE,    $020,  $0c0 ; WARTORTLE
	mon_cry CRY_BLASTOISE,   $000,  $100 ; BLASTOISE
	mon_cry CRY_CATERPIE,    $080,  $0a0 ; CATERPIE
	mon_cry CRY_METAPOD,     $0cc,  $081 ; METAPOD
	mon_cry CRY_CATERPIE,    $077,  $0c0 ; BUTTERFREE
	mon_cry CRY_WEEDLE,      $0ee,  $081 ; WEEDLE
	mon_cry CRY_BLASTOISE,   $0ff,  $081 ; KAKUNA
	mon_cry CRY_BLASTOISE,   $060,  $100 ; BEEDRILL
	mon_cry CRY_PIDGEY,      $0df,  $084 ; PIDGEY
	mon_cry CRY_PIDGEOTTO,   $028,  $140 ; PIDGEOTTO
	mon_cry CRY_PIDGEOTTO,   $011,  $17f ; PIDGEOT
	mon_cry CRY_RATTATA,     $000,  $100 ; RATTATA
	mon_cry CRY_RATTATA,     $020,  $17f ; RATICATE
	mon_cry CRY_SPEAROW,     $000,  $100 ; SPEAROW
	mon_cry CRY_FEAROW,      $040,  $120 ; FEAROW
	mon_cry CRY_EKANS,       $012,  $0c0 ; EKANS
	mon_cry CRY_EKANS,       $0e0,  $090 ; ARBOK
	mon_cry CRY_BULBASAUR,   $0ee,  $081 ; PIKACHU
	mon_cry CRY_RAICHU,      $0ee,  $088 ; RAICHU
	mon_cry CRY_NIDORAN_M,   $020,  $0c0 ; SANDSHREW
	mon_cry CRY_NIDORAN_M,   $0ff,  $17f ; SANDSLASH
	mon_cry CRY_NIDORAN_F,   $000,  $100 ; NIDORAN_F
	mon_cry CRY_NIDORAN_F,   $02c,  $160 ; NIDORINA
	mon_cry CRY_NIDOQUEEN,   $000,  $100 ; NIDOQUEEN
	mon_cry CRY_NIDORAN_M,   $000,  $100 ; NIDORAN_M
	mon_cry CRY_NIDORAN_M,   $02c,  $140 ; NIDORINO
	mon_cry CRY_RAICHU,      $000,  $100 ; NIDOKING
	mon_cry CRY_CLEFAIRY,    $0cc,  $081 ; CLEFAIRY
	mon_cry CRY_CLEFAIRY,    $0aa,  $0a0 ; CLEFABLE
	mon_cry CRY_VULPIX,      $04f,  $090 ; VULPIX
	mon_cry CRY_VULPIX,      $088,  $0e0 ; NINETALES
	mon_cry CRY_PIDGEY,      $0ff,  $0b5 ; JIGGLYPUFF
	mon_cry CRY_PIDGEY,      $068,  $0e0 ; WIGGLYTUFF
	mon_cry CRY_SQUIRTLE,    $0e0,  $100 ; ZUBAT
	mon_cry CRY_SQUIRTLE,    $0fa,  $100 ; GOLBAT
	mon_cry CRY_ODDISH,      $0dd,  $081 ; ODDISH
	mon_cry CRY_ODDISH,      $0aa,  $0c0 ; GLOOM
	mon_cry CRY_VILEPLUME,   $022,  $17f ; VILEPLUME
	mon_cry CRY_PARAS,       $020,  $160 ; PARAS
	mon_cry CRY_PARAS,       $042,  $17f ; PARASECT
	mon_cry CRY_VENONAT,     $044,  $0c0 ; VENONAT
	mon_cry CRY_VENONAT,     $029,  $100 ; VENOMOTH
	mon_cry CRY_DIGLETT,     $0aa,  $081 ; DIGLETT
	mon_cry CRY_DIGLETT,     $02a,  $090 ; DUGTRIO
	mon_cry CRY_CLEFAIRY,    $077,  $090 ; MEOWTH
	mon_cry CRY_CLEFAIRY,    $099,  $17f ; PERSIAN
	mon_cry CRY_PSYDUCK,     $020,  $0e0 ; PSYDUCK
	mon_cry CRY_PSYDUCK,     $0ff,  $0c0 ; GOLDUCK
	mon_cry CRY_NIDOQUEEN,   $0dd,  $0e0 ; MANKEY
	mon_cry CRY_NIDOQUEEN,   $0af,  $0c0 ; PRIMEAPE
	mon_cry CRY_GROWLITHE,   $020,  $0c0 ; GROWLITHE
	mon_cry CRY_WEEDLE,      $000,  $100 ; ARCANINE
	mon_cry CRY_PIDGEY,      $0ff,  $17f ; POLIWAG
	mon_cry CRY_PIDGEY,      $077,  $0e0 ; POLIWHIRL
	mon_cry CRY_PIDGEY,      $000,  $17f ; POLIWRATH
	mon_cry CRY_METAPOD,     $0c0,  $081 ; ABRA
	mon_cry CRY_METAPOD,     $0a8,  $140 ; KADABRA
	mon_cry CRY_METAPOD,     $098,  $17f ; ALAKAZAM
	mon_cry CRY_GROWLITHE,   $0ee,  $081 ; MACHOP
	mon_cry CRY_GROWLITHE,   $048,  $0e0 ; MACHOKE
	mon_cry CRY_GROWLITHE,   $008,  $140 ; MACHAMP
	mon_cry CRY_PSYDUCK,     $055,  $081 ; BELLSPROUT
	mon_cry CRY_WEEPINBELL,  $044,  $0a0 ; WEEPINBELL
	mon_cry CRY_WEEPINBELL,  $066,  $14c ; VICTREEBEL
	mon_cry CRY_VENONAT,     $000,  $100 ; TENTACOOL
	mon_cry CRY_VENONAT,     $0ee,  $17f ; TENTACRUEL
	mon_cry CRY_VULPIX,      $0f0,  $090 ; GEODUDE
	mon_cry CRY_VULPIX,      $000,  $100 ; GRAVELER
	mon_cry CRY_GOLEM,       $0e0,  $0c0 ; GOLEM
	mon_cry CRY_WEEPINBELL,  $000,  $100 ; PONYTA
	mon_cry CRY_WEEPINBELL,  $020,  $140 ; RAPIDASH
	mon_cry CRY_SLOWPOKE,    $000,  $100 ; SLOWPOKE
	mon_cry CRY_GROWLITHE,   $000,  $100 ; SLOWBRO
	mon_cry CRY_METAPOD,     $080,  $0e0 ; MAGNEMITE
	mon_cry CRY_METAPOD,     $020,  $140 ; MAGNETON
	mon_cry CRY_SPEAROW,     $0dd,  $081 ; FARFETCH_D
	mon_cry CRY_DIGLETT,     $0bb,  $081 ; DODUO
	mon_cry CRY_DIGLETT,     $099,  $0a0 ; DODRIO
	mon_cry CRY_SEEL,        $088,  $140 ; SEEL
	mon_cry CRY_SEEL,        $023,  $17f ; DEWGONG
	mon_cry CRY_GRIMER,      $000,  $100 ; GRIMER
	mon_cry CRY_MUK,         $0ef,  $17f ; MUK
	mon_cry CRY_FEAROW,      $000,  $100 ; SHELLDER
	mon_cry CRY_FEAROW,      $06f,  $160 ; CLOYSTER
	mon_cry CRY_METAPOD,     $000,  $100 ; GASTLY
	mon_cry CRY_METAPOD,     $030,  $0c0 ; HAUNTER
	mon_cry CRY_MUK,         $000,  $17f ; GENGAR
	mon_cry CRY_EKANS,       $0ff,  $140 ; ONIX
	mon_cry CRY_DROWZEE,     $088,  $0a0 ; DROWZEE
	mon_cry CRY_DROWZEE,     $0ee,  $0c0 ; HYPNO
	mon_cry CRY_KRABBY,      $020,  $160 ; KRABBY
	mon_cry CRY_KRABBY,      $0ee,  $160 ; KINGLER
	mon_cry CRY_VOLTORB,     $0ed,  $100 ; VOLTORB
	mon_cry CRY_VOLTORB,     $0a8,  $110 ; ELECTRODE
	mon_cry CRY_DIGLETT,     $000,  $100 ; EXEGGCUTE
	mon_cry CRY_DROWZEE,     $000,  $100 ; EXEGGUTOR
	mon_cry CRY_CLEFAIRY,    $000,  $100 ; CUBONE
	mon_cry CRY_ODDISH,      $04f,  $0e0 ; MAROWAK
	mon_cry CRY_GOLEM,       $080,  $140 ; HITMONLEE
	mon_cry CRY_SEEL,        $0ee,  $140 ; HITMONCHAN
	mon_cry CRY_SEEL,        $000,  $100 ; LICKITUNG
	mon_cry CRY_GOLEM,       $0e6,  $15d ; KOFFING
	mon_cry CRY_GOLEM,       $0ff,  $17f ; WEEZING
	mon_cry CRY_CHARMANDER,  $000,  $100 ; RHYHORN
	mon_cry CRY_RHYDON,      $000,  $100 ; RHYDON
	mon_cry CRY_PIDGEOTTO,   $00a,  $140 ; CHANSEY
	mon_cry CRY_GOLEM,       $000,  $100 ; TANGELA
	mon_cry CRY_KANGASKHAN,  $000,  $100 ; KANGASKHAN
	mon_cry CRY_CLEFAIRY,    $099,  $090 ; HORSEA
	mon_cry CRY_CLEFAIRY,    $03c,  $081 ; SEADRA
	mon_cry CRY_CATERPIE,    $080,  $0c0 ; GOLDEEN
	mon_cry CRY_CATERPIE,    $010,  $17f ; SEAKING
	mon_cry CRY_PARAS,       $002,  $0a0 ; STARYU
	mon_cry CRY_PARAS,       $000,  $100 ; STARMIE
	mon_cry CRY_KRABBY,      $008,  $0c0 ; MR__MIME
	mon_cry CRY_CATERPIE,    $000,  $100 ; SCYTHER
	mon_cry CRY_DROWZEE,     $0ff,  $17f ; JYNX
	mon_cry CRY_VOLTORB,     $08f,  $17f ; ELECTABUZZ
	mon_cry CRY_CHARMANDER,  $0ff,  $0b0 ; MAGMAR
	mon_cry CRY_PIDGEOTTO,   $000,  $100 ; PINSIR
	mon_cry CRY_SQUIRTLE,    $011,  $0c0 ; TAUROS
	mon_cry CRY_EKANS,       $080,  $080 ; MAGIKARP
	mon_cry CRY_EKANS,       $000,  $100 ; GYARADOS
	mon_cry CRY_LAPRAS,      $000,  $100 ; LAPRAS
	mon_cry CRY_PIDGEY,      $0ff,  $17f ; DITTO
	mon_cry CRY_VENONAT,     $088,  $0e0 ; EEVEE
	mon_cry CRY_VENONAT,     $0aa,  $17f ; VAPOREON
	mon_cry CRY_VENONAT,     $03d,  $100 ; JOLTEON
	mon_cry CRY_VENONAT,     $010,  $0a0 ; FLAREON
	mon_cry CRY_WEEPINBELL,  $0aa,  $17f ; PORYGON
	mon_cry CRY_GROWLITHE,   $0f0,  $081 ; OMANYTE
	mon_cry CRY_GROWLITHE,   $0ff,  $0c0 ; OMASTAR
	mon_cry CRY_CATERPIE,    $0bb,  $0c0 ; KABUTO
	mon_cry CRY_FEAROW,      $0ee,  $081 ; KABUTOPS
	mon_cry CRY_VILEPLUME,   $020,  $170 ; AERODACTYL
	mon_cry CRY_GRIMER,      $055,  $081 ; SNORLAX
	mon_cry CRY_RAICHU,      $080,  $0c0 ; ARTICUNO
	mon_cry CRY_FEAROW,      $0ff,  $100 ; ZAPDOS
	mon_cry CRY_RAICHU,      $0f8,  $0c0 ; MOLTRES
	mon_cry CRY_BULBASAUR,   $060,  $0c0 ; DRATINI
	mon_cry CRY_BULBASAUR,   $040,  $100 ; DRAGONAIR
	mon_cry CRY_BULBASAUR,   $03c,  $140 ; DRAGONITE
	mon_cry CRY_PARAS,       $099,  $17f ; MEWTWO
	mon_cry CRY_PARAS,       $0ee,  $17f ; MEW
	mon_cry CRY_CHIKORITA,   $020,  $0b0 ; CHIKORITA	;
	mon_cry CRY_CHIKORITA,   $010,  $120 ; BAYLEEF		;
	mon_cry CRY_CHIKORITA,   $000,  $17f ; MEGANIUM		;
	mon_cry CRY_CYNDAQUIL,   $047,  $080 ; CYNDAQUIL	;
	mon_cry CRY_CYNDAQUIL,   $021,  $120 ; QUILAVA		;
	mon_cry CRY_TYPHLOSION,  $0c0,  $0d4 ; TYPHLOSION	;
	mon_cry CRY_CHARMANDER,  $0f0,  $0d4 ; TOTODILE		;
	mon_cry CRY_CHARMANDER,  $0e0,  $0f4 ; CROCONAW		;
	mon_cry CRY_CHARMANDER,  $0b1,  $134 ; FERALIGATR	;
	mon_cry CRY_SENTRET,     $08a,  $0b8 ; SENTRET		;
	mon_cry CRY_SENTRET,     $06b,  $102 ; FURRET		;
	mon_cry CRY_HOOTHOOT,    $091,  $0d8 ; HOOTHOOT		;
	mon_cry CRY_HOOTHOOT,    $000,  $17f ; NOCTOWL		;
	mon_cry CRY_LEDYBA,      $008,  $0de ; LEDYBA		;
	mon_cry CRY_LEDYBA,      $000,  $138 ; LEDIAN		;
	mon_cry CRY_SPINARAK,    $011,  $17f ; SPINARAK		;
	mon_cry CRY_SPINARAK,    $000,  $171 ; ARIADOS		;
	mon_cry CRY_SQUIRTLE,    $000,  $140 ; CROBAT		;
	mon_cry CRY_CYNDAQUIL,   $0c9,  $140 ; CHINCHOU		;
	mon_cry CRY_CYNDAQUIL,   $018,  $110 ; LANTURN		;
	mon_cry CRY_PICHU,       $000,  $122 ; PICHU		;
	mon_cry CRY_CLEFFA,      $061,  $0ba ; CLEFFA		;
	mon_cry CRY_CHIKORITA,   $030,  $0e8 ; IGGLYBUFF	;
	mon_cry CRY_TOGEPI,      $010,  $100 ; TOGEPI		;
	mon_cry CRY_TOGETIC,     $000,  $080 ; TOGETIC		;
	mon_cry CRY_NATU,        $040,  $100 ; NATU		;
	mon_cry CRY_NATU,        $000,  $168 ; XATU		;
	mon_cry CRY_MAREEP,      $022,  $0d8 ; MAREEP		;
	mon_cry CRY_MAREEP,      $000,  $17f ; FLAAFFY		;
	mon_cry CRY_FEAROW,      $010,  $11f ; AMPHAROS		;
	mon_cry CRY_CLEFFA,      $084,  $133 ; BELLOSSOM	;
	mon_cry CRY_MARILL,      $0f0,  $120 ; MARILL		;
	mon_cry CRY_MARILL,      $0b6,  $17f ; AZUMARILL	;
	mon_cry CRY_CLEFFA,      $010,  $151 ; SUDOWOODO	;
	mon_cry CRY_EKANS,       $040,  $11f ; POLITOED		;
	mon_cry CRY_CLEFFA,      $03b,  $0dc ; HOPPIP		;
	mon_cry CRY_CLEFFA,      $027,  $124 ; SKIPLOOM		;
	mon_cry CRY_CLEFFA,      $000,  $151 ; JUMPLUFF		;
	mon_cry CRY_AIPOM,       $010,  $0e8 ; AIPOM		;
	mon_cry CRY_MARILL,      $0ff,  $0b8 ; SUNKERN		;
	mon_cry CRY_SUNFLORA,    $0d2,  $17f ; SUNFLORA		;
	mon_cry CRY_TOTODILE,    $031,  $0c8 ; YANMA		;
	mon_cry CRY_WOOPER,      $093,  $0af ; WOOPER		;
	mon_cry CRY_WOOPER,      $000,  $140 ; QUAGSIRE		;
	mon_cry CRY_AIPOM,       $0a2,  $140 ; ESPEON		;
	mon_cry CRY_BLASTOISE,   $09c,  $0cd ; UMBREON		;
	mon_cry CRY_MARILL,      $000,  $17f ; MURKROW		;
	mon_cry CRY_SLOWKING,    $0ff,  $17f ; SLOWKING		;
	mon_cry CRY_HOOTHOOT,    $0cf,  $0e8 ; MISDREAVUS	;
	mon_cry CRY_HOOTHOOT,    $0ff,  $100 ; UNOWN		;
	mon_cry CRY_AMPHAROS,    $05f,  $144 ; WOBBUFFET	;
	mon_cry CRY_GIRAFARIG,   $041,  $166 ; GIRAFARIG	;
	mon_cry CRY_SLOWKING,    $080,  $100 ; PINECO		;
	mon_cry CRY_SLOWKING,    $000,  $17f ; FORRETRESS	;
	mon_cry CRY_DUNSPARCE,   $0b0,  $100 ; DUNSPARCE	;
	mon_cry CRY_GLIGAR,      $0fe,  $100 ; GLIGAR		;
	mon_cry CRY_TYPHLOSION,  $0ef,  $0f7 ; STEELIX		;
	mon_cry CRY_DUNSPARCE,   $06b,  $0e8 ; SNUBBULL		;
	mon_cry CRY_DUNSPARCE,   $000,  $17f ; GRANBULL		;
	mon_cry CRY_SLOWKING,    $060,  $0e0 ; QWILFISH		;
	mon_cry CRY_AMPHAROS,    $000,  $160 ; SCIZOR		;
	mon_cry CRY_DUNSPARCE,   $0ff,  $0a8 ; SHUCKLE		;
	mon_cry CRY_AMPHAROS,    $035,  $0e0 ; HERACROSS	;
	mon_cry CRY_WOOPER,      $053,  $0af ; SNEASEL		;
	mon_cry CRY_TEDDIURSA,   $000,  $080 ; TEDDIURSA	;
	mon_cry CRY_TEDDIURSA,   $0ff,  $0d8 ; URSARING		;
	mon_cry CRY_EKANS,       $0df,  $140 ; SLUGMA		;
	mon_cry CRY_PSYDUCK,     $05f,  $11f ; MAGCARGO		;
	mon_cry CRY_CYNDAQUIL,   $000,  $140 ; SWINUB		;
	mon_cry CRY_GRIMER,      $0c0,  $0e0 ; PILOSWINE	;
	mon_cry CRY_MAGCARGO,    $0a1,  $0e8 ; CORSOLA		;
	mon_cry CRY_SUNFLORA,    $0ff,  $100 ; REMORAID		;
	mon_cry CRY_TOTODILE,    $000,  $17f ; OCTILLERY	;
	mon_cry CRY_TEDDIURSA,   $008,  $080 ; DELIBIRD		;
	mon_cry CRY_MANTINE,     $000,  $0f0 ; MANTINE		;
	mon_cry CRY_AMPHAROS,    $0a9,  $17f ; SKARMORY		;
	mon_cry CRY_CYNDAQUIL,   $0ff,  $140 ; HOUNDOUR		;
	mon_cry CRY_TOTODILE,    $00a,  $100 ; HOUNDOOM		;
	mon_cry CRY_SLUGMA,      $0ff,  $100 ; KINGDRA		;
	mon_cry CRY_SENTRET,     $048,  $180 ; PHANPY		;
	mon_cry CRY_DONPHAN,     $000,  $17f ; DONPHAN		;
	mon_cry CRY_GIRAFARIG,   $073,  $167 ; PORYGON2		;
	mon_cry CRY_EKANS,       $0f4,  $17f ; STANTLER		;
	mon_cry CRY_SLOWPOKE,    $020,  $17f ; SMEARGLE		;
	mon_cry CRY_AIPOM,       $02c,  $108 ; TYROGUE		;
	mon_cry CRY_SLUGMA,      $000,  $100 ; HITMONTOP	;
	mon_cry CRY_MARILL,      $068,  $100 ; SMOOCHUM		;
	mon_cry CRY_SUNFLORA,    $000,  $0b4 ; ELEKID		;
	mon_cry CRY_TEDDIURSA,   $020,  $080 ; MAGBY		;
	mon_cry CRY_GLIGAR,      $033,  $17f ; MILTANK		;
	mon_cry CRY_MARILL,      $080,  $17f ; BLISSEY		;
	mon_cry CRY_ENTEI,       $0a4,  $0df ; RAIKOU		;
	mon_cry CRY_ENTEI,       $000,  $17f ; ENTEI		;
	mon_cry CRY_MAGCARGO,    $000,  $17f ; SUICUNE		;
	mon_cry CRY_RAIKOU,      $05f,  $0d0 ; LARVITAR		;
	mon_cry CRY_SPINARAK,    $0ff,  $128 ; PUPITAR		;
	mon_cry CRY_RAIKOU,      $000,  $17f ; TYRANITAR	;
	mon_cry CRY_TYPHLOSION,  $000,  $100 ; LUGIA		;
	mon_cry CRY_AIPOM,       $000,  $17f ; HO_OH		;
	mon_cry CRY_ENTEI,       $0ff,  $111 ; CELEBI		;
	mon_cry CRY_NIDORAN_M,   $080,  $080
	mon_cry CRY_NIDORAN_M,   $080,  $080
	mon_cry CRY_NIDORAN_M,   $080,  $080
	mon_cry CRY_NIDORAN_M,   $080,  $080
	mon_cry CRY_NIDORAN_M,   $080,  $080
