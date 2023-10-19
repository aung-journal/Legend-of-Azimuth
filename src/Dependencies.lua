--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'
require 'src/entity_defs'
require 'src/GameObject'
require 'src/game_objects'
require 'src/Hitbox'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'
--this is for tiles
require 'src/Tile'
-- require 'src/TileMap'
-- require 'src/GameLevel'

require 'src/world/Doorway'
require 'src/world/Dungeon'
require 'src/world/Room'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerSwingSwordState'
require 'src/states/entity/player/PlayerWalkState'

require 'src/states/game/BeginGameState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
-- require 'src/states/game/InstructionState'
require 'src/states/game/GameOverState'

require 'src/world/location_defs'
-- require 'src/world/WorldMaker'
require 'src/world/World'

gTextures = {
    ['logo'] = love.graphics.newImage('graphics/logo.jpeg'),

    ['world_tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['toppers'] = love.graphics.newImage('graphics/tile_tops.png'),
    ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['character-swing-sword'] = love.graphics.newImage('graphics/character_swing_sword.png'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['mushrooms'] = love.graphics.newImage('graphics/mushrooms.png'),
    ['switches'] = love.graphics.newImage('graphics/switches.png'),
    ['bushes'] = love.graphics.newImage('graphics/bushes_and_cacti.png')
}



gFrames = {
    ['world_tiles'] = GenerateQuads(gTextures['world_tiles'], TILE_SIZE, TILE_SIZE),
    ['toppers'] = GenerateQuads(gTextures['toppers'], TILE_SIZE, TILE_SIZE),
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    ['character-swing-sword'] = GenerateQuads(gTextures['character-swing-sword'], 32, 32),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
    ['hearts'] = GenerateQuads(gTextures['hearts'], 16, 16),
    ['mushrooms'] = GenerateQuads(gTextures['mushrooms'], 16, 16),
    ['bushes'] = GenerateQuads(gTextures['bushes'], 16, 16),
    ['switches'] = GenerateQuads(gTextures['switches'], 16, 18)
}

--these needed to be added after gFrames is initialized because they refer to gFrames from within
gFrames['world_tilesets'] = GenerateTileSets(gFrames['world_tiles'],
    WORLD_TILE_SET_WIDE, WORLD_TILE_SET_TALL, WORLD_TILE_SET_WIDTH, WORLD_TILE_SET_HEIGHT)

gFrames['toppersets'] = GenerateTileSets(gFrames['toppers'], 
    WORLD_TOPPER_SETS_WIDE, WORLD_TOPPER_SETS_TALL, WORLD_TILE_SET_WIDTH, WORLD_TILE_SET_HEIGHT)

--game object biome IDs
gObjectIDS = {
    ['mushrooms'] = {
        {26, 27, 28},
        {31, 32, 33},
        {36, 37, 38},
        {41, 42, 43},
        {16, 17, 18},
        {21, 22, 23}
    },
    ['bushes'] = {
        range(8, 14),
        range(29, 35),
        range(15, 21),
        range(22, 28),
        range(1, 7),
        range(1, 7)
    },
    ['cave'] = {
        {
            top = {126, 127},
            bottom = {145, 146}
        }
    }
}

--entities biome ID
gEntityIDS = {
    {'skeleton'},
    {'slime'},
    {'bat'},
    {'ghost'},
    {'spider'},
    {'spider'}
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 6),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 12),
    ['instructions'] = love.graphics.newFont('fonts/font.ttf', 18), 
    ['large'] = love.graphics.newFont('fonts/font.ttf', 24),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    ['zelda'] = love.graphics.newFont('fonts/zelda.otf', 64),
    ['zelda-small'] = love.graphics.newFont('fonts/zelda.otf', 32)
}

gSounds = {
    ['selection'] = love.audio.newSource('sounds/selection.wav', 'static'),

    ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
    ['sword'] = love.audio.newSource('sounds/sword.wav', 'static'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav', 'static'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', 'static'),
    ['door'] = love.audio.newSource('sounds/door.wav', 'static')
}