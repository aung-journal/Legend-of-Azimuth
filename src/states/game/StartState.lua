StartState = Class{__includes = BaseState}

--I have to add layer machine later to make 

local selected = false

function StartState:init()
    self.menu = {
        "Play", --this is Create a New World(I didn't change Play because there is state to go)
        "", -- I might later add this as there will be some new state to go
        "Instructions",
        "Settings",
        "Achievements",
        "Exit"
    }

    self.currentMenuItem = 1
    self.currentMenuKeyItem = 1
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('down') then
        self.currentMenuKeyItem = math.min(#self.menu, self.currentMenuKeyItem + 1)
        gSounds['selection']:play()
    elseif love.keyboard.wasPressed('up') then
        self.currentMenuKeyItem = math.max(1, self.currentMenuKeyItem - 1)
        gSounds['selection']:play()
    end

    for i, option in ipairs(self.menu) do
        local optionX = VIRTUAL_WIDTH / 2 - gFonts['instructions']:getWidth(option) / 2
        local optionY = 54 + (i - 1) * 28

        local mouseX, mouseY = push:toGame(love.mouse.getPosition())

        if mouseX and mouseY then
            if mouseX >= optionX and mouseX <= optionX + gFonts['instructions']:getWidth(option) and
            mouseY >= optionY and mouseY <= optionY + gFonts['instructions']:getHeight() then
                self.currentMenuItem = i
                break
            else
                self.currentMenuItem = 0
            end
        end
    end

    if love.mouse.isDown(1) then
        for i, option in ipairs(table.exclude(self.menu, #self.menu)) do
            if option ~= '' then
                if self.currentMenuItem == i then
                    gStateMachine:change(option:lower())
                    gSounds['selection']:play()
                end
            end
        end
        if self.currentMenuItem == #self.menu then
            love.event.quit()
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.currentMenuKeyItem ~= #self.menu then
            if option ~= '' then
                gStateMachine:change(self.menu[self.currentMenuKeyItem]:lower())
            end
        else
            love.event.quit()
        end
    end
end

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    -- love.graphics.setFont(gFonts['gothic-medium'])
    -- love.graphics.printf('Legend of', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setFont(gFonts['gothic-large'])
    -- love.graphics.printf('Azimuth', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Legend of Azimuth', 2, 0, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Legend of Azimuth', 0, 2, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['instructions'])

    for i, option in ipairs(self.menu) do
        -- draw option text shadow
        if i == 1 then
            option = "Create a New World"
        elseif i == 2 then
            option = "Load previous World" --this part will be a new state
        end

        self:drawTextShadow(option, 54 + (i - 1) * 28)

        -- set color based on current menu item
        if self.currentMenuItem == i or self.currentMenuKeyItem == i then
            love.graphics.setColor(99/255, 155/255, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end

        -- draw option text
        love.graphics.printf(option, 0, 54 + (i - 1) * 28, VIRTUAL_WIDTH, 'center')
    end
end

--love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
--[[
    Helper function for drawing just text backgrounds; draws several layers of the same text, in
    black, over top of one another for a thicker shadow.
]]
function StartState:drawTextShadow(text, y)
    love.graphics.setColor(34/255, 32/255, 52/255, 1)
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center')
end