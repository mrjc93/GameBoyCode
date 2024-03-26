#include <gb/gb.h>
#include <stdio.h>
#include <stdlib.h>
#include "backgroundmap.c"
#include "backgroundtiles.c"
#include <rand.h>
#include <time.h>
#include "spritestructs.h"
#include "Bartender.c"
#include "wine.c"
#include "characterstruct.c"
/// setting the second parameter in set_sprite_data to 0 means 256 tiles (the second parameter = amount of tiles)

// I need to figure out how to get a RNG into my code


Sprite wineglass;
Character bartender;

void setBackground(void){

set_bkg_data(0, 18, BackgroundTiles);
set_bkg_tiles(0, 0, 20, 18, backgroundmap);


}

void loadSprites(void)
{
set_sprite_data(0, 1, Wine);
set_sprite_data(1, 4, Bartender);


}




void main(void)
{


//DISPLAY_ON;
SHOW_BKG;
SHOW_SPRITES;

setBackground();
loadSprites();

setupCharacter(&bartender, 1, 2, 2, 4, 1, 30, 30, 0, 0, Bartender);
setupSprites(&wineglass, 0, 1, 1, 1, 0, 30, 30, 0, 0, Wine);


moveSprite(&wineglass, 20, 30);
moveCharacter(&bartender, 80, 140);


while (1) {

playerMovement(&bartender);

scrollSprite(&wineglass, 0, 1);
wait_vbl_done();


}

}







