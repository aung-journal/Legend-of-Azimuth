World = Class{}

function World:init(player)
    self.player = player

    self.BiomeID = PLAIN_BIOME_IDS -- Assuming PLAIN_BIOME_IDS is defined elsewhere
    self.Biome = LOCATION_DEFS.biome[6] -- Assuming LOCATION_DEFS is defined elsewhere

    self.Place = LOCATION_DEFS.places[1] -- Assuming LOCATION_DEFS is defined elsewhere

    self.tileset = self.BiomeID[math.random(1, #self.BiomeID)]

    self.tileID = WORLD_TILE_ID_GROUND
    
    self.topperset = PLAIN_TOPPER_BIOME_IDS[math.random(#PLAIN_TOPPER_BIOME_IDS)]

    self.level = WorldMaker:generate(25, 25, self.BiomeID, self.Biome, self.Place, self.tileset, self.tileID, self.topperset)
    self.tileMap = self.level.tileMap
end

function World:update(dt)
    self.level:clear()

    self.level:update(dt)
    self.player:update(dt)

    for i = #self.level.entities, 1, -1 do
        local entity = self.level.entities[i]

        -- remove entity from the table if health is <= 0
        if entity.health <= 0 then
            entity.dead = true
        elseif not entity.dead then
            entity:processAI({},dt)
            entity:update(dt)
        end

        -- collision between the player and entities in the room
        if not entity.dead and self.player:collides(entity) and not self.invulnerable then
            gSounds['hit-player']:play()
            self.player:damage(1)
            self.player:goInvulnerable(1.5)

            if self.player.health == 0 then
                gStateMachine:change('game-over')
            end
        end
    end

    --constrain player x and y outside
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > TILE_SIZE * self.tileMap.width - self.player.width then
        self.player.x = TILE_SIZE * self.tileMap.width - self.player.width
    elseif self.player.y <= 0 then
        self.player.y = 0
    elseif self.player.y > TILE_SIZE * self.tileMap.height - self.player.height then
        self.player.y = TILE_SIZE * self.tileMap.height - self.player.height
    end
end

function World:render()
    self.level:render()
    self.player:render()
end

