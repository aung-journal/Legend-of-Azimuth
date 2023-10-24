PlayerInventoryState = Class{__includes = BaseState}

function PlayerInventoryState:init(player)
    self.player = player
    self.inventory = player.inventory
end

function PlayerInventoryState:update(dt)
    if love.keyboard.wasPressed('e') then
        self.player:changeState('idle')
    end
end

function PlayerInventoryState:render()
    love.graphics.clear(0, 0, 0, 1) -- Clear the screen with a black background
    love.graphics.setColor(1, 1, 1, 1) -- Set the drawing color to white

    local x, y = 50, 50 -- Initial position for rendering
    local spacing = 50 -- Vertical spacing between items

    for i, item in ipairs(self.inventory) do
        -- Load the image for the item
        item:render()

        -- Render the item name
        love.graphics.print(item.name, x, y + gFrames[item.texture][item.frame]:getHeight() + 5)

        y = y + spacing
    end
end
