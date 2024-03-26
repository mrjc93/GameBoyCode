#include <gb/gb.h>
#include <stdio.h>

typedef struct Sprite{

uint8_t spriteID;

uint8_t spriteHeight;

uint8_t spriteWidth;

uint8_t spriteFrames;

uint8_t spritecurrentFrame;

uint8_t tilesetStart;

uint8_t x;

uint8_t y;

uint8_t velocityX;

uint8_t velocityY;

const unsigned char *tileset;


}Sprite;

void LoadSpriteFrame(Sprite *sprite, uint8_t frame)
{
    sprite->spritecurrentFrame = frame;

    uint8_t spriteCount = sprite->spriteWidth + sprite->spriteHeight;

    for (uint8_t i = 0; i != spriteCount; i++)
    {
        set_sprite_tile(sprite->spriteID + i, sprite->tilesetStart + i);
    }
}

void moveSprite (Sprite *sprite, uint8_t x, uint8_t y)
{
    sprite->x = x;
    sprite->y = y;

    for (uint8_t iy = 0; iy!= sprite->spriteHeight; iy++)
    {
        for (uint8_t ix = 0; ix != sprite->spriteWidth; ix++)
        {
         uint8_t index = sprite->spriteID + ix + (iy * sprite->spriteWidth);

         move_sprite(index, x + (ix * 8), y + (iy * 8));
        }
    }
}

void scrollSprite(Sprite *sprite, uint8_t x, uint8_t y)
{
    uint8_t index = sprite->spriteID;
    sprite->x = x;
    sprite->y = y;

    uint8_t spriteCount = sprite->spriteWidth + sprite->spriteHeight;
if (spriteCount <= 2)
{
    scroll_sprite(sprite->tilesetStart, x, y);
}
else
{
for (uint8_t i = 0; i != spriteCount; i++)
    {
        scroll_sprite(sprite->tilesetStart + i, x, y);
    }
}


    


}

void playerMovement(Sprite *sprite)
{

   
int8_t moveX = 0;
uint8_t buttons = joypad();

uint8_t index = sprite->spriteID;
    

    uint8_t spriteCount = sprite->spriteWidth + sprite->spriteHeight;


if (buttons & J_LEFT){
   moveX = -1;
}
if (buttons & J_RIGHT){
   moveX = 1;
}

for (uint8_t i = 0; i != spriteCount; i++)
    {
        scroll_sprite(sprite->tilesetStart + i, moveX, 0);
    }
}






void setupSprites(Sprite *sprite, uint8_t spriteID, int8_t spriteHeight, uint8_t spriteWidth, uint8_t spriteFrames, uint8_t tilesetStart, uint8_t x, uint8_t y,
uint8_t velocityX, uint8_t velocityY, const unsigned char *tileset){

    sprite->tileset = tileset;
    sprite->tilesetStart = tilesetStart;
    sprite->spriteID = spriteID;
    sprite->spriteHeight = spriteHeight;
    sprite->spriteWidth = spriteWidth;
    sprite->spriteFrames = spriteFrames;
    
    sprite->x = x;
    sprite->y = y;
    sprite->velocityX = velocityX;
    sprite->velocityY = velocityY;

     LoadSpriteFrame(sprite, 0);
     
    
  

  

}

