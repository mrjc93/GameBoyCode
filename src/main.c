#include <gb/gb.h>
#include <stdio.h>
#include <rand.h>
#include "backgroundmap.c"
#include "backgroundtiles.c"
#include "spritestructs.h"
#include "characterstruct.h"
#include "Bartender.c"
#include "wine.c"
#include "utils.c"

#define NUM_CHARACTERS 1
#define NUM_SPRITES 1

Sprite wineglass;
Character bartender;
uint8_t spriteYpos = 0;
uint8_t characterYpos = 140;
uint8_t characterXpos = 80;


void setBackground(void)
{

    set_bkg_data(0, 18, BackgroundTiles);
    set_bkg_tiles(0, 0, 20, 18, backgroundmap);
}

void loadSprites(void)
{
    set_sprite_data(0, 1, Wine);
    set_sprite_data(1, 4, Bartender);
}

void playerMovement(Character *character)
{

    int8_t moveX = 0;
    uint8_t buttons = joypad();

    uint8_t index = character->characterID;

    uint8_t characterCount = character->characterWidth + character->characterHeight;

    if (buttons & J_LEFT)
    {
        moveX = -1;
        characterXpos = characterXpos - 1;
       
    }
    if (buttons & J_RIGHT)
    {
        moveX = 1;
        characterXpos = characterXpos + 1;
        
    }
    for (uint8_t i = 0; i != characterCount; i++)
    {
        scroll_sprite(character->charactertilesetStart + i, moveX, 0);
        
    }
}

void main(void)
{
    DISPLAY_ON;
    
    printf ("\n\n\n\n\n\n Press up to Start!");
    
    waitpad(J_UP);

    
    SHOW_BKG;
    SHOW_SPRITES;



    initialize_random();
    uint8_t spriteXpos = random_number(20, 160);
    setBackground();
    loadSprites();


    setupCharacter(&bartender, 1, 2, 2, 4, 1, 1, 1, 0, 0, Bartender);
    setupSprites(&wineglass, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, Wine);

    moveSprite(&wineglass, spriteXpos, 0);
    moveCharacter(&bartender, 80, 140);
    
  
    


    uint8_t lives = 3;
    while (lives > 0)
    {
       
        playerMovement(&bartender);
        scrollSprite(&wineglass, 0, 1);
        spriteYpos++;
        if (spriteYpos == characterYpos && spriteXpos == characterXpos || spriteYpos == characterYpos && spriteXpos == characterXpos + 1 || spriteYpos == characterYpos && spriteXpos == characterXpos + 10 || spriteYpos == characterYpos && spriteXpos == characterXpos + 9 || spriteYpos == characterYpos && spriteXpos == characterXpos + 8 || spriteYpos == characterYpos && spriteXpos == characterXpos + 7 || spriteYpos == characterYpos && spriteXpos == characterXpos + 5 || spriteYpos == characterYpos && spriteXpos == characterXpos + 4 || spriteYpos == characterYpos && spriteXpos == characterXpos + 6 || spriteYpos == characterYpos && spriteXpos == characterXpos + 2 || spriteYpos == characterYpos && spriteXpos == characterXpos + 3 || spriteYpos == characterYpos && spriteXpos == characterXpos - 1 || spriteYpos == characterYpos && spriteXpos == characterXpos - 2 || spriteYpos == characterYpos && spriteXpos == characterXpos - 3)
        {
            
            spriteYpos = 0;
            spriteXpos = random_number(20, 160);
            moveSprite(&wineglass, spriteXpos, spriteYpos);
           
        }
        else if (spriteYpos == 150)
        {
         spriteYpos = 0;
         spriteXpos = random_number(20, 160);
         lives--;
         moveSprite(&wineglass, spriteXpos, spriteYpos);
        }

        
        

        wait_vbl_done();
    }

  
    HIDE_SPRITES;
    printf ("\n\n\n\n\n\n      You lose                          ");
}
