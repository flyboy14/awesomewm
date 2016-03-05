--[[

     Dremora Awesome WM config 2.0
     github.com/copycat-killer

--]]

local awful = require("awful")
awful.util = require("awful.util")

--{{{ Main
theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"
if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end
sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
themes        = config .. "/themes"
themename     = "/color_arrows"
walldir	      = themes .. "/color_arrows/wallpapers"
if not awful.util.file_readable(themes .. themename .. "/theme.lua") then
       themes = sharedthemes
end
themedir      = themes .. themename

wallpaper2    = walldir .. "/wallpaper-2552963.jpg"
wallpaper3    = sharedthemes .. "/zenburn/zenburn-background1.png"
wallpaper4    = sharedthemes .. "/default/background.png"

if awful.util.file_readable(wallpaper2) then
  theme.wallpaper = wallpaper2
elseif awful.util.file_readable(wpscript) then
  theme.wallpaper_cmd = { "sh " .. wpscript }
elseif awful.util.file_readable(wallpaper3) then
  theme.wallpaper = wallpaper3
else
  theme.wallpaper = wallpaper4
end
--}}}
theme.font                          = "Fixed 8"--"Fixed 9"
theme.mycolor						= "#383C4A"
theme.taglist_font                  = "Visitor TT2 BRK 12"--"envypn 9"
theme.fg_normal                     = "#949494"
theme.fg_focus                      = "#7D96C8"--"#FFF9A4"
theme.bg_normal                     = theme.mycolor
theme.bg_focus                      = theme.mycolor
theme.fg_urgent                     = "#CC9393"
theme.bg_urgent                     = "#2A1F1E"
theme.border_normal                 = theme.mycolor
theme.border_width                  = "0"
theme.menu_border_width           	= "0"
theme.menu_border_color             = "[5]" .. theme.mycolor
theme.border_focus                  = "#3399FF"--"#DCD87B"
theme.titlebar_bg_focus             = "#292929"
theme.tooltip_fg_color				= "#cecece"
theme.tooltip_bg_color 				= "#6F766E"

theme.taglist_fg_focus              = "#dcdcdc" --#dcdcdc"
theme.taglist_bg_focus              = theme.mycolor
theme.menu_height                   = "24"
theme.menu_width                    = "170"
theme.bg_systray					= theme.mycolor .. "22"
theme.systray_icon_spacing			= "4"

theme.widget_weather                             = themedir .. "/icons/dish.png"
theme.widget_clock                             = themedir .. "/icons/clock.png"
theme.menu_submenu_icon             = themedir .. "/icons/submenu.png"
theme.taglist_squares_sel           = themedir .. "/icons/square_sel.png"
theme.taglist_squares_unsel         = themedir .. "/icons/square_unsel.png"
theme.arrl_ld_vol                   = themedir .. "/icons/arr2x16.png"
theme.arrl_dl_vol                   = themedir .. "/icons/arr1x16.png"
theme.arrl_dl_lang                   = themedir .. "/icons/arr4x16.png"
theme.arrl_ld_cpu                  = themedir .. "/icons/arr3x16.png"
theme.arrl_dl_mail                  = themedir .. "/icons/arr5x16.png"
theme.arrl_ld_mail                  = themedir .. "/icons/arr7x16.png"
theme.arrl_dl_bat                  = themedir .. "/icons/arr6x16.png"
theme.arrl_dl_net                  = themedir .. "/icons/arr8x16.png"
theme.arrl_dl_temp                  = themedir .. "/icons/arr9x16.png"
theme.arrl_dl_clock                  = themedir .. "/icons/arr10x16.png"
theme.arrl_ld_music                 = themedir .. "/icons/arr11x16.png"
theme.arrl_ld_mem                 = themedir .. "/icons/arr0x16.png"
theme.arrl                   = themedir .. "/icons/arrl_ld_sf.png"
theme.arrl                   = themedir .. "/icons/arrl_ld_sf.png"
theme.arrl_ld                  = themedir .. "/icons/arrl_ld_sf.png"
theme.arrl_dl                  = themedir .. "/icons/arrl_dl_sf.png"
theme.yf                = themedir .. "/icons/yf_x16.png"
theme.bf                = themedir .. "/icons/bf_x16.png"
theme.gf                = themedir .. "/icons/gf_x16.png"

theme.layout_tile                   = themedir .. "/icons/tile_x16.png"
theme.layout_tilegaps               = themedir .. "/icons/tilegaps.png"
theme.layout_tileleft               = themedir .. "/icons/tileleft_x16.png"
theme.layout_tilebottom             = themedir .. "/icons/tilebottom.png"
theme.layout_tiletop                = themedir .. "/icons/tiletop.png"
theme.layout_fairv                  = themedir .. "/icons/fairv_x16.png"
theme.layout_fairh                  = themedir .. "/icons/fairh.png"
theme.layout_spiral                 = themedir .. "/icons/spiral_x16.png"
theme.layout_dwindle                = themedir .. "/icons/dwindle.png"
theme.layout_max                    = themedir .. "/icons/max_x16.png"
theme.layout_fullscreen             = themedir .. "/icons/fullscreen.png"
theme.layout_magnifier              = themedir .. "/icons/magnifier.png"
theme.layout_floating               = themedir .. "/icons/floating_x16.png"

theme.widget_ac                             = themedir .. "/icons/ac.png"
theme.widget_battery_high                    = themedir .. "/icons/battery_hi_x16.png"
theme.widget_battery_mid                        = themedir .. "/icons/battery_med_x16.png"
theme.widget_battery_low                    = themedir .. "/icons/battery_lo_x16.png"
theme.widget_battery_very_low                    = themedir .. "/icons/battery_vlo_x16.png"
theme.widget_battery_empty                  = themedir .. "/icons/battery_no_x16.png"
theme.widget_mem                            = themedir .. "/icons/mem_x16.png"
theme.widget_cpu                            = themedir .. "/icons/cpu_x16.png"
theme.widget_temp                           = themedir .. "/icons/temp_x16.png"
theme.widget_net_hi                            = themedir .. "/icons/net_hi_x16.png"
theme.widget_net_mid                            = themedir .. "/icons/net_med_x16.png"
theme.widget_net_low                            = themedir .. "/icons/net_low_x16.png"
theme.widget_net_no                            = themedir .. "/icons/net_no_x16.png"
theme.widget_net_wired                            = themedir .. "/icons/net_wired_x16.png"
theme.widget_hdd                            = themedir .. "/icons/hdd.png"
theme.widget_music                          = themedir .. "/icons/note_x16.png"
theme.widget_music_on                       = themedir .. "/icons/note_on_x16.png"
theme.widget_vol_hi                        = themedir .. "/icons/vol_hi_x16.png"
theme.widget_vol_med                        = themedir .. "/icons/vol_med_x16.png"
theme.widget_vol_low                        = themedir .. "/icons/vol_low_x16.png"
theme.widget_vol_no                         = themedir .. "/icons/vol_no_x16.png"
theme.widget_vol_mute                       = themedir .. "/icons/vol_mute_x16.png"
theme.widget_mail                           = themedir .. "/icons/mail_x16.png"
theme.widget_mail_notify                    = themedir .. "/icons/mail_notify.png"

theme.tasklist_floating                     = ""
theme.tasklist_maximized_horizontal         = ""
theme.tasklist_maximized_vertical           = ""

-- lain related
theme.useless_gap_width             = 0
theme.layout_uselesstile            = themedir .. "/icons/uselesstile.png"
theme.layout_uselesstileleft        = themedir .. "/icons/uselesstileleft.png"
theme.layout_uselesstiletop         = themedir .. "/icons/uselesstiletop.png"

return theme
