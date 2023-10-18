BeginGameState = Class{__includes = BaseState}

function BeginGameState:init()

    --set our transition to be full
    self.transitionAlpha = 1
end

function BeginGameState:enter(def)
    --self.level = def.level

    Timer.tween(2, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function ()
        Timer.tween(2, {
            [self] = {transitionAlpha = 1}
        }):finish(function ()
            gStateMachine:change('start')
        end)
    end)
end

function BeginGameState:update(dt)
    Timer.update(dt)
end

function BeginGameState:render()
    love.graphics.setColor(1,1,1, 1 - self.transitionAlpha)
    love.graphics.draw(gTextures['logo'], 0, 0)
end