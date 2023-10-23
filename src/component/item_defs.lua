ITEM_DEFS = {
    ['bronze_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 1,
        width = 32,
        height = 32, dropRate = 5 ^ 1
    },
    ['copper_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 2,
        width = 32,
        height = 32, dropRate = 5 ^ 2
    },
    ['iron_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 3,
        width = 32,
        height = 32, dropRate = 5 ^ 3
    },
    ['steel_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 4,
        width = 32,
        height = 32, dropRate = 5 ^ 4
    },
    ['orichalcum_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 5,
        width = 32,
        height = 32, dropRate = 5 ^ 5
    },
    ['titanium_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 6,
        width = 32,
        height = 32, dropRate = 5 ^ 6
    },
    ['platinum_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 7,
        width = 32,
        height = 32, dropRate = 5 ^ 7
    },
    ['mithril_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 8,
        width = 32,
        height = 32, dropRate = 5 ^ 8
    },
    ['verdantinum_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 9,
        width = 32,
        height = 32, dropRate = 5 ^ 9
    },
    ['celestium_shovel'] = {
        type = 'weapon',
        specialType = 'digging',
        texture = 'primary_weapons',
        frame = 10,
        width = 32,
        height = 32, dropRate = 5 ^ 10
    },
    ['bronze_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 11,
        width = 32,
        height = 32, dropRate = 5 ^ 1
    },
    ['copper_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 12,
        width = 32,
        height = 32, dropRate = 5 ^ 2
    },
    ['iron_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 13,
        width = 32,
        height = 32, dropRate = 5 ^ 3
    },
    ['steel_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 14,
        width = 32,
        height = 32, dropRate = 5 ^ 4
    },
    ['orichalcum_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 15,
        width = 32,
        height = 32, dropRate = 5 ^ 5
    },
    ['titanium_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 16,
        width = 32,
        height = 32, dropRate = 5 ^ 6
    },
    ['platinum_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 17,
        width = 32,
        height = 32, dropRate = 5 ^ 7
    },
    ['mithril_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 18,
        width = 32,
        height = 32, dropRate = 5 ^ 8
    },
    ['verdantinum_axe'] = {
        type = 'weapon',
        specialType = 'feling',
        texture = 'primary_weapons',
        frame = 19,
        width = 32,
        height = 32, dropRate = 5 ^ 9
    },
    ['celestium_axe'] = {
        type = 'weapon',
        specialType = 'felling',
        texture = 'primary_weapons',
        frame = 20,
        width = 32,
        height = 32, dropRate = 5 ^ 10
    },
}--this is the example version and I want to know if automated version below works

-- --primary weapons(types of weapons(at least deal melee damage))
-- gPrimaryWeapons = {
--     ['shovel'] = {specialType = 'digging', index = 1},
--     ['axe'] = {specialType = 'felling', index = 2} -- felling is same as cutting trees down
-- }


-- --this is different metals and ordered from lowest level to highest level(10 levels)(from level 1 to 100 and step of 10)
-- -- and non event or main ones are the first indexed in the arrays of this 2d array
-- gMetalLevels = {
--     {'bronze'},
--     {'copper'},
--     {'iron'},
--     {'steel'},
--     {'orichalcum'},
--     {'titanium'},
--     {'platinum'},
--     {'mithril'},
--     {'verdantium'},
--     {'celestium'}
-- }

-- ITEM_DEFS = {}

-- --this is for primary weapons
-- for j, weapon in pairs(gPrimaryWeapons) do
--     for k, metalLevel in pairs(gMetalLevels) do
--         local primaryMetal = metalLevel[1]
--         local name = string.format('%s_%s', primaryMetal, j) -- Change 'metal' to 'primaryMetal'
--         local weaponIndex = weapon.index
--         ITEM_DEFS[name] = {
--             type = 'weapon',
--             specialType = weapon.specialType,
--             texture = 'primary_weapons',
--             frame = (weaponIndex - 1) * 10 + k,
--             width = 32,
--             height = 32, dropRate = 5 ^ 1
--             dropRate = 5 ^ weaponIndex
--         }
--     end
-- end

