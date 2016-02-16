-- {{{ Variable definitions

-- {{{ wibox
markup = lain.util.markup
-- }}}

-- {{{ colors
redcolor = "#E54C62"
bluecolor = "#46A8C3"
greencolor = "#7ac82e"
memcolor_back = "#EA9B84"
memcolor_front = "#EA9B84"
cpucolor_back = "#84D0D0"
cpucolor_front = "#393E4A"
wificolor_back = "#6F766E"
wificolor_front = "#111111"
mailcolor_back = "#4B696D"
mailcolor_front = "#4B696D"
mpdcolor_back = "#4B3B51"
mpdcolor_front = "#4B3B51"
volumecolor_back = "#E2AE7C"
volumecolor_front = "#444444"
keyboardcolor_back = "#92B0A0"
keyboardcolor_front = "#3D4C40"
weathercolor_back = "#C2C2A4"
weathercolor_front = "#5e5e5e"
batterycolor_back = "#6F766E"
batterycolor_front = "#CEDCCC"
clockcolor_back = "#444444"
clockcolor_front = "#aeaeae"
layoutcolor_back = "#383C4A"

-- }}}

modkey = "Mod4"
alt = "Mod1"
home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
iconsdir = confdir .. "/icons/comicdee"
themes = confdir .. "/themes"
scripts = confdir .. "/scripts"
active_theme = themes .. "/color_arrows"
-- Themes define colours, icons, and wallpapers
beautiful.init(active_theme .. "/theme.lua")

wireless_name = ""
myinterface = ""
inet_on = false
wpaper = beautiful.wallpaper
font_main = "Fixed 13"
terminal = "terminology"
browser = "google-chrome-stable"
editor = "subl3"
video = "optirun vlc"
editor_cmd = terminal .. " -e " .. editor
musicplr = "mpd " .. home .. "/.mpd/mpd.conf"
--musicplr = "mpd ~/.mpd/mpd.conf"
sc_a = scripts .. "/screenshot-area.sh"
sc_r = scripts .. "/screenshot-root.sh"
sc_c = scripts .. "/screenshot-clipboard.sh"
sc_r5 = "sleep 5s && " .. scripts .. "/screenshot-root.sh"
toggle_touchpad = "synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')"
vol_up = scripts .. "/vol_pa_dark.sh up"
vol_down = scripts .. "/vol_pa_dark.sh down"
vol_mute = scripts .. "/vol_pa_dark.sh mute"
bri_up = scripts .. "/bright_dark.sh"
bri_down = scripts .. "/bright_dark.sh"
translate_e_r = scripts .. "/translate.sh en ru"
translate_r_e = scripts .. "/translate.sh ru en"
tagimage_current = iconsdir .. "/media-record-green.svg"
tagimage_other = iconsdir .. "/media-record.svg"
tagico = tagimage_other

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,               -- 1
    awful.layout.suit.tile,                   -- 2
    awful.layout.suit.tile.left,              -- 3
    --awful.layout.suit.tile.bottom,            -- 4
    --awful.layout.suit.tile.top,               -- 5
    --awful.layout.suit.fair,                   -- 6
    --awful.layout.suit.fair.horizontal,        -- 7
    awful.layout.suit.spiral,                 -- 8
    --awful.layout.suit.spiral.dwindle,         -- 9
    awful.layout.suit.max,                    -- 10
    awful.layout.suit.max.fullscreen,         -- 11
    awful.layout.suit.magnifier               -- 12
}
-- }}}

 -- {{{ Tags ₪
theme.taglist_font = font_main
tags = {
    names  = { "⌂ ", "℺ ", "¶ ", "⚒ ", "♫ ","♿ ", "⚔ ", "➴ " },
    layout = { layouts[1], layouts[2], layouts[2], layouts[4], layouts[7], layouts[1], layouts[1], layouts[1] }
}

for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, tags.layout)
end