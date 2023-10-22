--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, place)
    self.entity = entity
    self.entity:changeAnimation('walk-down')

    self.place = place

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
end

function EntityWalkState:update(dt)
    
    -- assume we didn't hit a wall
    self.bumped = false

    -- boundary checking on all sides, allowing us to avoid collision detection on tiles
    if gStateMachine.current.location == LOCATION_DEFS.places[1] then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - self.entity.walkSpeed * dt
            
            if self.entity.x <= 0 then 
                self.entity.x = 0
                self.bumped = true
            end
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + self.entity.walkSpeed * dt

            if self.entity.x + self.entity.width >= WORLD_MAP_WIDTH * TILE_SIZE then
                self.entity.x = WORLD_MAP_WIDTH * TILE_SIZE - self.entity.width
                self.bumped = true
            end
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - self.entity.walkSpeed * dt

            if self.entity.y <= 0 then 
                self.entity.y = 0
                self.bumped = true
            end
        elseif self.entity.direction == 'down' then
            self.entity.y = self.entity.y + self.entity.walkSpeed * dt

            if self.entity.y + self.entity.height >= WORLD_MAP_HEIGHT * TILE_SIZE then
                self.entity.y = WORLD_MAP_HEIGHT * TILE_SIZE - self.entity.height
                self.bumped = true
            end
        end
    else
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - self.entity.walkSpeed * dt
            
            if self.entity.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
                self.entity.x = MAP_RENDER_OFFSET_X + TILE_SIZE
                self.bumped = true
            end
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    
            if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
                self.entity.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.entity.width
                self.bumped = true
            end
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    
            if self.entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 then 
                self.entity.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2
                self.bumped = true
            end
        elseif self.entity.direction == 'down' then
            self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    
            local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
                + MAP_RENDER_OFFSET_Y - TILE_SIZE
    
            if self.entity.y + self.entity.height >= bottomEdge then
                self.entity.y = bottomEdge - self.entity.height
                self.bumped = true
            end
        end
    end
end

function EntityWalkState:processAI(params, dt)
    local room = params.room
    local directions = {'left', 'right', 'up', 'down'}

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(3) == 1 then
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        end
    end

    self.movementTimer = self.movementTimer + dt
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0, self.entity.xScale, self.entity.yScale)
    
    -- debug code
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end