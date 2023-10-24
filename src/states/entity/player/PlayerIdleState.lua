--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
    local keys = {'w', 'a', 's', 'd', 'left', 'right', 'up', 'down'}

    for k, key in pairs(keys) do
        if love.keyboard.isDown(key) then
            self.entity:changeState('walk')
        end
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('e') then
        self.entity:changeState('inventory')
    end
end