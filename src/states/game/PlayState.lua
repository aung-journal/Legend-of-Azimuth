--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camX = 0
    self.camY = 0

    self.transistionAlpha = 1

    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        
        width = 16,
        height = 22,

        -- one heart == 2 health
        health = 6,

        -- rendering and collision offset for spaced sprites
        offsetY = 5
    }

    self.currentRoom = Room(self.player)
    self.place = World(self.player, WORLD_MAP_WIDTH, WORLD_MAP_HEIGHT)
    self.location = LOCATION_DEFS.places[1]
    
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.place) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.place) end
    }
    self.player:changeState('idle')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.place:update(dt)
    if not self.place.currentRoom then
        self:updateCamera()
    end
end

function PlayState:render()
    -- render place and all entities separate from hearts GUI
    love.graphics.push()
    love.graphics.setColor(1,1,1,self.transistionAlpha)
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.place:render()
    love.graphics.pop()

    -- draw player hearts, top of screen
    local healthLeft = self.player.health
    local heartFrame = 1

    for i = 1, 3 do
        if healthLeft > 1 then
            heartFrame = 5
        elseif healthLeft == 1 then
            heartFrame = 3
        else
            heartFrame = 1
        end

        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][heartFrame],
            (i - 1) * (TILE_SIZE + 1), 2)
        
        healthLeft = healthLeft - 2
    end
end

function PlayState:updateCamera()
    local targetX = self.player.x - VIRTUAL_WIDTH/2
    local targetY = self.player.y - VIRTUAL_HEIGHT/2

    self.camX = math.max(0, math.min(TILE_SIZE * self.place.width - VIRTUAL_WIDTH, targetX))
    self.camY = math.max(0, math.min(TILE_SIZE * self.place.height - VIRTUAL_HEIGHT, targetY))
end