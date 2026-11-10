-- Common helper: returns true if the player has at least one of the code
function has(code)
    return Tracker:ProviderCountForCode(code) > 0
end

-- Quantity check
function count(code)
    return Tracker:ProviderCountForCode(code)
end