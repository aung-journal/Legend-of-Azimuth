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

--get a list of keys of a table
function table.getKeys(tbl)
    local keys = {}
    
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    
    return keys
end

--python like range function but indexed inclusive
function range(start, stop, step)
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