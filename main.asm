;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _printf
	.globl _set_sprite_data
	.globl _joypad
	.globl _delay
	.globl _apple
	.globl _smiler
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
_smiler::
	.ds 48
_apple::
	.ds 32
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
;main.c:9: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-3
;main.c:12: int characterX = 20;
	ldhl	sp,	#1
	ld	a, #0x14
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:13: int characterY = 20;
	ld	bc, #0x0014
;main.c:15: set_sprite_data(0, 2, smiler);
	ld	de, #_smiler
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, #0x14
	ld	(hl+), a
	ld	(hl), #0x14
;main.c:22: set_sprite_data(2, 2, apple);
	ld	de, #_apple
	push	de
	ld	hl, #0x202
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, #0x64
	ld	(hl+), a
	ld	(hl), #0x64
;main.c:26: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:28: while (1)
00110$:
;main.c:30: switch (joypad())
	call	_joypad
	ld	a, e
;main.c:34: move_sprite(0, characterX, characterY);
	ldhl	sp,	#0
	ld	(hl), c
;main.c:30: switch (joypad())
	cp	a, #0x01
	jr	Z, 00102$
	cp	a, #0x02
	jr	Z, 00101$
;main.c:34: move_sprite(0, characterX, characterY);
	inc	hl
	ld	e, (hl)
;main.c:30: switch (joypad())
	cp	a, #0x04
	jr	Z, 00103$
	sub	a, #0x08
	jr	Z, 00104$
	jp	00105$
;main.c:32: case J_LEFT:
00101$:
;main.c:33: characterX -= 10;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#2
	ld	(hl-), a
;main.c:34: move_sprite(0, characterX, characterY);
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:35: delay(200);
	push	bc
	ld	de, #0x00c8
	push	de
	call	_delay
	pop	hl
	pop	bc
;main.c:36: break;
	jr	00105$
;main.c:37: case J_RIGHT:
00102$:
;main.c:38: characterX += 10;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
;main.c:39: move_sprite(0, characterX, characterY);
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, d
	ld	(hl+), a
	ld	(hl), e
;main.c:40: delay(200);
	push	bc
	ld	de, #0x00c8
	push	de
	call	_delay
	pop	hl
	pop	bc
;main.c:41: break;
	jr	00105$
;main.c:42: case J_UP:
00103$:
;main.c:43: characterY -= 10;
	ld	a, c
	add	a, #0xf6
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;main.c:44: move_sprite(0, characterX, characterY);
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, c
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), e
;main.c:45: delay(200);
	push	bc
	ld	de, #0x00c8
	push	de
	call	_delay
	pop	hl
	pop	bc
;main.c:46: break;
	jr	00105$
;main.c:47: case J_DOWN:
00104$:
;main.c:48: characterY += 10;
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
;main.c:49: move_sprite(0, characterX, characterY);
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, c
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), e
;main.c:50: delay(200);
	push	bc
	ld	de, #0x00c8
	push	de
	call	_delay
	pop	hl
	pop	bc
;main.c:52: }
00105$:
;main.c:53: if (characterX == appleX && characterY == appleY)
	ldhl	sp,	#1
	ld	a, (hl+)
	sub	a, #0x64
	or	a, (hl)
	jp	NZ,00110$
	ld	a, c
	sub	a, #0x64
	or	a, b
	jp	NZ,00110$
;/home/svahnen/Projects/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x03
;main.c:58: printf("You won!");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;main.c:59: break;
;main.c:62: }
	add	sp, #3
	ret
___str_0:
	.ascii "You won!"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__smiler:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
__xinit__apple:
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x10	; 16
	.db #0x6e	; 110	'n'
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
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
	.area _CABS (ABS)
