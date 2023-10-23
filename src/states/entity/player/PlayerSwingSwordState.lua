--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerSwingSwordState = Class{__includes = BaseState}

function PlayerSwingSwordState:init(player, place)
    self.player = player
    self.place = place

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 8

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y + self.player.height
    end

    -- separate hitbox for the player's sword; will only be active during this state
    self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)

    -- sword-left, sword-up, etc
    self.player:changeAnimation('sword-' .. self.player.direction)

    -- Add a timer for tracking time elapsed during the swing
    self.swingTimer = 0
    self.swingDuration = 1  -- Set the duration of one swing (in seconds)
end

function PlayerSwingSwordState:enter(params)

    -- restart sword swing sound for rapid swinging
    gSounds['sword']:stop()
    gSounds['sword']:play()

    -- restart sword swing animation
    self.player.currentAnimation:refresh()
end


function PlayerSwingSwordState:update(dt)
    -- Add a flag to track whether the sword has hit an entity during the current swing.
    local swordHitEntity = false

    -- Increment the swing timer
    self.swingTimer = self.swingTimer + dt

    -- Check if hitbox collides with any entities in the scene
    if gStateMachine.current.location == LOCATION_DEFS.places[1] then
        for k, entity in pairs(self.place.entities) do
            if entity:collides(self.swordHitbox) then
                if not swordHitEntity and self.swingTimer < self.swingDuration then
                    --note that because of ten collisions I did 0.1 for 1
                    entity:damage(0.1)
                    gSounds['hit-enemy']:play()
                    swordHitEntity = true  -- Set the flag to true to indicate that a hit occurred.
                end
            end
        end
    else
        for k, entity in pairs(self.place.currentRoom.entities) do
            if entity:collides(self.swordHitbox) then
                if not swordHitEntity and self.swingTimer < self.swingDuration then
                    entity:damage(1)
                    gSounds['hit-enemy']:play()
                    swordHitEntity = true  -- Set the flag to true to indicate that a hit occurred.
                end
            end
        end
    end

    -- If we've fully elapsed through one cycle of animation, change back to idle state.
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end

    -- Allow us to change into this state afresh if we swing within it, rapid swinging.
    if love.keyboard.wasPressed('space') then
        self.player:changeState('swing-sword')
    end
end

function PlayerSwingSwordState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end
