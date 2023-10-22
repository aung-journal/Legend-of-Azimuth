-- ITEM_DEFS = {
--     ['bronze_sword'] = {
--         type = 'weapon',
--         specialType = 'damage',
--         texture = 'primary_weapons',
--         frame = 1,
--         width = 32,
--         height = 32,
--     }
-- }--this is the example version and I want to know if automated version below works

--primary weapons(types of weapons(at least deal melee damage))
gPrimaryWeapons = {
    ['shovel'] = {specialType = 'digging', index = 1},
    ['axe'] = {specialType = 'felling', index = 2} -- felling is same as cutting trees down
}


--this is different metals and ordered from lowest level to highest level(10 levels)(from level 1 to 100 and step of 10)
-- and non event or main ones are the first indexed in the arrays of this 2d array
gMetalLevels = {
    {'bronze'},
    {'copper'},
    {'iron'},
    {'steel'},
    {'orichalcum'},
    {'titanium'},
    {'platinum'},
    {'mithril'},
    {'verdantium'},
    {'celestium'}
}

ITEM_DEFS = {}

--this is for primary weapons
for j, weapon in pairs(gPrimaryWeapons) do
    for k, metalLevel in pairs(gMetalLevels) do
        local primaryMetal = metalLevel[1]
        local name = string.format('%s_%s', primaryMetal, j) -- Change 'metal' to 'primaryMetal'
        local weaponIndex = weapon.index
        ITEM_DEFS[name] = {
            type = 'weapon',
            specialType = weapon.specialType,
            texture = 'primary_weapons',
            frame = (weaponIndex - 1) * #gPrimaryWeapons + k,
            width = 32,
            height = 32,
            dropRate = 5 ^ weaponIndex
        }
    end
end

