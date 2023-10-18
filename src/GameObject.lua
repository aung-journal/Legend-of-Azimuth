--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.variety = def.variety or true


    --probability of spawning this(the more worse and 0 means impossible)
    self.probability = def.probability or 0

    --location
    self.biome = def.biome or 'Every'
    self.place = def.place or 'Every'

    --default empty collision callback
    self.onCollide = function() end

    --consumption
    self.consumable = false
    self.onConsume = function() end
end

function GameObject:update(dt)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    -- if not self.variety then
    --     --[self.states[self.state].frame or self.frame],
    --     love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
    --         self.x + adjacentOffsetX or 0, self.y + adjacentOffsetY)
    -- else
    --     --[self.states[self.state].frame or self.frame[#self.frame]],
    --     love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame[math.random(#self.frame)]],
    --     self.x + adjacentOffsetX or 0, self.y + adjacentOffsetY)
    -- end
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
        self.x + adjacentOffsetX or 0, self.y + adjacentOffsetY)
end