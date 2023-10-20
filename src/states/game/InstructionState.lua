InstructionState = Class{__includes = BaseState}

function InstructionState:init()
    self.transitionAlpha = 0

    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    })

    self.instructions = {
        {
            heading = "Main Menu Options:",
            text = "You can change settings in other states by clicking \'p\' and pause by clicking \"u\" which only don't apply in setting.\n.Click escape to quit immediately.\nPlay: Start a new game adventure.\nInstructions: Learn how to play.\nSettings: Customize your game experience.\nAchievements: View your achievements.\nHigh Scores: Check the top player scores.\nUsers: Manage player profiles (if applicable)."
        },
        {
            heading = "Instructions:",
            text = "1. Play:\n\nWhen you choose \"Play,\" the game will start.\nYou'll control the elemental creature's movement by tapping or clicking.\nCollect orbs of your element while avoiding obstacles.\nMatching the elemental orb with your creature's element doesn't penalize you; otherwise, you'll lose health or end the game.\nAchieving specific goals earns you achievements."
        },
        {
            heading = "2. In-Game Play:",
            text = "During gameplay, you'll see your score and collected orbs.\nNew obstacles will appear as you progress.\nCollect elemental orbs and activate temporary power-ups.\nThe game ends when you run out of health or manually quit."
        },
        {
            heading = "3. End Game:",
            text = "After the game ends, you'll see your final score.\nChoose \"Restart\" to begin a new game or \"Main Menu\" to return to the main menu.\nIf your score ranks among the top, enter your name (3 characters) to save it on the leaderboard."
        },
        {
            heading = "4. Instructions:",
            text = "In the \"Play\" section, you can learn how to play the game."
        },
        {
            heading = "5. Settings:",
            text = "Customize game settings such as sound volume and graphics quality.\nReturn to the main menu after making changes."
        },
        {
            heading = "6. Achievements:",
            text = "View all achievements and check which ones you've earned.\nAchievements may grant bonuses during gameplay.\nReturn to the main menu after viewing achievements."
        },
        {
            heading = "7. High Scores:",
            text = "See the top ten player scores.\nCompete for the highest score and bragging rights.\nReturn to the main menu after checking the high scores."
        },
        {
            heading = "8. Users:",
            text = "Manage different player profiles.\nUseful for keeping track of personal high scores and achievements.\nReturn to the main menu after managing user profiles."
        },
        {
            heading = "Enjoy your journey in the magical world of Elemental Flight!",
            text = ""
        }
    }    
    self.currentPage = 1

    self.scroll = 0

    self.offset = 0

    self.leftmaxPage = self.currentPage == 1
    self.rightmaxPage = self.currentPage == #self.instructions
end

function InstructionState:update(dt)
    --update our timer, which will be used for our fade transition
    Timer.update(dt)

    -- Handle user input to navigate pages (e.g., arrow keys or buttons) and make a tweening effect between moving those pages
    if love.keyboard.wasPressed("right") then
        self.leftmaxPage = (self.currentPage == 1 )
        self.rightmaxPage = self.currentPage == #self.instructions
        if not self.rightmaxPage then
            Timer.tween(0.75, {
                [self] = {offset = VIRTUAL_WIDTH}
            }):finish(function ()
                self.currentPage = math.min(self.currentPage + 1, #self.instructions)
                self.offset = 0
            end)
            --elf.currentPage = math.min(self.currentPage + 1, #self.instructions)
            gSounds['turn']:play()
        end
    elseif love.keyboard.wasPressed("left") then
        self.leftmaxPage = (self.currentPage == 1 )
        self.rightmaxPage = self.currentPage == #self.instructions
        if not self.leftmaxPage then
            Timer.tween(0.75, {
                [self] = {offset = -VIRTUAL_WIDTH}
            }):finish(function ()
                self.currentPage = math.max(self.currentPage - 1, 1)
                self.offset = 0
            end)
            --self.currentPage = math.max(self.currentPage - 1, 1)
            gSounds['turn']:play()
        end
    end

    --this is for navigating instruction positions
    if love.keyboard.isDown('up') then
        self.scroll = self.scroll + 2
        -- Timer.tween(0.4, {
        --     [self] = {scroll = self.scroll + 5}
        -- })
    elseif love.keyboard.isDown('down') then
        self.scroll = self.scroll - 2
        -- Timer.tween(0.4, {
        --     [self] = {scroll = self.scroll - 5}
        -- })
    end
end

function InstructionState:render()
    --background
    love.graphics.draw(gTextures['background'], 0, 0)
    
    -- keep the background and tiles a little darker than normal
    love.graphics.setColor(1/255, 1/255, 1/255, 128/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)

    -- draw our transition rect; is normally fully transparent, unless we're moving to a new state
    love.graphics.setColor(1, 1, 1, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
    --background

    --rendering instructions

    love.graphics.translate(0, self.scroll)

    local currentInstruction = self.instructions[self.currentPage]

    -- Calculate the text width and height
    local textWidth = VIRTUAL_WIDTH - 30 -- Max width to fit the screen
    local headingHeight = love.graphics.getFont():getHeight() -- Height of heading text
    local textHeight = 288 - headingHeight -- Remaining height for instruction text

    -- Render heading
    love.graphics.setFont(gFonts['instructions'])
    love.graphics.printf(currentInstruction.heading, 0 + self.offset, 0, textWidth, "center")
    --self:drawEditShadow(currentInstruction.heading, 0, 10, "center")

    -- Render instruction text
    love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.printf(currentInstruction.text, 0 + self.offset, headingHeight + 30, textWidth, "left")
    --self:drawEditShadow(currentInstruction.text, 0, headingHeight + 10, "left")
    --rendering instructions end
end

--[[
    Helper function for drawing just text backgrounds; draws several layers of the same text, in
    black, over top of one another for a thicker shadow.
]]
function InstructionState:drawTextShadow(text, y)
    love.graphics.setColor(34/255, 32/255, 52/255, 1)
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center')
end

function InstructionState:drawEditShadow(text, x, y, mode)
    love.graphics.setColor(34/255, 32/255, 52/255, 1)
    love.graphics.printf(text, x + 2, y + 1, VIRTUAL_WIDTH, mode)
    love.graphics.printf(text, x + 1, y + 1, VIRTUAL_WIDTH, mode)
    love.graphics.printf(text, x, y + 1, VIRTUAL_WIDTH, mode)
    love.graphics.printf(text, x + 1, y + 2, VIRTUAL_WIDTH, mode)
end