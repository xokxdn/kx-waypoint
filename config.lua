--[[
========================================================================================
  kx-waypoint — config
  Everything you'd actually want to change lives here. client.lua just reads
  these values, no need to touch it unless you want to change how it works.
========================================================================================
--]]

KxWaypointConfig = {

    -- ============================================================
    -- COLOR — pick ONE of the two options below.
    -- ============================================================

    -- Option A: use one of GTA's ~235 built-in named HUD colors instead of
    -- a custom RGB — the engine supplies the exact values, so there's
    -- nothing to get wrong. Set this to an index number to use it (this
    -- wins over the custom `color` below when set). Leave as `nil` to use
    -- a custom RGB color instead.
    --
    -- Full list with every name + preview swatch:
    --   https://docs.fivem.net/docs/game-references/hud-colors/
    -- A handful of likely-useful ones to save you a trip:
    --   9  = HUD_COLOUR_BLUE            48 = HUD_COLOUR_NET_PLAYER21 (light blue)
    --   6  = HUD_COLOUR_RED             18 = HUD_COLOUR_GREEN
    --   12 = HUD_COLOUR_YELLOW          15 = HUD_COLOUR_ORANGE
    --   21 = HUD_COLOUR_PURPLE          24 = HUD_COLOUR_PINK
    --   0  = HUD_COLOUR_PURE_WHITE      116 = HUD_COLOUR_FREEMODE (GTA:O blue)
    --   142 = HUD_COLOUR_WAYPOINT (the default purple, if you ever want it back)
    presetColorIndex = 9,

    -- Option B: exact custom RGBA (only used if presetColorIndex above is nil).
    --color = { r = 77, g = 163, b = 255, a = 255 },

    -- ============================================================
    -- ICON — the marker shown at the END of your route.
    -- ============================================================

    -- 162 (radar_poi, "point of interest") by default — a plain marker
    -- instead of the default GTA waypoint's star-burst/diamond look.
    -- Set to `nil` to leave the default GTA marker untouched.
    --
    -- I couldn't visually preview sprite icons while building this (the
    -- image host blocks automated fetches), so this pick is based on the
    -- sprite's name/purpose, not a confirmed look. If it's not right,
    -- browse the full list with previews here and swap the number:
    --   https://docs.fivem.net/docs/game-references/blips/
    -- A few other simple/plain candidates worth trying if 162 isn't it:
    --   1 = radar_level, 6 = radar_centre, 425 = radar_centre_stroke
    sprite = 161,

    -- ============================================================
    -- TIMING — usually no reason to touch these.
    -- ============================================================

    -- How often (ms) the color re-applies itself. Doesn't need to be fast —
    -- this exists so kx-waypoint keeps winning if another resource (e.g. an
    -- old postal-minimap script with its own waypoint-color code) is also
    -- touching the same HUD color slot, not because the setting decays on
    -- its own.
    colorReapplyInterval = 3000,

    -- How often (ms) it checks for a new waypoint blip to apply the custom
    -- sprite to. Only relevant if `sprite` above is set.
    spriteCheckInterval = 500,

}
