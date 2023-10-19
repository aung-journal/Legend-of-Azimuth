--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['mushrooms'] = {
        type = 'mushroom',
        texture = 'mushrooms',
        frames = MUSHROOM_IDS,
        frame = MUSHROOM_IDS[1],
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'passed',
        states = {
            ['passed'] = {
                frame = MUSHROOM_IDS[1]
            }
        }
    },
    ['bushes'] = {
        type = 'bush',
        texture = 'bushes',
        frames = BUSH_IDS,
        frame = BUSH_IDS[1],
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'passed',
        states = {
            ['passed'] = {
                frame = BUSH_IDS[1]
            }
        }
    }
}