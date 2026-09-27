--[[
========================================================================================
  kx-waypoint — custom GPS waypoint color + marker icon
  Fully standalone: no dependency on kx-hud or any other resource. Safe to
  run alongside any HUD, since ReplaceHudColourWithRgba/SetBlipSprite are
  global engine calls, not tied to whichever resource happens to call them.

  All editable settings live in config.lua — this file is just the logic.
========================================================================================
--]]

local HUD_COLOUR_WAYPOINT <const> = 142

local function applyWaypointColor()
    if KxWaypointConfig.presetColorIndex then
        -- Copies another HUD color slot's existing RGBA onto the waypoint
        -- slot — the engine supplies the values, nothing to transcribe wrong.
        ReplaceHudColour(HUD_COLOUR_WAYPOINT, KxWaypointConfig.presetColorIndex)
    else
        local c = KxWaypointConfig.color
        ReplaceHudColourWithRgba(HUD_COLOUR_WAYPOINT, c.r, c.g, c.b, c.a)
    end
end

AddEventHandler("onClientResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        applyWaypointColor()
    end
end)

AddEventHandler("playerSpawned", function()
    applyWaypointColor()
end)

-- Re-applied periodically, not just at spawn — if another resource (e.g. an
-- old postal-minimap script with its own waypoint-color code baked in) is
-- also calling ReplaceHudColourWithRgba on this same slot, this keeps
-- kx-waypoint's color winning consistently instead of it being a coin-flip
-- based on which resource happened to run last.
CreateThread(function()
    while true do
        applyWaypointColor()
        Wait(KxWaypointConfig.colorReapplyInterval)
    end
end)

-- The waypoint blip is destroyed and recreated every time a new waypoint is
-- set (pressing M and clicking the map, tapping the map, another script
-- calling SetNewWaypoint), so a custom sprite has to be re-applied each
-- time rather than set once — this watches for that and re-applies it only
-- when the blip actually changes, not on every tick.
if KxWaypointConfig.sprite then
    local lastAppliedBlip = nil

    CreateThread(function()
        while true do
            local blip = GetFirstBlipInfoId(8) -- 8 = the waypoint blip TYPE (iteration key), unrelated to sprite IDs
            if blip and blip ~= 0 and DoesBlipExist(blip) then
                if blip ~= lastAppliedBlip then
                    lastAppliedBlip = blip
                    SetBlipSprite(blip, KxWaypointConfig.sprite)
                end
            else
                lastAppliedBlip = nil
            end

            Wait(KxWaypointConfig.spriteCheckInterval)
        end
    end)
end
