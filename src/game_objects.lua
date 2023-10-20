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
    },
    ['door'] = {
        type = 'door',
        texture = 'tiles',
        frame = TILE_CAVES[1],
        width = 32,
        height = 16,
        solid = false,
        defaultState = 'closed',
        states = {
            ['closed'] = {
                frame = TILE_CAVES[1]
            },
            ['opened'] = {
                frame = TILE_CAVES[2]
            }
        }
    }
}