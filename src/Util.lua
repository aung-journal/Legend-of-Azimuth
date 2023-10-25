--node path for potential creation of AIs
-- Create a function to calculate the path using A*
function calculatePath(start, goal)
    local openList = {}  -- List of nodes to be evaluated
    local closedList = {}  -- List of nodes already evaluated
    local cameFrom = {}  -- Keep track of the path

    -- Create a node for the starting position
    local startNode = {
        position = start,
        g = 0,  -- Cost from the start to this node (initially 0)
        h = heuristic(start, goal),  -- Heuristic cost from this node to the goal
    }
    startNode.f = startNode.g + startNode.h  -- Total cost

    table.insert(openList, startNode)

    while #openList > 0 do
        -- Find the node with the lowest f in the openList
        local currentNode = findLowestF(openList)

        -- If the current node is the goal, reconstruct the path and return it
        if currentNode.position == goal then
            return reconstructPath(cameFrom, currentNode)
        end

        -- Move the current node from openList to closedList
        table.remove(openList, findNodeIndex(openList, currentNode))
        table.insert(closedList, currentNode)

        -- Generate neighbor nodes and process them
        local neighbors = generateNeighbors(currentNode, goal)
        for _, neighbor in pairs(neighbors) do
            -- Skip nodes in closedList
            if not isInList(closedList, neighbor) then
                local tentativeG = currentNode.g + distance(currentNode.position, neighbor.position)

                -- If neighbor not in openList or new path is shorter
                local inOpenList = isInList(openList, neighbor)
                if not inOpenList or tentativeG < neighbor.g then
                    neighbor.cameFrom = currentNode
                    neighbor.g = tentativeG
                    neighbor.h = heuristic(neighbor.position, goal)
                    neighbor.f = neighbor.g + neighbor.h
                    if not inOpenList then
                        table.insert(openList, neighbor)
                    end
                end
            end
        end
    end

    -- If no path found, return nil
    return nil
end

-- Generate neighboring nodes for a given node
function generateNeighbors(node, goal)
    local neighbors = {}
    local x, y = node.position.x, node.position.y

    -- Assuming your game world is grid-based, and you can move in 8 directions (up, down, left, right, and diagonals)
    local directions = {
        {x = x - 1, y = y - 1}, -- Top-left
        {x = x, y = y - 1},     -- Top
        {x = x + 1, y = y - 1}, -- Top-right
        {x = x - 1, y = y},     -- Left
        {x = x + 1, y = y},     -- Right
        {x = x - 1, y = y + 1}, -- Bottom-left
        {x = x, y = y + 1},     -- Bottom
        {x = x + 1, y = y + 1}  -- Bottom-right
    }

    for _, dir in pairs(directions) do
        -- Ensure the neighbor is within the game world boundaries
        if isWithinBounds(dir.x, dir.y) then
            local neighbor = {
                position = {x = dir.x, y = dir.y},
                cameFrom = nil,  -- Initialize as nil
                g = 0,           -- Initialize as 0
                h = heuristic({x = dir.x, y = dir.y}, goal),  -- Calculate heuristic
                f = 0            -- Initialize as 0
            }
            table.insert(neighbors, neighbor)
        end
    end

    return neighbors
end

-- Calculate the Euclidean distance between two points
function distance(point1, point2)
    local dx, dy = point2.x - point1.x, point2.y - point1.y
    return math.sqrt(dx * dx + dy * dy)
end

-- Check if a point is within the game world boundaries (you should implement this function)
function isWithinBounds(x, y)
    -- Implement your game world boundaries check here
    -- Return true if (x, y) is within the allowed boundaries, otherwise return false
    -- For example, you might compare x and y with the size of your game world
end

-- Define the heuristic function (e.g., Euclidean distance)
function heuristic(a, b)
    local dx, dy = b.x - a.x, b.y - a.y
    return math.sqrt(dx * dx + dy * dy)
end

-- Implement other helper functions like findLowestF, findNodeIndex, generateNeighbors, and reconstructPath

-- Check if a node is in a list
function isInList(list, node)
    for _, n in pairs(list) do
        if n.position == node.position then
            return true
        end
    end
    return false
end

-- Find the node with the lowest f in a list
function findLowestF(list)
    local lowestF = math.huge
    local lowestNode = nil
    for _, node in pairs(list) do
        if node.f < lowestF then
            lowestF = node.f
            lowestNode = node
        end
    end
    return lowestNode
end

-- Find the index of a node in a list
function findNodeIndex(list, node)
    for i, n in pairs(list) do
        if n.position == node.position then
            return i
        end
    end
    return nil
end

-- Reconstruct the path once the goal is reached
function reconstructPath(cameFrom, current)
    local path = {}
    while current do
        table.insert(path, current.position)
        current = current.cameFrom
    end
    return path
end    

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

--[[
    Utility function for slicing tables, a la Python.

    https://stackoverflow.com/questions/24821045/does-lua-have-something-like-pythons-slice
]]
function table.slice(tbl, first, last, step)
    local sliced = {}
  
    for i = first or 1, last or #tbl, step or 1 do
      sliced[#sliced+1] = tbl[i]
    end
  
    return sliced
end

--something that can concatenate n amount of tables
function table.concatenate(...)
    local concatenatedTable = {}
    
    -- Concatenate all tables into one
    for _, tbl in ipairs({...}) do
        for _, value in ipairs(tbl) do
            table.insert(concatenatedTable, value)
        end
    end
    
    -- Sort the concatenated table in ascending order
    table.sort(concatenatedTable, function(a, b) return a < b end)
    
    return concatenatedTable
end

--excluding a value from a table
function table.exclude(table, keyToExclude)
    local newTable = {}
    for key, value in pairs(table) do
        if key ~= keyToExclude then
            newTable[key] = value
        end
    end
    return newTable
end

--get a list of keys of a table
function table.getKeys(tbl)
    local keys = {}
    
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    
    return keys
end

--python like range function but indexed inclusive
function table.range(start, stop, step)
    if not stop then
        stop = start
        start = 1
    end

    if not step then
        step = 1
    end

    local range = {}

    if step > 0 then
        for i = start, stop, step do
            table.insert(range, i)
        end
    elseif step < 0 then
        for i = start, stop, step do
            table.insert(range, i)
        end
    end

    return range
end

function table.findKeyByValue(tbl, value)
    local mt = { __index = function(t, n)
        assert(n > 0)
        for k, v in pairs(t) do
            n = n - 1
            if n == 0 then
                return v
            end
        end
    end}

    for k, v in pairs(tbl) do
        if v == value then
            return k -- Return the key when the value matches
        end
    end
    return nil -- Return nil if the value is not found
end

--[[
    Divides quads we've generated via slicing our tile sheet into separate tile sets.
]]
function GenerateTileSets(quads, setsX, setsY, sizeX, sizeY)
    local tilesets = {}
    local tableCounter = 0
    local sheetWidth = setsX * sizeX
    local sheetHeight = setsY * sizeY

    -- for each tile set on the X and Y
    for tilesetY = 1, setsY do
        for tilesetX = 1, setsX do
            
            -- tileset table
            table.insert(tilesets, {})
            tableCounter = tableCounter + 1

            for y = sizeY * (tilesetY - 1) + 1, sizeY * (tilesetY - 1) + 1 + sizeY do
                for x = sizeX * (tilesetX - 1) + 1, sizeX * (tilesetX - 1) + 1 + sizeX do
                    table.insert(tilesets[tableCounter], quads[sheetWidth * (y - 1) + x])
                end
            end
        end
    end

    return tilesets
end

--this is for printing 1d lua array like code version
function printLuaArray(variableName, array, level)
    if type(array) ~= "table" then
        print("Input is not a table (array).")
        return
    end

    level = level or 0
    local indent = string.rep("    ", level)  -- Adjust the number of spaces for indentation

    local result = variableName .. " = {\n"
    for i, value in ipairs(array) do
        result = result .. indent

        if type(value) == "number" then
            result = result .. value
        elseif type(value) == "string" then
            result = result .. '"' .. value .. '"'
        else
            result = result .. 'nil'
        end

        if i < #array then
            result = result .. ",\n"
        else
            result = result .. "\n"
        end
    end
    result = result .. indent .. "}"

    print(result)
end


--this is for printing 2d lua array like code version
function printLua2DArray(variableName, array, level)
    if type(array) ~= "table" then
        print("Input is not a table (array).")
        return
    end

    level = level or 0
    local indent = string.rep("    ", level)  -- Adjust the number of spaces for indentation

    local result = variableName .. " = {\n"
    for i, row in ipairs(array) do
        result = result .. indent .. "{"

        for j, value in ipairs(row) do
            if type(value) == "number" then
                result = result .. value
            elseif type(value) == "string" then
                result = result .. '"' .. value .. '"'
            else
                result = result .. 'nil'
            end

            if j < #row then
                result = result .. ", "
            end
        end

        result = result .. "}"

        if i < #array then
            result = result .. ",\n"
        else
            result = result .. "\n"
        end
    end
    result = result .. indent .. "}"

    print(result)
end

--[[
    Recursive table printing function.
    https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents/
]]
function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end