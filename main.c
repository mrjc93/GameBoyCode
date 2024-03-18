#include <gb/gb.h>
#include <stdio.h>
#include <stdlib.h>
#include "backgroundmap.c"
#include "backgroundtiles.c"



/// setting the second parameter in set_sprite_data to 0 means 256 tiles (the second parameter = amount of tiles)

// once I'm in a better position I will move onto the next stage of development, namely, sprite collisions


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

void main(){

   
SHOW_BKG;
SHOW_SPRITES;

set_bkg_data(0, 18, BackgroundTiles);
set_bkg_tiles(0, 0, 20, 18, backgroundmap);

SpawnSprites();

     




  








}

void SpawnSprites(){

   
//spawn all sprites in
set_sprite_data(0, 1, Wine);
set_sprite_data(1, 1, pint);
set_sprite_data(2, 1, character);

set_sprite_tile(0, 0);
set_sprite_tile(1, 1);
set_sprite_tile(2, 2);

move_sprite(0, 70, 30);
move_sprite(1, 30, 30);
move_sprite(2, 150, 140);


while (1) {
uint8_t buttons = joypad();
uint8_t moveX = 0;


 //handle falling sprites
scroll_sprite(0, 0, 1);
scroll_sprite(1, 0, 1);


//handle player controls
if (buttons & J_LEFT){
   moveX = -1;
}
else if (buttons & J_RIGHT){
   moveX = 1;
}

scroll_sprite(2, moveX, 0);


// update per frame
wait_vbl_done();


}


}






