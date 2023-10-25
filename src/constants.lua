VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TILE_SIZE = 16

--
-- entity constants
--
PLAYER_WALK_SPEED = 60

--
-- map constants
--
MAP_WIDTH = math.floor(VIRTUAL_WIDTH / TILE_SIZE - 2)
MAP_HEIGHT = math.floor(VIRTUAL_HEIGHT / TILE_SIZE) - 2

MAP_RENDER_OFFSET_X = (VIRTUAL_WIDTH - (MAP_WIDTH * TILE_SIZE)) / 2
MAP_RENDER_OFFSET_Y = (VIRTUAL_HEIGHT - (MAP_HEIGHT * TILE_SIZE)) / 2

WORLD_MAP_WIDTH = 100
WORLD_MAP_HEIGHT = 100

TEST_MAP_WIDTH = 50
TEST_MAP_HEIGHT = 50

--
-- tile IDs
--
TILE_TOP_LEFT_CORNER = 4
TILE_TOP_RIGHT_CORNER = 5
TILE_BOTTOM_LEFT_CORNER = 23
TILE_BOTTOM_RIGHT_CORNER = 24

TILE_EMPTY = 19

TILE_FLOORS = {
    7, 8, 9, 10, 11, 12, 13,
    26, 27, 28, 29, 30, 31, 32,
    45, 46, 47, 48, 49, 50, 51,
    64, 65, 66, 67, 68, 69, 70,
    88, 89, 107, 108
}

TILE_TOP_WALLS = {58, 59, 60}
TILE_BOTTOM_WALLS = {79, 80, 81}
TILE_LEFT_WALLS = {77, 96, 115}
TILE_RIGHT_WALLS = {78, 97, 116}

TILE_CAVES = {208, 207}

--world
--number of tiles in each tile set
WORLD_TILE_SET_WIDTH = 5
WORLD_TILE_SET_HEIGHT = 4

--number of tile sets in sheet
WORLD_TILE_SET_WIDE = 6
WORLD_TILE_SET_TALL = 10

--total number of world tile sets
WORLD_TILE_SETS = WORLD_TILE_SET_WIDE * WORLD_TILE_SET_TALL

-- number of WORLD_TOPPER sets in sheet
WORLD_TOPPER_SETS_WIDE = 6
WORLD_TOPPER_SETS_TALL = 18

-- total number of WORLD_TOPPER and tile sets
WORLD_TOPPER_SETS = WORLD_TOPPER_SETS_WIDE * WORLD_TOPPER_SETS_TALL

WORLD_TILE_ID_EMPTY = 5
WORLD_TILE_ID_GROUND = 3

COLLIDABLE_TILES = {
    WORLD_TILE_ID_GROUND
}

--
--game object IDs
--
BUSH_IDS = {
    1, 2, 5, 6, 7
}
--not switch IDs because we will use the whole spritesheet
MUSHROOM_IDS = {
    1, 2, 3, 4, 5, 6, 7, 8, 11, 12, 13, 16, 17, 18, 21, 22, 23, 26, 27, 28, 31, 32, 33, 36, 37, 38, 41, 42, 43
}

--this is the actual name that I will call in my game
-- Enchanted Forest Biome(5)
-- Volcanic Caverns Biome(3)
-- Frozen Tundra Biome(2)
-- Astral Wastes Biome(1)
-- Deep Abyss Biome(4)
-- The Land of Isles Biome(6)

--WORLD TILE ID WITH BIOME
DESERT_BIOME_IDS = {1, 2, 7, 8, 13, 14, 19, 20, 25, 26}
COAST_BIOME_IDS = {3, 4, 9, 10, 15, 16, 21, 22, 27, 28}
VOLCANO_BIOME_IDS = {5, 6, 11, 12, 17, 18, 23, 24, 29, 30}
SHORE_BIOME_IDS = {32, 37, 38, 43, 44, 49, 50, 55, 56, 31}
FOREST_BIOME_IDS = {33, 34, 39, 40, 45, 46, 51, 52, 57, 58}
PLAIN_BIOME_IDS = {35, 36, 41, 42, 47, 48, 53, 54, 59, 60}

BIOMES = {
    DESERT_BIOME_IDS,
    COAST_BIOME_IDS,
    VOLCANO_BIOME_IDS,
    SHORE_BIOME_IDS,
    FOREST_BIOME_IDS,
    PLAIN_BIOME_IDS
}

--WORLD_TOPPER ID WITH BIOME and 3 variety in it

--DESERT_TOPPER_BIOME_IDS
DESERT_TOPPER_BIOME_IDS = {35, 36, 5, 6, 11, 12, 17, 18, 23, 24, 29, 30}--

--COAST_TOPPER_BIOME_IDS
COAST_TOPPER_BIOME_IDS = {32, 1, 2, 7, 8, 13, 14, 19, 20, 25, 26, 31}--
COAST_TOPPER_BIOME_IDS_ALT1 = {64, 69, 70, 39, 40, 45, 46, 51, 52, 57, 58, 63}--
COAST_TOPPER_BIOME_IDS_ALT2 = {77, 78, 83, 84, 89, 90, 95, 96, 101, 102, 107, 108}--

--VOLCANO_TOPPER_BIOME_IDS
VOLCANO_TOPPER_BIOME_IDS = {67, 68, 37, 38, 43, 44, 49, 50, 55, 56, 61, 62}--
VOLCANO_TOPPER_BIOME_IDS_ALT1 = {73, 74, 79, 80, 85, 86, 91, 92, 97, 98, 103, 104}--

--SHORE_TOPPER_BIOME_IDS
SHORE_TOPPER_BIOME_IDS = {75, 76, 81, 82, 87, 88, 93, 94, 99, 100, 105, 106}--

--FOREST_TOPPER_BIOME_IDS
FOREST_TOPPER_BIOME_IDS = {33, 34, 3, 4, 9, 10, 15, 16, 21, 22, 27, 28}--

--PLAIN_TOPPER_BIOME_IDS
PLAIN_TOPPER_BIOME_IDS = {65, 66, 71, 72, 41, 42, 47, 48, 53, 54, 59, 60}--