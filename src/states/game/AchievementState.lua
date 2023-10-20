AchievementState = Class{__includes = BaseState}

local startIndex = 1  -- Index of the first visible achievement
local achievementsPerPage = 2  -- Number of achievements to display per page

function AchievementState:enter(params)
    self.achievements = {
        {
            description = "Elementalist: Collect all elemental orbs in a single run.",
            value = 0
        },
        {
            description = "FlawlessFlight: Clear a certain number of obstacles without taking any damage.",
            value = 0
        },
        {
            description = "SpeedDemon: Reach a certain speed milestone in the game.",
            value = 0
        },
        {
            description = "FireWalker: Clear a certain number of fire obstacles without changing your elemental type.",
            value = 0
        },
        {
            description = "AquaticAdventurer: Clear a certain number of water obstacles without changing your elemental type.",
            value = 0
        },
        {
            description = "FlutteringEscape: Clear a certain number of air obstacles without changing your elemental type.",
            value = 0
        },
        {
            description = "MasterShapeShifter: Change your elemental type a certain number of times in a single run.",
            value = 0
        },
        {
            description = "OrbHoarder: Collect a certain number of orbs in total.",
            value = 0
        },
        {
            description = "BarrierBreaker: Clear a certain number of wall obstacles without taking any damage.",
            value = 0
        },
        {
            description = "PillarJumper: Clear a certain number of pillar obstacles without taking any damage.",
            value = 0
        }
    }
end

function AchievementState:update(dt)
    if love.keyboard.wasPressed('up') then
        startIndex = math.max(1, startIndex - 1)
    end

    if love.keyboard.wasPressed('down') then
        startIndex = math.min(#self.achievements - achievementsPerPage + 1, startIndex + 1)
    end
end

function AchievementState:render()
    love.graphics.draw(gTextures['background'], 0, 0)

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Achievements', 0, 0, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(gFonts['zelda-small'])

    -- Iterate over visible achievements based on the startIndex and achievementsPerPage
    for i = startIndex, startIndex + achievementsPerPage - 1 do
        local achievement = self.achievements[i]  -- Access the achievement data from the global table
        local description = achievement.description
        
        if achievement then
            
            -- Render the achievement here, including its description and status
            -- You can use achievement.value and achievement.description
            -- Render each achievement on a separate line, adjusting the Y position accordingly

            -- Achievement number (1-10)
            love.graphics.printf(tostring(i) .. '.', 10, 
            50 + (i - startIndex) * 80, 50, 'left')

            -- Achievement description
            love.graphics.printf(tostring(description), 48, 
                50 + (i - startIndex) * 80, 312, 'center')
            
            -- The completion status of the achievement
            love.graphics.printf(tostring(achievement.value), VIRTUAL_WIDTH / 3 + 170,
                50 + (i - startIndex) * 80, 100, 'right')
        end
    end
end
