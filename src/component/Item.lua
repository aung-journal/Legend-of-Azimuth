Item = Class{}

--I will later add damages for each weapon if type == weapon(which means it deals melee damage)

function Item:init(def, x, y, player)
    --string identifying the object type
    self.type = def.type
    self.specialType = def.specialType or false

    --'primary_weapons'
    self.texture = def.texture
    self.frame = def.frame or 1
    --this is just going to be only instantiating one thing in items_def for many item with same texture and type
    self.frames = def.frames or false
    --this is for knowing part of that frame, rendering what(so something that also have the same drop rate)
    self.part = self.frames and self.frames[math.random(#self.frames)] or false

    -- self.defaultState = def.defaultState
    -- self.state = self.defaultState
    -- self.states = def.states

    --the actual important part(the drop rate of that item)
    self.dropRate = def.dropRate or 0 -- if nil then drop rate is 0(means impossible)

    --dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.xScale = def.xScale or 1
    self.yScale = def.yScale or 1

    self.onCollide = function(player)
        player.inventory = player.inventory + self
    end
end

function Item:update(dt)

end

function Item:render()
    if not self.frames then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
            self.x, self.y, 0, self.xScale, self.yScale)
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.part],
            self.x, self.y, 0, self.xScale, self.yScale)
    end
end