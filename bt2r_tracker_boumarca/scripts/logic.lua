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