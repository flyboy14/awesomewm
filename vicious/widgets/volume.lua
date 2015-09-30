---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
---------------------------------------------------

-- {{{ Grab environment
local tonumber = tonumber
local io = { popen = io.popen }
local setmetatable = setmetatable
local string = { match = string.match }
-- }}}


-- Volume: provides volume levels and state of requested ALSA mixers
-- vicious.widgets.volume
local volume = {}

-- {{{ Volume widget type
local function worker(format, warg)
    if not warg then return end

    local mixer_state = {
        ["on"]  = "♫", -- "",
        ["off"] = "♩"  -- "M"
    }

    -- Get mixer control contents
    local f = io.popen("pamixer --get-volume")
    local pulsevol = f:read("*all")
    f:close()

    -- Capture mixer control state:          [5%] ... ... [on]
    local f1 = io.popen("pamixer --get-mute")
    local mute = f1:read()
    f1:close()
    local volpa = string.match(pulsevol, "([%d]+)")
    -- Handle mixers without data
    if volpa == nil then
       return {0, mixer_state["off"]}
    end

    -- Handle mixers without mute
    if mute == "true" and volpa == "0"
    -- Handle mixers that are muted
    or mute == "true" then
       mute = mixer_state["off"]
    else
       mute = mixer_state["on"]
    end

    return {tonumber(volpa), mute}
end
-- }}}

return setmetatable(volume, { __call = function(_, ...) return worker(...) end, head }, volpa)
