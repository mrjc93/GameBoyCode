#include <gb/gb.h>
#include <stdio.h>
#include "spritestructs.h"
#include "characterstruct.h"

#define TILEMAP_HEIGHT 160
#define TILEMAP_WIDTH 140
#define TILE_WIDTH 8
#define TILE_HEIGHT 8
#define CHARACTER_TILE_INDEX 1
#define SPRITE_TILE_INDEX 2

unsigned char tilemap[TILEMAP_HEIGHT][TILEMAP_WIDTH];

void initializeTilemap(void) {
    for (int y = 0; y < TILEMAP_HEIGHT; y++) {
        for (int x = 0; x < TILEMAP_WIDTH; x++) {
            tilemap[y][x] = 0; 
        }
    }
}

void UpdateTileMapWithSprites(Character *characters, Sprite *sprites, uint8_t numCharacters, uint8_t numSprites) {
    initializeTilemap();

    // Update tilemap with characters
    for (uint8_t i = 0; i < numCharacters; i++) {
        Character *character = &characters[i];
        uint8_t charactertileX = character->characterX / TILE_WIDTH;
        uint8_t charactertileY = character->characterY / TILE_HEIGHT;

        for (uint8_t y = 0; y < character->characterHeight / TILE_HEIGHT; y++) {
            for (uint8_t x = 0; x < character->characterWidth / TILE_WIDTH; x++) {
                tilemap[charactertileY + y][charactertileX + x] = CHARACTER_TILE_INDEX;
            }
        }
    }

    // Update tilemap with sprites
    for (uint8_t i = 0; i < numSprites; i++) {
        Sprite *sprite = &sprites[i];
        uint8_t spritetileX = sprite->x / TILE_WIDTH;
        uint8_t spritetileY = sprite->y / TILE_HEIGHT;

        for (uint8_t y = 0; y < sprite->spriteHeight / TILE_HEIGHT; y++) {
            for (uint8_t x = 0; x < sprite->spriteWidth / TILE_WIDTH; x++) {
                // Check if the tile is already occupied by a character
                if (tilemap[spritetileY + y][spritetileX + x] != CHARACTER_TILE_INDEX) {
                    tilemap[spritetileY + y][spritetileX + x] = SPRITE_TILE_INDEX;
                } else {
                    // Handle overlapping characters and sprites
                    // For example, mark the tile as both character and sprite
                    tilemap[spritetileY + y][spritetileX + x] |= SPRITE_TILE_INDEX;
                }
            }
        }
    }
}

void checkCollisions(Character *character, Sprite *sprite) {
    // Calculate the bounding boxes for character and sprite
    uint8_t charLeft = character->characterX;
    uint8_t charRight = character->characterX + character->characterWidth;
    uint8_t charTop = character->characterY;
    uint8_t charBottom = character->characterY + character->characterHeight;

    uint8_t spriteLeft = sprite->x;
    uint8_t spriteRight = sprite->x + sprite->spriteWidth;
    uint8_t spriteTop = sprite->y;
    uint8_t spriteBottom = sprite->y + sprite->spriteHeight;

    // Convert bounds to tile coordinates
    uint8_t charTileLeft = charLeft / TILE_WIDTH;
    uint8_t charTileRight = charRight / TILE_WIDTH;
    uint8_t charTileTop = charTop / TILE_HEIGHT;
    uint8_t charTileBottom = charBottom / TILE_HEIGHT;

    uint8_t spriteTileLeft = spriteLeft / TILE_WIDTH;
    uint8_t spriteTileRight = spriteRight / TILE_WIDTH;
    uint8_t spriteTileTop = spriteTop / TILE_HEIGHT;
    uint8_t spriteTileBottom = spriteBottom / TILE_HEIGHT;

    // Iterate over tiles within the bounding box of character and sprite
    for (uint8_t y = charTileTop; y <= charTileBottom; y++) {
        for (uint8_t x = charTileLeft; x <= charTileRight; x++) {
            // Check collision with character's bounding box
            if (tilemap[y][x] != 0) {
                // Handle collision
                // Example: Adjust character's position or trigger action
            }
        }
    }

    for (uint8_t y = spriteTileTop; y <= spriteTileBottom; y++) {
        for (uint8_t x = spriteTileLeft; x <= spriteTileRight; x++) {
            // Check collision with sprite
        }
    }
}