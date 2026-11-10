function can_lift_master_sword()
    if count("heartpiece")/4 + count("fullheart") >= 7 then
        return 1, AccessibilityLevel.Normal
    end
    return 0
end
