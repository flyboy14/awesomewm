-- {{{ Variable definitions

-- {{{ wibox
markup = lain.util.markup
yellow = "#FFF6B6"
strongyellow = "#E4E876"
orange = "#EBB06F"
strongorange = "#E09620"
hellorange = "#E05721"
red = "#FF9BA1"
strongred = "#e54c62"
blue = "#9EF7FF"
strongblue = "#46a8c3"
green = "#9BFFA6"
stronggreen = "#7AC82E"
grey = "#aeaeae"
white = "#fefefe"

yellow_color = yellow
orange_color = orange
red_color = strongred
blue_color = strongblue
green_color = stronggreen
grey_color = strongblue
-- }}}

modkey = "Mod4"
alt = "Mod1"
home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
iconsdir = confdir .. "/icons/comicdee"
themes = confdir .. "/themes"
scripts = confdir .. "/scripts"
active_theme = themes .. "/dark_grey"
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