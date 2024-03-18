#include <gb/gb.h>
#include <stdio.h>
#include <stdlib.h>
#include "wine.c"
#include "pint.c"
#include "character.c"
#include "BKGtile.c"






void main(){

   

SHOW_SPRITES;



SpawnSprites();

     




  








}

void SpawnSprites(){

   
//spawn all sprites in
set_sprite_data(0, 0, Wine);
set_sprite_data(1, 0, pint);
set_sprite_data(2, 0, character);

set_sprite_tile(0, 0);
set_sprite_tile(1, 1);
set_sprite_tile(2, 2);

move_sprite(0, 70, 30);
move_sprite(1, 30, 30);
move_sprite(2, 150, 150);


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






