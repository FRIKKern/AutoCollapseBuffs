-- Create a frame to listen for events
local frame = CreateFrame("Frame")

-- Register events for entering and leaving combat
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Fired when you enter combat
frame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Fired when you leave combat

-- Event handler function
local function OnEvent(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        -- Initialize the BuffFrame state when logging in or reloading the UI
        if InCombatLockdown() then
            if BuffFrame and BuffFrame.SetBuffsExpandedState then
                BuffFrame:SetBuffsExpandedState(false)
            end
        else
            if BuffFrame and BuffFrame.SetBuffsExpandedState then
                BuffFrame:SetBuffsExpandedState(true)
            end
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        -- Collapse the BuffFrame when entering combat
        if BuffFrame and BuffFrame.SetBuffsExpandedState then
            BuffFrame:SetBuffsExpandedState(false)
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Expand the BuffFrame when leaving combat
        if BuffFrame and BuffFrame.SetBuffsExpandedState then
            BuffFrame:SetBuffsExpandedState(true)
        end
    end
end

-- Set the script for the frame's events
frame:SetScript("OnEvent", OnEvent)
