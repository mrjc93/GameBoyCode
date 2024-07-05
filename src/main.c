
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
#include "startscreen.c"
#include "gameoverscreen.c"
#include <gbdk/font.h>
#include "windowmap.c"
Sprite wineglass;
Character bartender;
uint8_t spriteYpos = 0;
uint8_t characterYpos = 140;
uint8_t characterXpos = 80;


void setmenuBackground(void)
{

    set_bkg_data(0, 211, splashscreen_tileset);
    set_bkg_tiles(0, 0, 20, 18, splashscreen_tilemap);
}

void setBackground(void)
{

    set_bkg_data(37, 18, BackgroundTiles);
    set_bkg_tiles(0, 0, 20, 18, backgroundmap);
}

void setGameover(void)
{
   set_bkg_data(0, 84, gameoverscreen_tileset);
   set_bkg_tiles(0, 0, 20, 18, gameoverscreen_tilemap);

}
void loadSprites(void)
{
    set_sprite_data(0, 1, Wine);
    set_sprite_data(1, 4, Bartender);
}

void setFont(void)
{
    font_t min_font;
    font_init();
    min_font = font_load(font_min);
    font_set(min_font);
    SHOW_WIN;
}

void setWindow(void)
{
    set_win_tiles(0, 0, 5, 1, windowmap);
    move_win(7, 130);
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

    void gameoverCheck(uint8_t lives)
    {
        if (lives == 0)
        {

        
            HIDE_SPRITES;
            setGameover();
            waitpad(J_UP);
            reset();

          
            
            

        }
       
     

   
    }



void main() 
{
    NR52_REG = 0x80;
    NR50_REG = 0x77;
    NR51_REG = 0xFF;
    DISPLAY_ON;
    SHOW_BKG;
    
    
    
    

    
    setFont();
    SHOW_SPRITES;



    initialize_random();
    uint8_t spriteXpos = random_number(20, 160);
    uint8_t lives = 3;
    setBackground();
    loadSprites();
    setWindow();


    setupCharacter(&bartender, 1, 2, 2, 4, 1, 1, 1,   Bartender);
    setupSprites(&wineglass, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, Wine);

    moveSprite(&wineglass, spriteXpos, 0);
    moveCharacter(&bartender, 80, 140);
    
  
    


   
    while (1)
    {
       
        playerMovement(&bartender);
        scrollSprite(&wineglass, 0, 1);
        spriteYpos++;
        if (spriteYpos == characterYpos && spriteXpos == characterXpos || spriteYpos == characterYpos && spriteXpos == characterXpos + 1 || spriteYpos == characterYpos && spriteXpos == characterXpos + 10 || spriteYpos == characterYpos && spriteXpos == characterXpos + 9 || spriteYpos == characterYpos && spriteXpos == characterXpos + 8 || spriteYpos == characterYpos && spriteXpos == characterXpos + 7 || spriteYpos == characterYpos && spriteXpos == characterXpos + 5 || spriteYpos == characterYpos && spriteXpos == characterXpos + 4 || spriteYpos == characterYpos && spriteXpos == characterXpos + 6 || spriteYpos == characterYpos && spriteXpos == characterXpos + 2 || spriteYpos == characterYpos && spriteXpos == characterXpos + 3 || spriteYpos == characterYpos && spriteXpos == characterXpos - 1 || spriteYpos == characterYpos && spriteXpos == characterXpos - 2 || spriteYpos == characterYpos && spriteXpos == characterXpos - 3)
        {
            
            spriteYpos = 0;
            spriteXpos = random_number(20, 160);
           NR41_REG=0x3A;
           NR42_REG=0xA1;
           NR43_REG=0x00;
           NR44_REG=0xC0;
            moveSprite(&wineglass, spriteXpos, spriteYpos);

           
        }
        else if (spriteYpos == 150)
        {
         spriteYpos = 0;
         spriteXpos = random_number(20, 160);
         lives--;
        NR21_REG = 0x81;
        NR22_REG = 0x84;
        NR23_REG = 0xD7;
        NR24_REG = 0x86;
         moveSprite(&wineglass, spriteXpos, spriteYpos);
         gameoverCheck(lives);
       

        }

       

        

        
        wait_vbl_done();

    }

    

  
    
    

}
