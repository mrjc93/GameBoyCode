#ifndef CHARACTERSTRUCTS_H
#define CHARACTERSTRUCTS_H

#include <gb/gb.h>
#include <stdio.h>

typedef struct Character
{

    uint8_t characterID;

    uint8_t characterHeight;

    uint8_t characterWidth;

    uint8_t characterFrames;

    uint8_t charactercurrentFrame;

    uint8_t charactertilesetStart;

    uint8_t characterX;

    uint8_t characterY;

    uint8_t charactervelocityX;

    uint8_t charactervelocityY;

    const unsigned char *charactertileset;

} Character;

void LoadCharacterFrame(Character *character, uint8_t frame)
{
    character->charactercurrentFrame = frame;

    uint8_t characterCount = character->characterWidth + character->characterHeight;

    for (uint8_t i = 0; i != characterCount; i++)
    {
        set_sprite_tile(character->characterID + i, character->charactertilesetStart + i);
    }
}

void moveCharacter(Character *character, uint8_t x, uint8_t y)
{
    character->characterX = x;
    character->characterY = y;

    for (uint8_t iy = 0; iy != character->characterHeight; iy++)
    {
        for (uint8_t ix = 0; ix != character->characterWidth; ix++)
        {
            uint8_t index = character->characterID + ix + (iy * character->characterWidth);

            move_sprite(index, x + (ix * 8), y + (iy * 8));
        }
    }
}

void setupCharacter(Character *character, uint8_t characterID, int8_t characterHeight, uint8_t characterWidth, uint8_t characterFrames, uint8_t charactertilesetStart, uint8_t characterX, uint8_t characterY,
                    uint8_t charactervelocityX, uint8_t charactervelocityY, const unsigned char *charactertileset)
{

    character->charactertileset = charactertileset;
    character->charactertilesetStart = charactertilesetStart;
    character->characterID = characterID;
    character->characterHeight = characterHeight;
    character->characterWidth = characterWidth;
    character->characterFrames = characterFrames;

    character->characterX = characterX;
    character->characterY = characterY;
    character->charactervelocityX = charactervelocityX;
    character->charactervelocityY = charactervelocityY;

    LoadCharacterFrame(character, 0);
}

#endif