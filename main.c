#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
extern unsigned char smiler[]; // VS looses connection to the h file sometimes
extern unsigned char apple[];  // VS looses connection to the h file sometimes
#include "smiler.h"
#include "apple.h"

void main(void)
{
    // Character
    int characterX = 20;
    int characterY = 20;
    uint8_t characterSpriteIndex = 0;
    set_sprite_data(0, 2, smiler);
    set_sprite_tile(0, characterSpriteIndex);
    move_sprite(0, characterX, characterY);

    // Apple
    int appleX = 100;
    int appleY = 100;
    set_sprite_data(2, 2, apple);
    set_sprite_tile(2, 2);
    move_sprite(2, appleX, appleY);

    SHOW_SPRITES;

    while (1)
    {
        switch (joypad())
        {
        case J_LEFT:
            characterX -= 10;
            move_sprite(0, characterX, characterY);
            delay(200);
            break;
        case J_RIGHT:
            characterX += 10;
            move_sprite(0, characterX, characterY);
            delay(200);
            break;
        case J_UP:
            characterY -= 10;
            move_sprite(0, characterX, characterY);
            delay(200);
            break;
        case J_DOWN:
            characterY += 10;
            move_sprite(0, characterX, characterY);
            delay(200);
            break;
        }
        if (characterX == appleX && characterY == appleY)
        {
            characterSpriteIndex = 1;
            set_sprite_tile(0, characterSpriteIndex);
            set_sprite_tile(2, 3); // hide apple
            printf("You won!");
            break;
        }
    }
}
