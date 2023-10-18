WorldMaker = Class{}

function WorldMaker:generate(width, height, BiomeID, Biome, Place, tileset, tileID, topperset)
    local tiles = {}
    local entities = {}
    local objects = {}
    local topper = true

    -- Initialize the 'tiles' 2D array
    for x = 1, width do
        tiles[x] = {}
    end

    -- Row by row generation
    for x = 1, width do
        for y = 1, height do
            if math.random(math.floor((width * height) / 3)) == 1 then
                tileID = WORLD_TILE_ID_EMPTY -- Assuming WORLD_TILE_ID_EMPTY is defined
            else
                tileID = WORLD_TILE_ID_GROUND -- Assuming WORLD_TILE_ID_GROUND is defined
            end

            topper = math.random(math.floor((width * height) / 100)) == 1 and true or false

            tiles[x][y] = Tile(x, y, tileID, tileset, topper, topperset, BiomeID) -- Assuming Tile class is defined

            self:generateEntities(entities, width, height)
            self:generateObjects(objects, width , height)

        end
    end

    local map = TileMap(width, height) -- Assuming TileMap class is defined
    map.tiles = tiles

    return GameLevel(entities, objects, map) -- Assuming GameLevel class is defined
end

function WorldMaker:generateEntities(entities, width, height)
    local types = {}
    for k, _ in pairs(ENTITY_DEFS) do
        table.insert(types, k)
    end
    types['player'] = nil

    for i = 1, 10 do
        local type = types[math.random(#types)]

        table.insert(entities, Entity {
            animations = ENTITY_DEFS[type].animations,
            walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

            -- Ensure X and Y within bounds of the map
            x = math.random(TILE_SIZE, (width - 1) * TILE_SIZE),
            y = math.random(TILE_SIZE, (height - 1) * TILE_SIZE),
            
            width = 16,
            height = 16,

            health = 1
        })

        entities[i].stateMachine = StateMachine {
            ['walk'] = function() return EntityWalkState(entities[i]) end,
            ['idle'] = function() return EntityIdleState(entities[i]) end
        }

        entities[i]:changeState('walk')
    end
end

-- for k, entity in ipairs(ENTITY_DEFS) do
--     if (entity.place == Place and entity.biome == Biome) or (entity.place == 'Every' and entity.biome == 'Every') and ENTITY_DEFS[k] ~= 'player' then
--         if math.random(entity.probability) == 1 and not entity.dead then
--             table.insert(entities, entity)
--         end
--     end
-- end

function WorldMaker:generateObjects(objects, width, height)
    local types = {}
    for k, _ in pairs(GAME_OBJECT_DEFS) do
        table.insert(types, k)
    end

    for i = 1, 2 do
        local type = types[math.random(#types)]

        local objectDef = GAME_OBJECT_DEFS[type] -- Retrieve the object definition
        local x = math.random(TILE_SIZE, (width - 1) * TILE_SIZE)
        local y = math.random(TILE_SIZE, (height - 1) * TILE_SIZE)
        
        -- Create a new GameObject instance and insert it into the objects table
        local gameObj = GameObject(objectDef, x, y)
        table.insert(objects, gameObj)
    end
end
