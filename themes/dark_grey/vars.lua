local shifty = require("shifty")
local dpi = require("beautiful").xresources.apply_dpi
require("themes/dark_grey/functions")
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
grey_color = grey
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
font_main = "Ubuntu Mono 11"
font_wibox = "Arcade 11"
terminal = "terminology"
browser = "google-chrome-stable"
editor = "subl3"
fm = "worker"
editor_cmd = terminal .. " -e " .. editor
music = "spotify"
musicplr = "xfmpc"
videoplr = "baka-mplayer"
lockscreen = "slock"
-- sc_a = scripts .. "/screenshot-area.sh"
-- sc_r = scripts .. "/screenshot-root.sh"
-- sc_c = scripts .. "/screenshot-clipboard.sh"
sc_a = "flameshot gui -p " .. home .. "/Pictures/Screenshots"
sc_r = "flameshot full -p " .. home .. "/Pictures/Screenshots"
sc_c = "flameshot full -c"
sc_r5 = "flameshot gui -d 2000 -p " .. home .. "/Pictures/Screenshots"
toggle_touchpad = "synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')"
vol_up = scripts .. "/vol_pa_dark.sh up"
vol_down = scripts .. "/vol_pa_dark.sh down"
vol_mute = scripts .. "/vol_pa_dark.sh mute"
bri_up = scripts .. "/bright_dark.sh up"
bri_down = scripts .. "/bright_dark.sh down"
gist_clipboard = scripts .. "/gist_clipboard.sh"
gist_open = scripts .. "/gist_clipboard.sh 1"
ltrans = scripts .. "/ltrans.sh"
translate_e_r = scripts .. "/translate.sh ru"
translate_r_e = scripts .. "/translate.sh en"
btswitch = home .. "/scripts/btswitch.sh"
touchpad_toggle = scripts .. "/touchpad_toggle.sh"

tagimage_current = iconsdir .. "/media-record-green.svg"
tagimage_other = iconsdir .. "/media-record.svg"
tagico = tagimage_other

naughty.config.presets = {
    low = {
        bg = wibox_color() or "#121212",
        fg = "#dedede",
        timeout = 5,
        border_width = 0,
    },
    normal = {
        bg = wibox_color() or "#121212",
        fg = "#dedede",
        timeout = 5,
        border_width = 0,
    },
    critical = {
        bg = "#EE4C4C",
        fg = "#121212",
        timeout = 0,
        border_width = 0,
    }
}
naughty.config.defaults = {
    preset = naughty.config.presets.normal,
    text = "",
    screen = nil,
    ontop = true,
    margin = dpi(5),
    border_width = 0,
    position = "top_right"
}

mywibox = {}
mywibox_w = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}


 -- {{{ Tags ₪
-- theme.taglist_font = font_main
-- tags = {
--     names  = { "⌂ ", "℺ ", "¶ ", "⚒ ", "♫ ","♿ ", "⚔ ", "➴ " },
--     layout = { layouts[1], layouts[2], layouts[2], layouts[4], layouts[7], layouts[1], layouts[1], layouts[1] }
-- }
-- for s = 1, screen.count() do
--   tags[s] = awful.tag(tags.names, s, tags.layout)
-- end
