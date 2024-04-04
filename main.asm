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
	.globl _playerMovement
	.globl _loadSprites
	.globl _setBackground
	.globl _setupCharacter
	.globl _moveCharacter
	.globl _LoadCharacterFrame
	.globl _setupSprites
	.globl _scrollSprite
	.globl _moveSprite
	.globl _LoadSpriteFrame
	.globl _getSpriteBox
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _spriteXpos
	.globl _characterXpos
	.globl _characterYpos
	.globl _spriteYpos
	.globl _Wine
	.globl _Bartender
	.globl _BackgroundTiles
	.globl _backgroundmap
	.globl _bartender
	.globl _wineglass
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_wineglass::
	.ds 15
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
_Wine::
	.ds 16
_spriteYpos::
	.ds 1
_characterYpos::
	.ds 1
_characterXpos::
	.ds 1
_spriteXpos::
	.ds 1
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
;spritestructs.h:45: void getSpriteBox(Sprite *sprite, uint8_t x, uint8_t y)
;	---------------------------------
; Function getSpriteBox
; ---------------------------------
_getSpriteBox::
	ld	c, a
;spritestructs.h:47: sprite->x = x;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), c
;spritestructs.h:48: sprite->y = y;
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:57: boxYbounds = sprite->YBounds;
;spritestructs.h:66: }
	pop	hl
	inc	sp
	jp	(hl)
;spritestructs.h:68: void LoadSpriteFrame(Sprite *sprite, uint8_t frame)
;	---------------------------------
; Function LoadSpriteFrame
; ---------------------------------
_LoadSpriteFrame::
	add	sp, #-4
	ld	c, e
	ld	b, d
	ld	e, a
;spritestructs.h:70: sprite->spritecurrentFrame = frame;
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), e
;spritestructs.h:72: uint8_t spriteCount = sprite->spriteWidth * sprite->spriteHeight;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	d, (hl)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	e, (hl)
	push	bc
	ld	a, d
;spritestructs.h:74: for (uint8_t i = 0; i != spriteCount; i++)
	call	__muluchar
	ldhl	sp,	#2
	ld	(hl), c
	pop	bc
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
;spritestructs.h:76: set_sprite_tile(sprite->spriteID + i, sprite->tilesetStart + i);
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
;spritestructs.h:74: for (uint8_t i = 0; i != spriteCount; i++)
	ldhl	sp,	#3
	inc	(hl)
	jr	00104$
00106$:
;spritestructs.h:78: }
	add	sp, #4
	ret
;spritestructs.h:80: void moveSprite (Sprite *sprite, uint8_t x, uint8_t y)
;	---------------------------------
; Function moveSprite
; ---------------------------------
_moveSprite::
	add	sp, #-8
	ld	c, e
	ld	b, d
	ldhl	sp,	#5
	ld	(hl), a
;spritestructs.h:82: sprite->x = x;
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:83: sprite->y = y;
	ld	hl, #0x0007
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:85: for (uint8_t iy = 0; iy!= sprite->spriteHeight; iy++)
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
;spritestructs.h:87: for (uint8_t ix = 0; ix != sprite->spriteWidth; ix++)
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
;spritestructs.h:89: uint8_t index = sprite->spriteID + ix + (iy * sprite->spriteWidth);
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
;spritestructs.h:91: move_sprite(index, x + (ix * 8), y + (iy * 8));
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
;spritestructs.h:87: for (uint8_t ix = 0; ix != sprite->spriteWidth; ix++)
	ldhl	sp,	#7
	inc	(hl)
	jr	00105$
00109$:
;spritestructs.h:85: for (uint8_t iy = 0; iy!= sprite->spriteHeight; iy++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00108$
00110$:
;spritestructs.h:94: }
	add	sp, #8
	pop	hl
	inc	sp
	jp	(hl)
;spritestructs.h:96: void scrollSprite(Sprite *sprite, uint8_t x, uint8_t y)
;	---------------------------------
; Function scrollSprite
; ---------------------------------
_scrollSprite::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;spritestructs.h:99: sprite->x = x;
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:100: sprite->y = y;
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:106: scroll_sprite(sprite->tilesetStart, x, y);
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #0x0005
	add	hl, de
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ldhl	sp,	#0
	add	a, (hl)
	inc	hl
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, (hl)
;spritestructs.h:113: getSpriteBox(sprite, x, y);
	dec	hl
	ld	(bc), a
	ld	a, (hl+)
	push	af
	inc	sp
	ld	a, (hl)
;spritestructs.h:118: }
	call	_getSpriteBox
	pop	hl
	pop	hl
	inc	sp
	jp	(hl)
;spritestructs.h:124: void setupSprites(Sprite *sprite, uint8_t spriteID, int8_t spriteHeight, uint8_t spriteWidth, uint8_t spriteFrames, uint8_t tilesetStart, uint8_t x, uint8_t y,
;	---------------------------------
; Function setupSprites
; ---------------------------------
_setupSprites::
	add	sp, #-5
	ld	c, e
	ld	b, d
	ldhl	sp,	#4
	ld	(hl), a
;spritestructs.h:127: sprite->tileset = tileset;
	ld	hl, #0x000d
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:128: sprite->tilesetStart = tilesetStart;
	ld	hl, #0x0005
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:129: sprite->spriteID = spriteID;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(bc), a
;spritestructs.h:130: sprite->spriteHeight = spriteHeight;
	ld	e, c
	ld	d, b
	inc	de
	ldhl	sp,	#7
;spritestructs.h:131: sprite->spriteWidth = spriteWidth;
	ld	a, (hl+)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
;spritestructs.h:132: sprite->spriteFrames = spriteFrames;
	ld	a, (hl+)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:134: sprite->x = x;
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:135: sprite->y = y;
	ld	hl, #0x0007
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:136: sprite->velocityX = velocityX;
	ld	hl, #0x0008
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:137: sprite->velocityY = velocityY;
	ld	hl, #0x0009
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:138: sprite->Ypos = sprite->y = Ypos;
	ld	hl, #0x000c
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	pop	de
	push	de
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(de), a
;spritestructs.h:140: LoadSpriteFrame(sprite, 0);
	xor	a, a
	ld	e, c
	ld	d, b
	call	_LoadSpriteFrame
;spritestructs.h:149: }
	add	sp, #5
	pop	hl
	add	sp, #11
	jp	(hl)
;characterstruct.h:36: void LoadCharacterFrame(Character *character, uint8_t frame)
;	---------------------------------
; Function LoadCharacterFrame
; ---------------------------------
_LoadCharacterFrame::
	add	sp, #-4
	ld	c, e
	ld	b, d
	ld	e, a
;characterstruct.h:38: character->charactercurrentFrame = frame;
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), e
;characterstruct.h:40: uint8_t characterCount = character->characterWidth + character->characterHeight;
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
;characterstruct.h:42: for (uint8_t i = 0; i != characterCount; i++)
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
;characterstruct.h:44: set_sprite_tile(character->characterID + i, character->charactertilesetStart + i);
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
;characterstruct.h:42: for (uint8_t i = 0; i != characterCount; i++)
	ldhl	sp,	#3
	inc	(hl)
	jr	00104$
00106$:
;characterstruct.h:46: }
	add	sp, #4
	ret
;characterstruct.h:48: void moveCharacter (Character *character, uint8_t x, uint8_t y)
;	---------------------------------
; Function moveCharacter
; ---------------------------------
_moveCharacter::
	add	sp, #-8
	ld	c, e
	ld	b, d
	ldhl	sp,	#5
	ld	(hl), a
;characterstruct.h:50: character->characterX = x;
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;characterstruct.h:51: character->characterY = y;
	ld	hl, #0x0007
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(de), a
;characterstruct.h:53: for (uint8_t iy = 0; iy!= character->characterHeight; iy++)
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
;characterstruct.h:55: for (uint8_t ix = 0; ix != character->characterWidth; ix++)
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
;characterstruct.h:57: uint8_t index = character->characterID + ix + (iy * character->characterWidth);
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
;characterstruct.h:59: move_sprite(index, x + (ix * 8), y + (iy * 8));
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
;characterstruct.h:55: for (uint8_t ix = 0; ix != character->characterWidth; ix++)
	ldhl	sp,	#7
	inc	(hl)
	jr	00105$
00109$:
;characterstruct.h:53: for (uint8_t iy = 0; iy!= character->characterHeight; iy++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00108$
00110$:
;characterstruct.h:62: }
	add	sp, #8
	pop	hl
	inc	sp
	jp	(hl)
;characterstruct.h:70: void setupCharacter(Character *character, uint8_t characterID, int8_t characterHeight, uint8_t characterWidth, uint8_t characterFrames, uint8_t charactertilesetStart, uint8_t characterX, uint8_t characterY,
;	---------------------------------
; Function setupCharacter
; ---------------------------------
_setupCharacter::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;characterstruct.h:73: character->charactertileset = charactertileset;
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
;characterstruct.h:74: character->charactertilesetStart = charactertilesetStart;
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
;characterstruct.h:75: character->characterID = characterID;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;characterstruct.h:76: character->characterHeight = characterHeight;
	ld	c, e
	ld	b, d
	inc	bc
	ldhl	sp,	#3
;characterstruct.h:77: character->characterWidth = characterWidth;
	ld	a, (hl+)
	ld	(bc), a
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
;characterstruct.h:78: character->characterFrames = characterFrames;
	ld	a, (hl+)
	ld	(bc), a
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;characterstruct.h:80: character->characterX = characterX;
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(bc), a
;characterstruct.h:81: character->characterY = characterY;
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(bc), a
;characterstruct.h:82: character->charactervelocityX = charactervelocityX;
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(bc), a
;characterstruct.h:83: character->charactervelocityY = charactervelocityY;
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(bc), a
;characterstruct.h:85: LoadCharacterFrame(character, 0);
	xor	a, a
	call	_LoadCharacterFrame
;characterstruct.h:92: }
	inc	sp
	pop	hl
	add	sp, #10
	jp	(hl)
;main.c:26: void setBackground(void){
;	---------------------------------
; Function setBackground
; ---------------------------------
_setBackground::
;main.c:28: set_bkg_data(0, 18, BackgroundTiles);
	ld	de, #_BackgroundTiles
	push	de
	ld	hl, #0x1200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:29: set_bkg_tiles(0, 0, 20, 18, backgroundmap);
	ld	de, #_backgroundmap
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:32: }
	ret
;main.c:34: void loadSprites(void)
;	---------------------------------
; Function loadSprites
; ---------------------------------
_loadSprites::
;main.c:36: set_sprite_data(0, 1, Wine);
	ld	de, #_Wine
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_data
	add	sp, #4
;main.c:37: set_sprite_data(1, 4, Bartender);
	ld	de, #_Bartender
	push	de
	ld	hl, #0x401
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:40: }
	ret
;main.c:42: void playerMovement(Character *character)
;	---------------------------------
; Function playerMovement
; ---------------------------------
_playerMovement::
	add	sp, #-3
;main.c:46: int8_t moveX = 0;
	ld	c, #0x00
;main.c:47: uint8_t buttons = joypad();
	push	de
	call	_joypad
	ld	b, a
	pop	de
;main.c:52: uint8_t characterCount = character->characterWidth + character->characterHeight;
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
;main.c:55: if (buttons & J_LEFT){
	bit	1, b
	jr	Z, 00102$
;main.c:56: moveX = -1;
	ld	c, #0xff
;main.c:57: characterXpos = characterXpos -1;
	ld	hl, #_characterXpos
	dec	(hl)
	ld	a, (hl)
00102$:
;main.c:60: if (buttons & J_RIGHT){
	bit	0, b
	jr	Z, 00115$
;main.c:61: moveX = 1;
	ld	c, #0x01
;main.c:62: characterXpos = characterXpos +1;
	ld	hl, #_characterXpos
	inc	(hl)
	ld	a, (hl)
;main.c:65: for (uint8_t i = 0; i != characterCount; i++)
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
;main.c:67: scroll_sprite(character->charactertilesetStart + i, moveX, 0);
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
;main.c:65: for (uint8_t i = 0; i != characterCount; i++)
	inc	b
	jr	00108$
00110$:
;main.c:69: }
	add	sp, #3
	ret
;main.c:83: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;main.c:88: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:89: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:91: setBackground();
	call	_setBackground
;main.c:92: loadSprites();
	call	_loadSprites
;main.c:94: setupCharacter(&bartender, 1, 2, 2, 4, 1, 1, 1, 0, 0, Bartender);
	ld	de, #_Bartender
	push	de
	xor	a, a
	rrca
	push	af
	ld	hl, #0x101
	push	hl
	ld	hl, #0x104
	push	hl
	ld	hl, #0x202
	push	hl
	ld	a, #0x01
	ld	de, #_bartender
	call	_setupCharacter
;main.c:95: setupSprites(&wineglass, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, Wine);
	ld	de, #_Wine
	push	de
	xor	a, a
	rrca
	push	af
	xor	a, a
	ld	h, a
	ld	l, #0x01
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #0x01
	push	hl
	ld	hl, #0x101
	push	hl
	xor	a, a
	ld	de, #_wineglass
	call	_setupSprites
;main.c:98: moveSprite(&wineglass, 20, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x14
	ld	de, #_wineglass
	call	_moveSprite
;main.c:99: moveCharacter(&bartender, 80, 140);
	ld	a, #0x8c
	push	af
	inc	sp
	ld	a, #0x50
	ld	de, #_bartender
	call	_moveCharacter
;main.c:102: while (1) {
00131$:
;main.c:104: playerMovement(&bartender);
	ld	de, #_bartender
	call	_playerMovement
;main.c:107: scrollSprite(&wineglass, 0, 1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	ld	de, #_wineglass
	call	_scrollSprite
;main.c:108: spriteYpos++;
	ld	hl, #_spriteYpos
	inc	(hl)
;main.c:109: if(spriteYpos == characterYpos && spriteXpos == characterXpos || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 1 ||spriteYpos ==  characterYpos && spriteXpos == characterXpos + 10 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 9 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 8 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 7 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 5 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 4 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 6 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 2 || spriteYpos ==  characterYpos && spriteXpos == characterXpos + 3 || spriteYpos ==  characterYpos && spriteXpos == characterXpos - 1 || spriteYpos ==  characterYpos && spriteXpos == characterXpos - 2 || spriteYpos ==  characterYpos && spriteXpos == characterXpos - 3){
	ld	a, (hl)
	ld	hl, #_characterYpos
	sub	a, (hl)
	ld	a, #0x01
	jr	Z, 00241$
	xor	a, a
00241$:
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
	ld	a, (#_spriteXpos)
	ld	hl, #_characterXpos
	sub	a, (hl)
	jp	Z,00101$
00105$:
	ld	hl, #_characterXpos
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_spriteXpos
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	a, l
	sub	a, e
	jr	NZ, 00243$
	ld	a, h
	sub	a, d
	jp	Z,00101$
00243$:
00107$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00109$
	ld	hl, #0x000a
	add	hl, bc
	ld	a, l
	sub	a, e
	jr	NZ, 00244$
	ld	a, h
	sub	a, d
	jp	Z,00101$
00244$:
00109$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
	ld	hl, #0x0009
	add	hl, bc
	ld	a, l
	sub	a, e
	jr	NZ, 00245$
	ld	a, h
	sub	a, d
	jp	Z,00101$
00245$:
00111$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	ld	hl, #0x0008
	add	hl, bc
	ld	a, l
	sub	a, e
	jr	NZ, 00246$
	ld	a, h
	sub	a, d
	jp	Z,00101$
00246$:
00113$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00115$
	ld	hl, #0x0007
	add	hl, bc
	ld	a, l
	sub	a, e
	jr	NZ, 00247$
	ld	a, h
	sub	a, d
	jp	Z,00101$
00247$:
00115$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
	ld	hl, #0x0005
	add	hl, bc
	ld	a, l
	sub	a, e
	jr	NZ, 00248$
	ld	a, h
	sub	a, d
	jp	Z,00101$
00248$:
00117$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00119$
	ld	hl, #0x0004
	add	hl, bc
	ld	a, l
	sub	a, e
	jr	NZ, 00249$
	ld	a, h
	sub	a, d
	jr	Z, 00101$
00249$:
00119$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00121$
	ld	hl, #0x0006
	add	hl, bc
	ld	a, l
	sub	a, e
	jr	NZ, 00250$
	ld	a, h
	sub	a, d
	jr	Z, 00101$
00250$:
00121$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00123$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	a, l
	sub	a, e
	jr	NZ, 00251$
	ld	a, h
	sub	a, d
	jr	Z, 00101$
00251$:
00123$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00125$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, l
	sub	a, e
	jr	NZ, 00252$
	ld	a, h
	sub	a, d
	jr	Z, 00101$
00252$:
00125$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00127$
	ld	l, c
	ld	h, b
	dec	hl
	ld	a, l
	sub	a, e
	jr	NZ, 00253$
	ld	a, h
	sub	a, d
	jr	Z, 00101$
00253$:
00127$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00129$
	ld	l, c
	ld	h, b
	dec	hl
	dec	hl
	ld	a, l
	sub	a, e
	jr	NZ, 00254$
	ld	a, h
	sub	a, d
	jr	Z, 00101$
00254$:
00129$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, c
	add	a, #0xfd
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	a, c
	sub	a, e
	jr	NZ, 00102$
	ld	a, b
	sub	a, d
	jr	NZ, 00102$
00101$:
;main.c:110: spriteYpos = 0;
	ld	hl, #_spriteYpos
	ld	(hl), #0x00
;main.c:111: moveSprite(&wineglass, 20, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x14
	ld	de, #_wineglass
	call	_moveSprite
00102$:
;main.c:118: wait_vbl_done();
	call	_wait_vbl_done
	jp	00131$
;main.c:123: }
	inc	sp
	ret
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
__xinit__Wine:
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
__xinit__spriteYpos:
	.db #0x00	; 0
__xinit__characterYpos:
	.db #0x8c	; 140
__xinit__characterXpos:
	.db #0x50	; 80	'P'
__xinit__spriteXpos:
	.db #0x14	; 20
	.area _CABS (ABS)
