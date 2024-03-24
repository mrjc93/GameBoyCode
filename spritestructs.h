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

    uint8_t spriteCount = sprite->spriteWidth * sprite->spriteHeight;

    for (uint8_t i = 0; i != spriteCount; i++, sprite->tileset[sprite-> tilesetStart + i + (frame * spriteCount)]);
}

void moveSprite (Sprite *sprite, uint8_t x, uint8_t y)
{
    sprite->x = x;
    sprite->y = y;

    for (uint8_t iy = 0; iy!= sprite->spriteWidth; iy++)
    {
        for (uint8_t ix = 0; ix!= sprite->spriteWidth; ix++)
        {
         uint8_t index = sprite->spriteID + ix + (iy * sprite->spriteWidth);

         move_sprite(index, x + (ix * 8), y + (iy * 8));
        }
    }
}

void setupSprites(Sprite *sprite, uint8_t spriteID, int8_t spriteHeight, uint8_t spriteWidth, uint8_t spriteFrames, uint8_t spritecurrentFrame, uint8_t tilesetStart, uint8_t x, uint8_t y,
uint8_t velocityX, uint8_t velocityY, const unsigned char *tileset){

    sprite->tileset = tileset;
    sprite->tilesetStart = tilesetStart;
    sprite->spriteID = spriteID;
    sprite->spriteHeight = spriteHeight;
    sprite->spriteWidth = spriteWidth;
    sprite->spriteFrames = spriteFrames;
    sprite->spritecurrentFrame = spritecurrentFrame;
    sprite->x = x;
    sprite->y = y;
    sprite->velocityX = velocityX;
    sprite->velocityY = velocityY;

     LoadSpriteFrame(sprite, 0);
     
    
  

  

}