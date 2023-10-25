--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y, objectID)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1
    self.frames = def.frames

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

    self.objectID = objectID

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:update(dt)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    if not self.objectID then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
            self.x + adjacentOffsetX, self.y + adjacentOffsetY)
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.objectID],
            self.x + adjacentOffsetX, self.y + adjacentOffsetY)
    end
end

--these are the functions to actually decode and encode the string to a file possible
-- Inside the Object class definition
function GameObject:toTable()
    -- Create a table containing the essential properties of the object
    local objectTable = {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height,
        type = self.type,
        texture = self.texture,
        frame = self.frame,
        frames = self.frames,
        state = self.state,
        defaultState = self.defaultState,
        
        solid = self.solid,
        onCollide = nil  -- This can't be directly serialized as a function
    }

    return objectTable
end