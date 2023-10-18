require 'src/world/location_defs'

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = {2},
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = {2}
            },
            ['pressed'] = {
                frame = {1}
            }
        },
        place = LOCATION_DEFS.places[2]
    },
    ['mushrooms'] = {
        type = 'mushrooms',
        texture = 'mushrooms',
        frame = MUSHROOM_IDS,
        width = 16,
        height = 16,
        solid = false,
        place = LOCATION_DEFS.places[1],
        probability = 10,
        variety = true
    },
    ['bushes'] = {
        type = 'bushes',
        texture = 'bushes',
        frame = BUSH_IDS,
        width = 16,
        height = 16,
        solid = false,
        place = LOCATION_DEFS.places[1],
        probability = 10,
        variety = true
    }
}