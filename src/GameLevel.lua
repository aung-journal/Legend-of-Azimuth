--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init(entities, objects, tilemap)
    self.entities = entities
    self.objects = objects
    self.tileMap = tilemap
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.entities[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        if entity.x <= 0 then
            entity.x = 0
            entity.bumped = true
        elseif entity.x > TILE_SIZE * self.tileMap.width - entity.width then
            entity.x = TILE_SIZE * self.tileMap.width - entity.width
            entity.bumped = true
        elseif entity.y <= 0 then
            entity.y = 0
            entity.bumped = true
        elseif entity.y > TILE_SIZE * self.tileMap.height - entity.height then
            entity.y = TILE_SIZE * self.tileMap.height - entity.height
            entity.bumped = true
        end

        entity:update(dt)
    end
end

function GameLevel:render()
    --only render the part you see, fix this so that dynamic memory allocation is possible
    self.tileMap:render()

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        if not entity.dead then entity:render() end
    end
end