function can_lift_master_sword()
    if count("heartpiece")/4 + count("fullheart") >= 7 then
        return 1, AccessibilityLevel.Normal
    end
    return 0
end

function has_enough_keys(region, keys)
    local required_keys = required_key_count(region) + tonumber(keys)
    if count("goldkey") >= required_keys then
        return 1, AccessibilityLevel.Normal
    end
    return 0
end

function required_key_count(region)
    local keys = 0
    if has("@King Orchid's Tomb") and region ~= "King Orchid's Tomb" then
        keys = keys + 1
    end
    if has("@Morkla Dungeon") and region ~= "Morkla Dungeon" then
        keys = keys + 1
    end
    if has("@Canyon Temple") and region ~= "Canyon Temple" then
        keys = keys + 3
    end
    if has("@Mansion Dungeon") and region ~= "Mansion Dungeon" then
        keys = keys + 4
    end
    if has("@Minotaur King's Castle Dungeon") and region ~= "Minotaur King's Castle Dungeon" then
        keys = keys + 2
    end
    return keys
end

function has_any_overworld()
    return has("@Blossomdale") 
    or has("@Blossom Cemetary")
    or has("@Eastern Overworld")
    or has("@Western Overworld")
    or has("@Northern Overworld")
end

function has_any_jungle()
    return has("@Jungle Front") 
    or has("@Anchortown")
    or has("@Jungle Back")
    or has("@Jungle Island")
    or has("@Jungle Northeast")
end

function has_any_jungle_beach()
    return has("@Jungle Back") or has("@Jungle Island")
end

function has_any_canyon()
    return has("@Canyon North") or has("@Canyon Island") or has("@Dustwood")
end

function has_any_dark_woods()
    return has("@Dark Woods Front") or has("@Monsterton") or has("@Dark Woods Back")
end

function has_any_labyrinth()
    return has("@Labyrinth Front") or has("@Blockburg") or has("@Labyrinth Back")
end

function can_collect_ingredient(ingredient)
    local requirements = switch(ingredient) {
        ["Mushroom"] = has_any_overworld,
        ["Clover"] = has_any_overworld,
        ["Lily"] = has_any_dark_woods,
        ["RootWeed"] = has_any_dark_woods,
        ["MoonFlower"] = has_any_dark_woods,
        ["Apple"] = has_any_overworld,
        ["Tulip"] = has_any_overworld,
        ["Willow"] = has_any_jungle,
        ["Skyblossom"] = has_any_jungle,
        ["CanyonWisp"] = has_any_jungle,
        ["Orange"] = has_any_jungle,
        ["Spikeshell"] = has_any_jungle_beach,
        ["Clam"] = has_any_jungle_beach,
        ["Snailshell"] = has_any_jungle_beach,
        ["Seaweed"] = function() return has_any_jungle_beach() and has("fishingrod") end,
        ["Starfish"] = has_any_jungle_beach,
        ["Chrysanthemum"] = has_any_overworld,
        ["Aster"] = function() return has_any_dark_woods() and has("@CanCutBushes") end,
        ["Sunkiss"] = has_any_canyon,
        ["Jojoba"] = has_any_canyon,
        ["DesertPuff"] = has_any_canyon,
        ["WaterDrop"] = has_any_canyon,
        ["FlameTongue"] = has_any_canyon,
        ["CactusRose"] = has_any_canyon,
        ["PurpleMushroom"] = has_any_dark_woods,
        ["RedMushroom"] = has_any_dark_woods,
        ["GreenMushroom"] = has_any_dark_woods,
        ["Guts"] = has_any_jungle_beach,
        ["Poinsettia"] = has_any_labyrinth,
        ["Bellflower"] = has_any_labyrinth,
        ["Daisy"] = has_any_labyrinth,
        ["Crab"] = function() return has("fishingrod") and (has_any_canyon() or has("@Morkla Dungeon")) end,
        ["Fish1"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_overworld() or has_any_labyrinth()) end,
        ["Fish2"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_overworld()) end,
        ["Fish3"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_overworld() or has_any_jungle()) end,
        ["Fish4"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_canyon() or has_any_dark_woods()) end,
        ["Fish5"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_dark_woods()) end,
        ["Fish6"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_dark_woods() or has_any_labyrinth()) end,
        ["Fish7"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_jungle()) end,
        ["Fish8"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_jungle() or has_any_canyon()) end,
        ["Fish9"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_canyon()) end,
        ["Fish10"] = function() return has("fishingrod") and (has("@Northern Overworld") or has_any_labyrinth()) end
    }
    
    if requirements and requirements() then        
        return 1, AccessibilityLevel.Normal
    end
    return 0
end

function can_craft_jar(potion)
    if not has("jar") then
        return 0
    end

    local requirements = switch(potion) {
        ["Health"] = function() 
            return can_collect_ingredient("Apple") == 1
            and can_collect_ingredient("Mushroom") == 1
            and can_collect_ingredient("Clover") == 1
            and can_collect_ingredient("Tulip")== 1
        end,
        ["SlowTime"] = function() 
            return can_collect_ingredient("RootWeed") == 1
            and can_collect_ingredient("Snailshell") == 1
            and can_collect_ingredient("RedMushroom") == 1
            and can_collect_ingredient("Fish7")== 1
        end,
        ["Resurrection"] = function() 
            return can_collect_ingredient("Orange") == 1
            and can_collect_ingredient("Seaweed") == 1
            and can_collect_ingredient("Chrysanthemum") == 1
            and can_collect_ingredient("Starfish")== 1
        end,
        ["Ghost"] = function() 
            return can_collect_ingredient("MoonFlower") == 1
            and can_collect_ingredient("Aster") == 1
            and can_collect_ingredient("PurpleMushroom") == 1
            and can_collect_ingredient("Fish5")== 1
        end,
        ["Fire"] = function() 
            return can_collect_ingredient("Sunkiss") == 1
            and can_collect_ingredient("Guts") == 1
            and can_collect_ingredient("FlameTongue") == 1
            and can_collect_ingredient("Jojoba")== 1
        end,
        ["Speedster"] = function() 
            return can_collect_ingredient("Lily") == 1
            and can_collect_ingredient("GreenMushroom") == 1
            and can_collect_ingredient("Crab") == 1
            and can_collect_ingredient("Fish1")== 1
        end
    }

    if requirements and requirements() then        
        return 1, AccessibilityLevel.Normal
    end
    return 0
end