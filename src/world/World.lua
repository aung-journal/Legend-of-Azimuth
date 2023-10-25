World = Class{}

function World:init(player, width, height, camX, camY)
    --file loading and saving number
    self.worldName = 1

    self.camX = camX
    self.camY = camY

    self.camWidth = VIRTUAL_WIDTH
    self.camHeight = VIRTUAL_HEIGHT

    self.width = width
    self.height = height

    self.BiomeID = DESERT_BIOME_IDS -- Assuming PLAIN_BIOME_IDS is defined elsewhere
    self.Biome = LOCATION_DEFS.biome[1] -- Assuming LOCATION_DEFS is defined elsewhere

    self.Place = LOCATION_DEFS.places[1] -- Assuming LOCATION_DEFS is defined elsewhere

    self.tileset = self.BiomeID[math.random(1, #self.BiomeID)]

    self.tileID = WORLD_TILE_ID_GROUND
    
    self.topperset = DESERT_TOPPER_BIOME_IDS[math.random(#DESERT_TOPPER_BIOME_IDS)]

    self.tiles = {}
    self:generateTiles(width, height)
    --saveArrayToProjectDirectory(self.tiles, 'tiles.lst')

    print(love.filesystem.getSourceBaseDirectory())
    
    self.entities = {}
    self:generateEntities()

    self.objects = {}
    self:generateObjects()

    --any items that has been dropped
    self.items = {}

    self.player = player

    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0

    self:save()
    self:load()
end

local function calculateRegionNumber(x, y, regionWidth, regionHeight)
    -- Calculate the region number based on x and y coordinates
    local regionX = math.floor(x / regionWidth) + 1
    local regionY = math.floor(y / regionHeight) + 1

    -- Calculate the overall region number
    local regionNumber = (regionY - 1) * 3 + regionX

    return regionNumber
end

function World:generateEntities()
    local amount = math.random(self.width, math.floor((self.width * self.height) / TILE_SIZE))

    local regionWidth = (self.width * TILE_SIZE) / 3
    local regionHeight = (self.height * TILE_SIZE) / 2

    for i = 1, amount do
        local x = math.random(self.width * TILE_SIZE)
        local y = math.random(self.height * TILE_SIZE)

        local regionNumber = calculateRegionNumber(x, y, regionWidth, regionHeight)
        local typesInRegion = gEntityIDS[regionNumber]

        if typesInRegion and #typesInRegion > 0 then
            local randomTypeIndex = math.random(#typesInRegion)
            local type = typesInRegion[randomTypeIndex]

            local lev = ENTITY_DEFS[type].levels
            local nlev = lev[math.random(#lev)]

            local entity = Entity {
                animations = ENTITY_DEFS[type].animations,
                walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,
                x = x,
                y = y,
                width = 16,
                height = 16,
                level = nlev
                --health = level
            }

            entity.stateMachine = StateMachine {
                ['walk'] = function() return EntityWalkState(entity, gStateMachine.current.place) end,
                ['idle'] = function() return EntityIdleState(entity, gStateMachine.current.place) end
            }

            entity:changeState('walk')

            table.insert(self.entities, entity)
        end
    end
end

-- function World:generateTiles(width, height)
--     local regionWidth = width / 3
--     local regionHeight = height / 2

--     local bufferTileset = {}

--     local camX = math.floor(self.camX / TILE_SIZE + 1)
--     local camY = math.floor(self.camY / TILE_SIZE + 1)
    
--     local camWidth = math.floor(self.camWidth / TILE_SIZE)
--     local camHeight = math.floor(self.camHeight / TILE_SIZE)

--     -- Clear any existing tiles
--     self.tiles = {}

--     for x = camX, camX + camWidth do
--         self.tiles[x] = {}
--     end

--     for x = camX, camX + camWidth do
--         for y = camY, camY + camHeight + 1 do
--             if math.random(math.floor((width * height) / 3)) == 1 then
--                 self.tileID = WORLD_TILE_ID_EMPTY
--             else
--                 self.tileID = WORLD_TILE_ID_GROUND
--             end

--             -- Determine the region for the tile
--             local regionX = math.floor((x - 1) / regionWidth) + 1
--             local regionY = math.floor((y - 1) / regionHeight) + 1

--             -- Calculate the region number
--             local regionNumber = (regionY - 1) * 3 + regionX

--             self.BiomeID = BIOMES[regionNumber]
--             self.Biome = LOCATION_DEFS.biome[regionNumber]

--             -- Check if we haven't selected a tileset for this region yet
--             if not bufferTileset[regionNumber] then
--                 bufferTileset[regionNumber] = self.BiomeID[math.random(1, #self.BiomeID)]
--             end

--             self.tileset = bufferTileset[regionNumber]

--             self.topper = math.random(math.floor((width * height) / 100)) == 1 and true or false

--             self.tiles[x][y] = Tile(x, y, self.tileID, self.tileset, self.topper, self.topperset, self.BiomeID, regionNumber, self.Biome)
--         end
--     end
-- end


function World:generateTiles(width, height)
    local regionWidth = width / 3
    local regionHeight = height / 2

    local bufferTileset = {}

    

    for x = 1, width do
        self.tiles[x] = {}
    end
    
    for x = 1, width do
        for y = 1, height do
            if math.random(math.floor((width * height) / 3)) == 1 then
                self.tileID = WORLD_TILE_ID_EMPTY
            else
                self.tileID = WORLD_TILE_ID_GROUND
            end

            -- Determine the region for the tile
            local regionX = math.floor((x - 1) / regionWidth) + 1
            local regionY = math.floor((y - 1) / regionHeight) + 1

            -- Calculate the region number
            local regionNumber = (regionY - 1) * 3 + regionX

            self.BiomeID = BIOMES[regionNumber]

            self.Biome = LOCATION_DEFS.biome[regionNumber]

            -- Check if we haven't selected a tileset for this region yet
            if not bufferTileset[regionNumber] then
                bufferTileset[regionNumber] = self.BiomeID[math.random(1, #self.BiomeID)]
            end

            self.tileset = bufferTileset[regionNumber]

            self.topper = math.random(math.floor((width * height) / 100)) == 1 and true or false

            self.tiles[x][y] = Tile(x, y, self.tileID, self.tileset, self.topper, self.topperset, self.BiomeID, regionNumber, self.Biome)
        end
    end
end

-- function World:generateObjects()
--     -- local switch = GameObject(
--     --     GAME_OBJECT_DEFS['switch'],
--     --     math.random(self.width * TILE_SIZE),
--     --     math.random(self.height * TILE_SIZE)
--     -- )

--     -- -- define a function for the switch that will open all doors in the room
--     -- switch.onCollide = function()
--     --     switch.state = switch.state == 'unpressed' and 'pressed' or 'unpressed'
--     --     gSounds['door']:play()
--     -- end

--     -- -- add to list of objects in scene (only one switch for now)
--     -- table.insert(self.objects, switch)

--     --for other unspecialized unconsumable objects

--     local amount = math.random(math.floor( self.width / 3), math.floor( (self.width * self.height) / ( TILE_SIZE * 3) ) ) 

--     local types = {'mushrooms', 'bushes'}

--     local regionWidth = self.width * TILE_SIZE / 3
--     local regionHeight = self.height * TILE_SIZE / 2

--     for i = 1, amount do
--         local type = types[math.random(#types)]

--         local x = math.random(self.width * TILE_SIZE)
--         local y = math.random(self.height * TILE_SIZE)

--         local regionNumber = calculateRegionNumber(x, y, regionWidth, regionHeight)

--         local objectID = gObjectIDS[type][regionNumber]

--         local object = GameObject(
--             GAME_OBJECT_DEFS[type],
--             x,
--             y
--         )
--         --after entity and object categorization with biomes add a cave which will get us to the dungeon and depending on
--         --the type there will be different renderings

--         --this is for only one state objects and to make variety and the bug is the frame is fixed to the 
--         --type not to the object
--         if object.frames then
--             object.frame = object.frames[math.random(#object.frames)]
--             object.states[object.defaultState].frame = object.frames[math.random(#object.frames)]
--         end

--         table.insert(self.objects, object)
--     end
-- end

function World:generateObjects()
    for i = 1, 10 do
        local door = GameObject(
            GAME_OBJECT_DEFS['door'], i * 2, 0
            -- math.random( math.floor(self.width), self.width * TILE_SIZE ), 0
        )
        --

        door.onCollide = function()
            if self.player:collides(door) and self.player.direction == 'up' and door.state == 'opened' then
                -- Timer.tween(0.5, {
                --     [gStateMachine.current] = {transistionAlpha = 0}
                -- }):finish(function()
                --         self.player.x = VIRTUAL_WIDTH / 2 - 8
                --         self.player.y = VIRTUAL_HEIGHT / 2 - 11
                --         gStateMachine.current.location = LOCATION_DEFS.places[2]
                --         gStateMachine.current.place = Dungeon(self.player)
                -- end)
                self.player.x = VIRTUAL_WIDTH / 2 - 8
                self.player.y = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - (2 * TILE_SIZE)
                gStateMachine.current.location = LOCATION_DEFS.places[2]
                gStateMachine.current.place = Dungeon(self.player)
            end
        end

        table.insert(self.objects, door)
    end

    local switch = GameObject(
        GAME_OBJECT_DEFS['switch'], TILE_SIZE, TILE_SIZE
        -- math.random(self.width * TILE_SIZE),
        -- math.random(self.height * TILE_SIZE)
    )

    -- define a function for the switch that will open all doors in the room
    switch.onCollide = function()
        if switch.state == 'unpressed' then
            switch.state = 'pressed'
            
            for k, object in pairs(self.objects) do
                if object.type == 'door' then
                    object.state = 'opened'
                end
            end

            gSounds['door']:play()
        end
    end

    -- add to list of objects in scene (only one switch for now)
    table.insert(self.objects, switch)


    local amount = math.random(math.floor(self.width / 3), math.floor((self.width * self.height) / (TILE_SIZE * 3)))
    local types = {'mushrooms', 'bushes'}

    local regionWidth = (self.width * TILE_SIZE) / 3
    local regionHeight = (self.height * TILE_SIZE) / 2

    for i = 1, amount do
        local type = types[math.random(#types)]
        local x = math.random(self.width * TILE_SIZE)
        local y = math.random(self.height * TILE_SIZE)

        local regionNumber = calculateRegionNumber(x, y, regionWidth, regionHeight)

        local objectID = gObjectIDS[type][regionNumber]

        if objectID and #objectID > 0 then
            -- Randomly select an object ID from the available options
            local randomObjectID = objectID[math.random(#objectID)]

            local object = GameObject(
                GAME_OBJECT_DEFS[type],
                x,
                y,
                randomObjectID
            )

            -- Set the frame based on the objectID
            object.frame = randomObjectID
            object.states[object.defaultState].frame = randomObjectID

            table.insert(self.objects, object)
        end
    end
end

function World:update(dt)
    local regionWidth = (self.width * TILE_SIZE) / 3
    local regionHeight = (self.height * TILE_SIZE) / 2

    if self.adjacentOffsetX ~= 0 or self.adjacentOffsetY ~= 0 then return end

    self.player:update(dt)

    self:updateCamera()

        
    -- don't update anything if we are sliding to another room (we have offsets)
    if self.adjacentOffsetX ~= 0 or self.adjacentOffsetY ~= 0 then return end

    self.player:update(dt)

    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]

        local regionNumber = calculateRegionNumber(entity.bufferX, entity.bufferY, regionWidth, regionHeight)

        if entity.x + entity.width >= self.camX and entity.x <= self.camX + self.camWidth
            and entity.y + entity.height >= self.camY and entity.y <= self.camY + self.camHeight then
            -- remove entity from the table if health is <= 0
            if entity.health <= 1 then
                entity.dead = true

                for k, item_def in pairs(ITEM_DEFS) do
                    -- Generate a random number between 1 and the drop rate
                    local randomNum = math.random(item_def.dropRate)
                    
                    -- If the random number is 1, drop the item and exit the loop
                    if randomNum == 1 then
                        local item = Item (
                            item_def,
                            entity.x,
                            entity.y,
                            self.player
                        )
                        item.x = entity.x
                        item.y = entity.y
                        item.width = item_def.width
                        item.height = item_def.height
                        item.type = item_def.type
                        item.texture = item_def.texture
                        item.specialType = item_def.specialType
                        table.insert(self.items, item)
                        
                        -- Exit the loop
                        break
                    end
                end
                
                table.remove(self.entities, i)
                
                --table.remove(self.entities, k)
            elseif not entity.dead then
                entity:processAI({room = self}, dt)
                entity:update(dt)
            end

            -- collision between the player and entities in the room
            if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
                gSounds['hit-player']:play()
                self.player:damage(1)
                self.player:goInvulnerable(1.5)

                -- if self.player.health == 0 then
                --     gStateMachine:change('game-over')
                -- end
            end
        end
    end

    for k, object in pairs(self.objects) do
        if object.x + object.width >= self.camX and object.x <= self.camX + self.camWidth
           and object.y + object.height >= self.camY and object.y <= self.camY + self.camHeight then
            object:update(dt)
    
            -- trigger collision callback on object
            if self.player:collides(object) then
                object:onCollide()
            end
        end
        -- object:update(dt)
    
        -- -- trigger collision callback on object
        -- if self.player:collides(object) then
        --     object:onCollide()
        -- end
    end

    local itemsToRemove = {} -- Create a table to store items to be removed

    for k, item in pairs(self.items) do
        if self.player:collides(item) then
            table.insert(self.player.inventory, item) -- Add the item to the player's inventory
            gSounds['pick-up']:play()
            table.insert(itemsToRemove, k) -- Store the index of items to remove
            print_r(self.player.inventory)
        end
    end
    
    -- Remove items from the self.items table
    for i = #itemsToRemove, 1, -1 do
        table.remove(self.items, itemsToRemove[i])
    end    
end

function World:render()
    local camX = math.floor(self.camX)
    local camY = math.floor(self.camY)
    love.graphics.translate(-camX, -camY)
    
    local ax = math.floor(camX / TILE_SIZE + 1)
    local ay = math.floor(camY / TILE_SIZE + 1)
    
    local bx = math.floor(self.camWidth / TILE_SIZE)
    local by = math.floor(self.camHeight / TILE_SIZE)
    
    for x = ax, ax + bx do
        for y = ay, ay + by + 1 do
            if self.tiles[x] and self.tiles[x][y] then
                self.tiles[x][y]:render()
            end
        end
    end

    for k, item in pairs(self.items) do
        -- print("Item attributes:")
        -- print(item.type, item.texture, item.frame) -- Add all relevant attributes
        item:render()
    end
    
    
    -- debug code
    -- for y = 1, self.width do
    --     for x = 1, self.height do
    --         local tile = self.tiles[y][x]
    --         tile:render()
    --     end
    -- end

    for k, object in pairs(self.objects) do
        if object.x + object.width >= self.camX and object.x <= self.camX + self.camWidth
           and object.y + object.height >= self.camY and object.y <= self.camY + self.camHeight then
            object:render(self.adjacentOffsetX, self.adjacentOffsetY)
        end
        --object:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end

    for k, entity in pairs(self.entities) do
        if entity.x + entity.width >= self.camX and entity.x <= self.camX + self.camWidth
           and entity.y + entity.height >= self.camY and entity.y <= self.camY + self.camHeight then
            if not entity.dead then entity:render(self.adjacentOffsetX, self.adjacentOffsetY) end
        end
        --if not entity.dead then entity:render(self.adjacentOffsetX, self.adjacentOffsetY) end
    end

    if self.player then
        self.player:render()
    end
end

--extra functions for the World class

function World:updateCamera()
    local targetX = self.player.x - VIRTUAL_WIDTH/2
    local targetY = self.player.y - VIRTUAL_HEIGHT/2

    self.camX = math.max(0, math.min(TILE_SIZE * self.width - VIRTUAL_WIDTH, targetX))
    self.camY = math.max(0, math.min(TILE_SIZE * self.height - VIRTUAL_HEIGHT, targetY))
end

-- Define a callback function for handling exceptions
local function handleException(value)
    -- You can customize how to handle the exception value here
    -- For example, you can convert it to a string or handle it in a specific way
    return filterFunctions(value)
end

function World:save()
    -- Create a copy of the items, entities, objects, tiles tables without functions
    local saveData = {
        items = self.items,
        entities = self.entities,
        objects = self.objects,
        tiles = self.tiles,
        player = self.player
    }

    local jsonString = json.encode(saveData, {exception = handleException})

    -- You can use a unique file name for each world if you have multiple worlds
    local saveFileName = "world_save_" .. self.worldName .. ".json"

    local success, message = love.filesystem.write(saveFileName, jsonString)

    if success then
        print("World saved to " .. saveFileName)
    else
        print("Error saving world data: " .. message)
    end
end

function World:load()
    local loadFileName = "world_save_" .. self.worldName .. ".json"

    local jsonString, size = love.filesystem.read(loadFileName)

    if jsonString then
        local saveData, pos, err = json.decode(jsonString)

        if not err then
            -- Populate the world object with loaded data
            self.items = saveData.items
            self.entities = saveData.entities
            self.objects = saveData.objects
            self.tiles = saveData.tiles
            self.player = saveData.player

            print("World loaded from " .. loadFileName)
        else
            print("Error decoding saved world data: " .. err)
        end
    else
        print("Could not load saved world data from " .. loadFileName)
    end
end

-- Helper function to filter out functions from a table
function filterFunctions(table)
    local filteredTable = {}
    for key, value in pairs(table) do
        if type(value) ~= "function" then
            filteredTable[key] = value
        end
    end
    return filteredTable
end
