--I primarily uses this asset pack: https://craftpix.net/product/100-pixel-art-armor-icons/
--I also use asset pack from GD50 src5 and src4
--I also use audio from GD50 src5 and src4

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Legend of Azimuth')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    love.graphics.setFont(gFonts['small'])

    gStateMachine = StateMachine {
        ['begin-game'] = function() return BeginGameState() end,
        ['pause'] = function() return PauseState() end,
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['instructions'] = function() return InstructionState() end,
        ['settings'] = function() return SettingState() end,
        ['achievements'] = function() return AchievementState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('begin-game')

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}

    paused = false
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(x,y,key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end

function love.update(dt)
    if not paused then
        Timer.update(dt)
        Control:update(dt)
        gStateMachine:update(dt)

        love.keyboard.keysPressed = {}
    end
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end