;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SpawnSprites
	.globl _main
	.globl _init_bkg
	.globl _set_sprite_data
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _character
	.globl _Wine
	.globl _pint
	.globl _BKGtile
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_character::
	.ds 16
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:37: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:40: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:41: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:43: set_bkg_data(0, 1, BKGtile);
	ld	de, #_BKGtile
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_data
	add	sp, #4
;main.c:44: init_bkg(0);
	xor	a, a
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;main.c:46: SpawnSprites();
;main.c:62: }
	jp	_SpawnSprites
_BKGtile:
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xbd	; 189
	.db #0x42	; 66	'B'
	.db #0xa5	; 165
	.db #0x5a	; 90	'Z'
	.db #0xa5	; 165
	.db #0x5a	; 90	'Z'
	.db #0xbd	; 189
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x00	; 0
_pint:
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
_Wine:
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
;main.c:64: void SpawnSprites(){
;	---------------------------------
; Function SpawnSprites
; ---------------------------------
_SpawnSprites::
;main.c:68: set_sprite_data(0, 1, Wine);
	ld	de, #_Wine
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_data
	add	sp, #4
;main.c:69: set_sprite_data(1, 1, pint);
	ld	de, #_pint
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:70: set_sprite_data(2, 1, character);
	ld	de, #_character
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, #0x02
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	(hl), #0x1e
	inc	hl
	ld	(hl), #0x46
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	(hl), #0x1e
	inc	hl
	ld	(hl), #0x1e
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	(hl), #0x96
	inc	hl
	ld	(hl), #0x96
;main.c:81: while (1) {
00107$:
;main.c:82: uint8_t buttons = joypad();
	call	_joypad
	ld	c, a
;main.c:83: uint8_t moveX = 0;
	ld	e, #0x00
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	inc	a
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	inc	a
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
;main.c:92: if (buttons & J_LEFT){
	bit	1, c
	jr	Z, 00104$
;main.c:93: moveX = -1;
	ld	e, #0xff
	jr	00105$
00104$:
;main.c:95: else if (buttons & J_RIGHT){
	bit	0, c
	jr	Z, 00105$
;main.c:96: moveX = 1;
	ld	e, #0x01
00105$:
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+8
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, e
	ld	(bc), a
;main.c:103: wait_vbl_done();
	call	_wait_vbl_done
;main.c:109: }
	jr	00107$
	.area _CODE
	.area _INITIALIZER
__xinit__character:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x5a	; 90	'Z'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x24	; 36
	.area _CABS (ABS)
