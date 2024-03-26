;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _loadSprites
	.globl _setBackground
	.globl _setupSprites
	.globl _playerMovement
	.globl _scrollSprite
	.globl _moveSprite
	.globl _LoadSpriteFrame
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _character
	.globl _yBounds
	.globl _moveX
	.globl _moveY
	.globl _Bartender
	.globl _BackgroundTiles
	.globl _backgroundmap
	.globl _bartender
	.globl _wineglass
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
_wineglass::
	.ds 12
_bartender::
	.ds 12
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_backgroundmap::
	.ds 360
_BackgroundTiles::
	.ds 304
_Bartender::
	.ds 64
_moveY::
	.ds 1
_moveX::
	.ds 1
_yBounds::
	.ds 1
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
;spritestructs.h:31: void LoadSpriteFrame(Sprite *sprite, uint8_t frame)
;	---------------------------------
; Function LoadSpriteFrame
; ---------------------------------
_LoadSpriteFrame::
	add	sp, #-4
	ld	c, e
	ld	b, d
	ld	e, a
;spritestructs.h:33: sprite->spritecurrentFrame = frame;
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), e
;spritestructs.h:35: uint8_t spriteCount = sprite->spriteWidth + sprite->spriteHeight;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#0
	ld	(hl), a
;spritestructs.h:37: for (uint8_t i = 0; i != spriteCount; i++)
	ld	hl, #0x0005
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
00104$:
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#3
	sub	a, (hl)
	jr	Z, 00106$
;spritestructs.h:39: set_sprite_tile(sprite->spriteID + i, sprite->tilesetStart + i);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, (hl)
	ld	e, a
	ld	a, (bc)
	add	a, (hl)
	ld	d, a
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, d
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), e
;spritestructs.h:37: for (uint8_t i = 0; i != spriteCount; i++)
	ldhl	sp,	#3
	inc	(hl)
	jr	00104$
00106$:
;spritestructs.h:41: }
	add	sp, #4
	ret
;spritestructs.h:43: void moveSprite (Sprite *sprite, uint8_t x, uint8_t y)
;	---------------------------------
; Function moveSprite
; ---------------------------------
_moveSprite::
	add	sp, #-8
	ld	c, e
	ld	b, d
	ldhl	sp,	#5
	ld	(hl), a
;spritestructs.h:45: sprite->x = x;
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:46: sprite->y = y;
	ld	hl, #0x0007
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:48: for (uint8_t iy = 0; iy!= sprite->spriteHeight; iy++)
	ld	hl, #0x0002
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#6
	ld	(hl), #0x00
00108$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, (hl)
	jr	Z, 00110$
;spritestructs.h:50: for (uint8_t ix = 0; ix != sprite->spriteWidth; ix++)
	ldhl	sp,	#7
	ld	(hl), #0x00
00105$:
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	sub	a, (hl)
	jr	Z, 00109$
;spritestructs.h:52: uint8_t index = sprite->spriteID + ix + (iy * sprite->spriteWidth);
	ld	a, (bc)
	ldhl	sp,	#7
	add	a, (hl)
	ld	d, a
	push	bc
	push	de
	ldhl	sp,	#8
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	call	__muluchar
	ld	a, c
	pop	de
	pop	bc
	add	a, d
	ld	e, a
;spritestructs.h:54: move_sprite(index, x + (ix * 8), y + (iy * 8));
	ldhl	sp,	#6
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	ld	d, (hl)
	add	a, d
	ld	d, a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	add	a, a
	add	a, a
	add	a, a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	add	a, l
	ldhl	sp,	#4
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	a, d
	ld	(hl+), a
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:50: for (uint8_t ix = 0; ix != sprite->spriteWidth; ix++)
	ldhl	sp,	#7
	inc	(hl)
	jr	00105$
00109$:
;spritestructs.h:48: for (uint8_t iy = 0; iy!= sprite->spriteHeight; iy++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00108$
00110$:
;spritestructs.h:57: }
	add	sp, #8
	pop	hl
	inc	sp
	jp	(hl)
;spritestructs.h:59: void scrollSprite(Sprite *sprite, uint8_t x, uint8_t y)
;	---------------------------------
; Function scrollSprite
; ---------------------------------
_scrollSprite::
	add	sp, #-10
	ldhl	sp,	#8
	ld	(hl), a
;spritestructs.h:62: sprite->x = x;
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:63: sprite->y = y;
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:65: uint8_t spriteCount = sprite->spriteWidth + sprite->spriteHeight;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	c, (hl)
	add	a, c
	ldhl	sp,	#0
	ld	(hl), a
;spritestructs.h:68: scroll_sprite(sprite->tilesetStart, x, y);
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;spritestructs.h:66: if (spriteCount <= 2)
	ld	a, #0x02
	ldhl	sp,	#0
	sub	a, (hl)
	jr	C, 00114$
;spritestructs.h:68: scroll_sprite(sprite->tilesetStart, x, y);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00134$:
	ldhl	sp,	#6
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00134$
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#6
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	add	a, (hl)
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (hl-)
	add	a, (hl)
	ld	c, a
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;spritestructs.h:68: scroll_sprite(sprite->tilesetStart, x, y);
	jp	00110$
;spritestructs.h:72: for (uint8_t i = 0; i != spriteCount; i++)
00114$:
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#9
	ld	(hl), #0x00
00108$:
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	jr	Z, 00110$
;spritestructs.h:74: scroll_sprite(sprite->tilesetStart + i, x, y);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	add	a, (hl)
	ld	c, a
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00136$:
	ldhl	sp,	#4
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00136$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#1
	add	a, (hl)
	ld	c, a
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, (hl)
	dec	hl
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;spritestructs.h:72: for (uint8_t i = 0; i != spriteCount; i++)
	ldhl	sp,	#9
	inc	(hl)
	jr	00108$
00110$:
;spritestructs.h:82: }
	add	sp, #10
	pop	hl
	inc	sp
	jp	(hl)
;spritestructs.h:84: void playerMovement(Sprite *sprite)
;	---------------------------------
; Function playerMovement
; ---------------------------------
_playerMovement::
	add	sp, #-3
;spritestructs.h:88: int8_t moveX = 0;
	ld	c, #0x00
;spritestructs.h:89: uint8_t buttons = joypad();
	push	de
	call	_joypad
	ld	b, a
	pop	de
;spritestructs.h:94: uint8_t spriteCount = sprite->spriteWidth + sprite->spriteHeight;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	ldhl	sp,	#0
	ld	(hl), a
;spritestructs.h:97: if (buttons & J_LEFT){
	bit	1, b
	jr	Z, 00102$
;spritestructs.h:98: moveX = -1;
	ld	c, #0xff
00102$:
;spritestructs.h:100: if (buttons & J_RIGHT){
	bit	0, b
	jr	Z, 00115$
;spritestructs.h:101: moveX = 1;
	ld	c, #0x01
;spritestructs.h:104: for (uint8_t i = 0; i != spriteCount; i++)
00115$:
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), a
	ld	b, #0x00
00108$:
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, b
	jr	Z, 00110$
;spritestructs.h:106: scroll_sprite(sprite->tilesetStart + i, moveX, 0);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, b
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	add	a, c
	ld	(hl), a
;spritestructs.h:104: for (uint8_t i = 0; i != spriteCount; i++)
	inc	b
	jr	00108$
00110$:
;spritestructs.h:108: }
	add	sp, #3
	ret
;spritestructs.h:115: void setupSprites(Sprite *sprite, uint8_t spriteID, int8_t spriteHeight, uint8_t spriteWidth, uint8_t spriteFrames, uint8_t tilesetStart, uint8_t x, uint8_t y,
;	---------------------------------
; Function setupSprites
; ---------------------------------
_setupSprites::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;spritestructs.h:118: sprite->tileset = tileset;
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:119: sprite->tilesetStart = tilesetStart;
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:120: sprite->spriteID = spriteID;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:121: sprite->spriteHeight = spriteHeight;
	ld	c, e
	ld	b, d
	inc	bc
	ldhl	sp,	#3
;spritestructs.h:122: sprite->spriteWidth = spriteWidth;
	ld	a, (hl+)
	ld	(bc), a
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
;spritestructs.h:123: sprite->spriteFrames = spriteFrames;
	ld	a, (hl+)
	ld	(bc), a
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:125: sprite->x = x;
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:126: sprite->y = y;
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:127: sprite->velocityX = velocityX;
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:128: sprite->velocityY = velocityY;
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:130: LoadSpriteFrame(sprite, 0);
	xor	a, a
	call	_LoadSpriteFrame
;spritestructs.h:137: }
	inc	sp
	pop	hl
	add	sp, #10
	jp	(hl)
;main.c:46: void setBackground(void){
;	---------------------------------
; Function setBackground
; ---------------------------------
_setBackground::
;main.c:48: set_bkg_data(0, 18, BackgroundTiles);
	ld	de, #_BackgroundTiles
	push	de
	ld	hl, #0x1200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:49: set_bkg_tiles(0, 0, 20, 18, backgroundmap);
	ld	de, #_backgroundmap
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:52: }
	ret
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
;main.c:54: void loadSprites(void)
;	---------------------------------
; Function loadSprites
; ---------------------------------
_loadSprites::
;main.c:56: set_sprite_data(0, 1, Wine);
	ld	de, #_Wine
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_data
	add	sp, #4
;main.c:57: set_sprite_data(1, 4, Bartender);
	ld	de, #_Bartender
	push	de
	ld	hl, #0x401
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:60: }
	ret
;main.c:80: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:85: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:86: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:88: setBackground();
	call	_setBackground
;main.c:89: loadSprites();
	call	_loadSprites
;main.c:91: setupSprites(&bartender, 1, 2, 2, 4, 1, 30, 30, 0, 0, Bartender);
	ld	de, #_Bartender
	push	de
	xor	a, a
	rrca
	push	af
	ld	hl, #0x1e1e
	push	hl
	ld	hl, #0x104
	push	hl
	ld	hl, #0x202
	push	hl
	ld	a, #0x01
	ld	de, #_bartender
	call	_setupSprites
;main.c:92: setupSprites(&wineglass, 0, 1, 1, 1, 0, 30, 30, 0, 0, Wine);
	ld	de, #_Wine
	push	de
	xor	a, a
	rrca
	push	af
	ld	hl, #0x1e1e
	push	hl
	ld	hl, #0x01
	push	hl
	ld	hl, #0x101
	push	hl
	xor	a, a
	ld	de, #_wineglass
	call	_setupSprites
;main.c:95: moveSprite(&wineglass, 20, 30);
	ld	a, #0x1e
	push	af
	inc	sp
	ld	a, #0x14
	ld	de, #_wineglass
	call	_moveSprite
;main.c:96: moveSprite(&bartender, 80, 140);
	ld	a, #0x8c
	push	af
	inc	sp
	ld	a, #0x50
	ld	de, #_bartender
	call	_moveSprite
;main.c:99: while (1) {
00102$:
;main.c:101: playerMovement(&bartender);
	ld	de, #_bartender
	call	_playerMovement
;main.c:103: scrollSprite(&wineglass, moveX, moveY);
	ld	a, (#_moveY)
	push	af
	inc	sp
	ld	a, (#_moveX)
	ld	de, #_wineglass
	call	_scrollSprite
;main.c:104: wait_vbl_done();
	call	_wait_vbl_done
;main.c:109: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
__xinit__backgroundmap:
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
__xinit__BackgroundTiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x4a	; 74	'J'
	.db #0x7e	; 126
	.db #0x52	; 82	'R'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x18	; 24
	.db #0xa5	; 165
	.db #0x5a	; 90	'Z'
	.db #0xa5	; 165
	.db #0x5a	; 90	'Z'
	.db #0x66	; 102	'f'
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__Bartender:
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x1e	; 30
	.db #0x11	; 17
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x58	; 88	'X'
	.db #0x58	; 88	'X'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x88	; 136
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x28	; 40
	.db #0x3f	; 63
	.db #0x28	; 40
	.db #0x2f	; 47
	.db #0x38	; 56	'8'
	.db #0x29	; 41
	.db #0x3f	; 63
	.db #0x12	; 18
	.db #0x16	; 22
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x14	; 20
	.db #0xfc	; 252
	.db #0x14	; 20
	.db #0xf4	; 244
	.db #0x1c	; 28
	.db #0x94	; 148
	.db #0xfc	; 252
	.db #0x48	; 72	'H'
	.db #0x68	; 104	'h'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
__xinit__moveY:
	.db #0x01	; 1
__xinit__moveX:
	.db #0x00	; 0
__xinit__yBounds:
	.db #0x00	; 0
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
