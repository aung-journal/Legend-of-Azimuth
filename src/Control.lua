Control = Class{}

function Control:init()

end

function Control:update(dt)
    for k, sound in pairs(gSounds) do
        if k ~= 'music' then
            if Sound_effect then
                if gSoundPaused[k] then
                    sound:play()
                end
            else
                if sound:isPlaying() then
                    sound:pause()
                    gSoundPaused[k] = true
                end
            end
        end
    end
    
    if MUSIC then
        gSounds['music']:play()
    else
        gSounds['music']:pause()
    end    

    if gStateMachine:getCurrentStateName() == 'setting' then
        if love.keyboard.wasPressed('u') then
            Sound_effect = Sound_effect == false and true or false
        end
        if love.keyboard.wasPressed('t') then
            MUSIC = MUSIC == false and true or false
        end
    end

    if gStateMachine:getCurrentStateName() ~= 'start' and gStateMachine:getCurrentStateName() ~= 'begin-game' then
        if love.keyboard.wasPressed('p') then
            gStateMachine:change('pause', {
                state = gStateMachine:getCurrentStateName()
            })
        end
    end
end