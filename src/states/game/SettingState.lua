SettingState = Class{__includes = BaseState}

--make remove all sound effects stuff
function SettingState:init()
    self.volume = 100
end

function SettingState:update(dt)
    if love.keyboard.wasPressed('u') then
        if Sound_effect then
            Sound_effect = false
        else
            Sound_effect = true
        end
    end

    if love.keyboard.wasPressed('t') then
        if MUSIC then
            MUSIC = false
        else
            MUSIC = true
        end
    end

    if love.keyboard.wasPressed('right') then
        if self.volume + 10 <= 100 then
            if not MUSIC and self.volume == 0 then
                MUSIC = true
            end
            increaseVolume()
            self.volume = self.volume + 10
        end
    elseif love.keyboard.wasPressed('left') then
        if self.volume - 10 > 0 then
            decreaseVolume()
            self.volume = self.volume - 10
        else
            MUSIC = false
            self.volume = 0
        end
    end
end

function SettingState:render()
    --background
    love.graphics.draw(gTextures['background'], 0, 0)
    
    -- keep the background and tiles a little darker than normal
    love.graphics.setColor(1/255, 1/255, 1/255, 128/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
    --background
    love.graphics.setFont(gFonts['large'])
    text = "Music"
    local textWidth = love.graphics.getFont():getWidth(text)
    love.graphics.printf(text, VIRTUAL_WIDTH / 2 - 32 - textWidth, VIRTUAL_HEIGHT / 5, textWidth, 'center')

    -- Define the coordinates for drawing the tick for background MUSIC
    local x1, y1 = VIRTUAL_WIDTH / 2 + 8, VIRTUAL_HEIGHT / 6
    local x2, y2 = VIRTUAL_WIDTH / 2 + 38, VIRTUAL_HEIGHT / 6 + 30
    local x3, y3 = VIRTUAL_WIDTH / 2 + 88, VIRTUAL_HEIGHT / 6 - 30

    if MUSIC then
        drawTick(x1, y1, x2, y2, x3, y3)
    end

    text = "Volume"
    local textWidth = love.graphics.getFont():getWidth(text)
    love.graphics.printf(text, VIRTUAL_WIDTH / 2 - 16 - textWidth, VIRTUAL_HEIGHT / 2 - 8, textWidth, 'center')

    love.graphics.print(tostring(self.volume), VIRTUAL_WIDTH / 2 + 8, VIRTUAL_HEIGHT / 2 - 8)

    text = "Sound Effects"
    local textWidth = love.graphics.getFont():getWidth(text)
    love.graphics.printf(text, VIRTUAL_WIDTH / 2 - 12 - textWidth, VIRTUAL_HEIGHT - 72, textWidth, 'center')

    -- Define the coordinates for drawing the tick for the sound effects
    x1, y1 = VIRTUAL_WIDTH / 2 + 38, VIRTUAL_HEIGHT - 72
    x2, y2 = VIRTUAL_WIDTH / 2 + 68, VIRTUAL_HEIGHT - 42
    x3, y3 = VIRTUAL_WIDTH / 2 + 118, VIRTUAL_HEIGHT - 102

    if Sound_effect then
        drawTick(x1, y1, x2, y2, x3, y3)
    end
end

--This is for gSounds['music'] volume changing
function increaseVolume()
    local currentVolume = gSounds['music']:getVolume()
    local newVolume = math.min(currentVolume + 0.1, 1.0) -- Increase volume by 10%
    gSounds['music']:setVolume(newVolume)
end

function decreaseVolume()
    local currentVolume = gSounds['music']:getVolume()
    local newVolume = math.max(currentVolume - 0.1, 0.0) -- Decrease volume by 10%
    gSounds['music']:setVolume(newVolume)
end

function drawTick(x1, y1, x2, y2, x3, y3)
    -- Set the line width and color for the tick
    love.graphics.setLineWidth(5)

    -- Draw the tick using lines
    love.graphics.line(x1, y1, x2, y2)
    love.graphics.line(x2, y2, x3, y3)

    -- Reset the line width
    love.graphics.setLineWidth(1)
end