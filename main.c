#include <gb/gb.h>
#include <stdio.h>
#include <stdlib.h>
#include "backgroundmap.c"
#include "backgroundtiles.c"
#include <rand.h>
#include <time.h>
#include "spritestructs.h"
#include "Bartender.c"

/// setting the second parameter in set_sprite_data to 0 means 256 tiles (the second parameter = amount of tiles)

// I need to figure out how to get a RNG into my code


Sprite wineglass;
Sprite bartender;

uint8_t moveY= 1;
uint8_t moveX= 0;
uint8_t yBounds = 0;
const unsigned char BKGtile[] =
{
  0xFF,0x00,0x81,0x7E,0xBD,0x42,0xA5,0x5A,
  0xA5,0x5A,0xBD,0x42,0x81,0x7E,0xFF,0x00
};

const unsigned char pint[] =
{
  0x7E,0x42,0x42,0x7E,0x42,0x7E,0x42,0x7E,
  0x42,0x7E,0x42,0x7E,0x42,0x7E,0x3C,0x3C
};

const unsigned char Wine[] =
{
  0x42,0x7E,0x42,0x7E,0x42,0x7E,0x3C,0x3C,
  0x18,0x18,0x18,0x18,0x18,0x18,0x3C,0x3C
};

unsigned char character[] =
{
  0x7E,0x7E,0x42,0x5A,0x42,0x42,0x7E,0x7E,
  0x18,0x18,0x3C,0x3C,0x18,0x18,0x24,0x24
};

void setBackground(void){

set_bkg_data(0, 18, BackgroundTiles);
set_bkg_tiles(0, 0, 20, 18, backgroundmap);


}

void loadSprites(void)
{
set_sprite_data(0, 1, Wine);
set_sprite_data(1, 4, Bartender);


}




/*void playerMovement(void)
{
int8_t moveX = 0;
uint8_t buttons = joypad();

if (buttons & J_LEFT){
   moveX = -1;
}
if (buttons & J_RIGHT){
   moveX = 1;
}
*/



void main(void)
{


//DISPLAY_ON;
SHOW_BKG;
SHOW_SPRITES;

setBackground();
loadSprites();

setupSprites(&bartender, 1, 2, 2, 4, 1, 30, 30, 0, 0, Bartender);
setupSprites(&wineglass, 0, 1, 1, 1, 0, 30, 30, 0, 0, Wine);


moveSprite(&wineglass, 20, 30);
moveSprite(&bartender, 80, 140);


while (1) {

playerMovement(&bartender);

scrollSprite(&wineglass, moveX, moveY);
wait_vbl_done();


}

}







