-- Standard awesome library
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
beautiful = require("beautiful")
vicious = require("vicious")
local awesompd = require("awesompd/awesompd")
naughty = require("naughty")
keychains = require("keychains")
eminent = require("eminent")
xdg_menu = require("archmenu")
orglendar = require("orglendar")

-- {{{ Localization

--os.setlocale(os.getenv("LANG"))

-- }}}

-- {{{ Error Handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Произошла ошибка при запуске awesome! :(",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Произошла ошибка при работе awesome :c",
                         text = err })
        in_error = false
    end)
end

-- {{{ Variable definitions

-- Useful Paths
home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
iconsdir = confdir .. "/icons/comicdee"
themes = confdir .. "/themes"
scripts = confdir .. "/scripts"
active_theme = themes .. "/dark_grey"
-- Themes define colours, icons, and wallpapers
beautiful.init(active_theme .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
wpaper = beautiful.wallpaper
font_main = "Fixed 14"
terminal = "urxvtc -T Terminal"
browser = "firefox"
editor = "subl"
editor_cmd = terminal .. " -e " .. editor
musicplr = "mpd " .. home .. "/.mpd/mpd.conf"
sc_a = "sh " .. scripts .. "/screenshot-area.sh"
sc_w = "sh " .. scripts .. "/screenshot-wind.sh"
sc_r = "sh " .. scripts .. "/screenshot-root.sh"
sc_r5 = "sleep 5s && sh " .. scripts .. "/screenshot-root.sh"
volpa_up = "sh " .. scripts .. "/vol_pa_dark.sh up"
volpa_down = "sh " .. scripts .. "/vol_pa_dark.sh down"
volpa_mute = "sh " .. scripts .. "/vol_pa_dark.sh mute"
vol_up = "sh " .. scripts .. "/vol_dark.sh up"
vol_down = "sh " .. scripts .. "/vol_dark.sh down"
vol_mute = "sh " .. scripts .. "/vol_dark.sh mute"
bri_up = "sh " .. scripts .. "/bright_dark.sh up"
bri_down = "sh " .. scripts .. "/bright_dark.sh down"
translate_o_r = "sh " .. scripts .. "/translate_other_ru.sh"
translate_r_e = "sh " .. scripts .. "/translate_ru_en.sh"
tagimage_current = iconsdir .. "/media-record-green.svg"
tagimage_other = iconsdir .. "/media-record.svg"
tagico = tagimage_other
-- Default modkey.
modkey = "Mod4"
alt = "Mod1"
-- }}}

function show_smth(tiitle, teext, icoon, timeeout, baackground, fooreground, foont, poosition)
   hide_smth()
   --naughty.destroy(noti)
   noti = naughty.notify{title = tiitle or nil, text = teext or nil, icon = icoon or "", timeout = timeeout or 5
   , bg = baackground or "#121212", fg = fooreground or "#dedede", font = foont or beautiful.font, position = poosition or "top_right", opacity = 1 }
 end

 function hide_smth()
   naughty.destroy(noti)
 end

-- }}}
-- Autorun programs

function run_once(prg)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end
function run_pcm(prg)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg  .. " || (" .. prg ..  " -d)")
end
function run_skype(prg)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg  .. " || (" .. "sleep 10s && " .. prg .. ")")
end
autorun = true
autorunApps =
{
   "sh " .. home .. "/.config/autostart/autostart.sh",
   "urxvtd -o -f -q",
   run_pcm("pcmanfm"),
   run_once("kbdd"),
   run_once("hidcur"),
   run_once("unagi"),
   --"xcowsay 'Moo, brother, moo.'"
}
if autorun then
   for app = 1, #autorunApps do
      awful.util.spawn_with_shell(autorunApps[app])
   end
end

-- {{{ functions to help launch run commands in a terminal using ":" keyword
function check_for_terminal (command)
   if command:sub(1,1) == ":" then
      command = terminal .. ' -hold -e "' .. command:sub(2) .. '"'
   end
   awful.util.spawn_with_shell(command)
end

function clean_for_completion (command, cur_pos, ncomp, shell)
   local term = false
   if command:sub(1,1) == ":" then
      term = true
      command = command:sub(2)
      cur_pos = cur_pos - 1
   end
   command, cur_pos =  awful.completion.shell(command, cur_pos,ncomp,shell)
   if term == true then
      command = ':' .. command
      cur_pos = cur_pos + 1
   end
   return command, cur_pos
end
-- }}}

-- {{{ Wallpaper
local f = io.popen("cat " .. home .. "/.config/nitrogen/bg-saved.cfg | grep file | sed 's/'file='//g'") 
wpaper = f:read()
f:close()  
if wpaper == nil then
  if beautiful.wallpaper then
  wpaper = beautiful.wallpaper
  end
end
for s = 1, screen.count() do
  gears.wallpaper.maximized(wpaper, s, false)
  --gears.wallpaper.maximized(wpaper,s,true)
end
-- }}}

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
    --awful.layout.suit.magnifier               -- 12
}
-- }}}

 -- {{{ Tags
 theme.taglist_font                  = "Fixed 14"
 tags = {
   names  = { "⌂ ", "℺ ", "¶ ", "⚒ ", "♫ ","♿ ", "⚔ ", "… " },
   layout = { layouts[2], layouts[5], layouts[4], layouts[4], layouts[3], layouts[1], layouts[1], layouts[1] }
 }

 for s = 1, screen.count() do
     tags[s] = awful.tag(tags.names, s, tags.layout)
 end
 -- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
mmyawesomemenu = {
   { " edit", editor .. " " .. awesome.conffile, iconsdir .. "/clipboard.svg" },
   { " restart", awesome.restart, iconsdir .. "/media-circling-arrow.svg" },
   { " quit", "pkill --signal SIGKILL awesome", iconsdir .. "/media-no.svg" }
}

mybordermenu = {
  {"  Borderlands II RUS", "optirun " .. home .. "/Borderlands2/Borderlands2 -language=rus", iconsdir .. "/border_ru.png"},
  {"  Borderlands II ENG", " optirun ".. home .. "/Borderlands2/Borderlands2", iconsdir .. "/border_en.png"},
}

mygamesmenu = {
   { "Borderlans II", mybordermenu },
   { "  Torchlight II", "optirun wine " .. home .. "/WINE/wineZ/drive_c/R.G.\\ Catalyst/Torchlight\\ II/Torchlight2.exe", "/home/master-p/WINE/wineZ/drive_c/R.G. Catalyst/Torchlight II/game.ico" },
   { "  Path of Exile", "sh " .. scripts .. "/poe.sh", "/home/master-p/Downloads/cyberman.png" },   
   { "  LEGO Star Wars III", "sh " .. scripts .. "/lsw3.sh", home .. "/Downloads/LEGO-Star-Wars-II-4-icon.png" },
   { "  Вечное лето", home .. "/Desktop/Everlasting Summer.desktop", iconsdir .. "/icon.icns" },
   { "  Besiege", home .. "/Besiege_v0.01_Linux/Besiege.x86_64", iconsdir .. "/besiege.png" },
   { "  SPORE", "guake -e 'sh" .. home .. "/bin/spore.sh'", iconsdir .. "/spore.png" },
   { "  WORMS Revolution", "guake -e 'sh " .. scripts .. "/worms.sh'", iconsdir .. "/worms.png" },
   { "  Xonotic", home .. "/Xonotic/xonotic-linux64-sdl -basedir " .. home .. "/Xonotic/", iconsdir .. "/xonotic_icon.svg" },
   { "  Kingdoms of Amalur", "guake -e 'sh " .. scripts .. "/KoA.sh'", iconsdir .. "/koa.png" },
   { "  The Cave", "guake -e 'optirun sh " .. home .. "/TheCave/run_game.sh &'", iconsdir .. "/the_cave.png" },
   { "  Left for Dead 2", "optirun steam steam://rungameid/550", "/home/master-p/.steam/steam/SteamApps/common/Left 4 Dead 2/left4dead2.ico" },
   { "  Dota 2", "optirun steam steam://rungameid/570", iconsdir .. "/dota2.png" },
   { "  Battle.net", "guake -e 'sh " .. scripts .. "/Battlenet.sh'", iconsdir .. "/Badge_battlenet.png" },
   { "  Elegy for a Dead World", "guake -e 'sh " .. scripts .. "/Elegy.sh'", iconsdir .. "/Elegy.ico" },
   { "  Iesabel", "Iesabel/Iesabel/Iesabel.x86_64", iconsdir .. "/Iesabel-Logo.jpg" },
   { "  Anomaly Warzone", "/home/master-p/AnomalyWarzoneEarth/AnomalyWarzoneEarth", iconsdir .. "/icon.png" },
   { "  Diablo II LoD", "wine " .. home .. "/WINE/wineZ/drive_c/Games/D2/Game.exe", iconsdir .. "/icone.ICO" },
   { "  teeworlds", "teeworlds", iconsdir .. "/redbopp.png" },

   }

myworkspacemenu = {
                                  { "Home", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[1] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                    { "Browse", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[2] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                    { "Doc", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[3] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                    { "IDE", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[4] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                    { "Media", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[5] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                    { "Virtual", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[6] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                    { "Wine", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[7] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                    { "Etc", function () if client.focus then local tag = awful.tag.gettags(client.focus.screen)[8] if tag then awful.client.movetotag(tag) awful.tag.viewonly(tag) end end end },
                                       }

mytaskmenu = awful.menu({ items = {
                                    { "Move to workspace", myworkspacemenu },
                                    { "  Fullscreen", function () c = client.focus c.fullscreen = not c.fullscreen end, iconsdir .. "/display.svg" },
                                    { "  Minimize", function () c = client.focus c.minimized = true end, iconsdir .. "/view-restore.svg"},
                                    { "  Close", function() client.focus:kill() end, iconsdir .. "/media-no.svg" },
                                  }
                        })

mymainmenu = awful.menu({ items = {
                                    { "  Samowar (beta)", "samowar", iconsdir .. "/musical-note-stripped.svg" },
                                    { "  KeePassX", "keepassx", iconsdir .. "/keepassx.svg"},
                                    { "  DoubleCommander", "doublecmd", iconsdir .. "/doublecmd.svg"},
                                    { "  Файлообменник", "wine " .. home.. "/WINE/wineZ/drive_c/fayloobmennik.net.exe", iconsdir .. "/mailbox.svg" },
                                    { "  Расписание", "libreoffice " .. home .. "/temp/raspis.xlsx", iconsdir .. "/key-p.svg" },
                                    { "Приложения", xdgmenu },
                                    { "Игры", mygamesmenu },
                                    { "  Обои", "nitrogen", iconsdir .. "/greylink-dc.png" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = iconsdir .. "/tv_icon.gif",
    menu = mymainmenu})
--mylauncher = awful.widget.launcher({ image = "/home/master-p/Downloads/starfallenwolf.gif", menu = mymainmenu })

-- Colours
coldef  = "</span>"
colwhi  = "<span color='#b2b2b2'>"
red = "<span color='#e54c62'>"
--=
-- set the desired pixel coordinates:

--  if your screen is 1024x768 the this line sets the bottom right.
--local safeCoords = {x=0, y=768}
--local moveMouseOnStartup = true
--local function moveMouse(x_co, y_co)
--    mouse.coords({ x=x_co, y=y_co })
--end

--if moveMouseOnStartup then
--        moveMouse(safeCoords.x, safeCoords.y)
--end

--=

-- Memory widget
memwidget = wibox.widget.textbox()
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
vicious.register(memwidget, vicious.widgets.mem, "<span font='mintsstrong 7' color='#aeaeae'> $2MB/$3MB </span>", 3)

--awesompd

musicwidget = awesompd:create() -- Create awesompd widget
musicwidget.font = "Fixed 8"
musicwidget.font_color = "#e54c62"
 musicwidget.scrolling = false -- If true, the text in the widget will be scrolled
 musicwidget.output_size = 30 -- Set the size of widget in symbols
 musicwidget.update_interval = 1 -- Set the update interval in seconds
 musicwidget.path_to_icons = confdir .. "/awesompd/icons"
 musicwidget.jamendo_format = awesompd.FORMAT_MP3
 musicwidget.show_album_cover = true
 musicwidget.album_cover_size = 50
 musicwidget.mpd_config = home .. "/.mpd/mpd.conf"
 musicwidget.browser = browser

 musicwidget.ldecorator = " "
 musicwidget.rdecorator = " "
 -- Set all the servers to work with (here can be any servers you use)
 musicwidget.servers = {
    { server = "localhost",
         port = 6600 },
          }
musicwidget:register_buttons({ { "", awesompd.MOUSE_LEFT, musicwidget:command_toggle() },
			         { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
			         { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
			         { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
			         { "", "XF86AudioPlay", musicwidget:command_playpause() },
			         { "", "XF86AudioNext", musicwidget:command_next_track() },
   			         { "", "XF86AudioPrev", musicwidget:command_prev_track() },
			         { "", "XF86AudioStop", musicwidget:command_stop() },
			         })
 musicwidget:run()

--  function mpdicon()
--   if musicwidget:playing() then
-- mpdicon:set_image(beautiful.widget_music_on)
-- else
--   mpdicon:set_image(beautiful.widget_music)
-- end
--  end

-- Music widget 
mpdwidget = wibox.widget.textbox()
mpdicon = wibox.widget.imagebox()
mpdicon:set_image(beautiful.widget_music)
mpdicon:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.util.spawn_with_shell("mpd " .. home .. "/.mpd/mpd.conf|sonata") end),
awful.button({ }, 2, function () awful.util.spawn_with_shell("sonata") end),
awful.button({ }, 3, function () awful.util.spawn_with_shell("pkill mpd|pkill sonata") end),
awful.button({ }, 4, function () awful.util.spawn_with_shell("mpc volume +5")end),
awful.button({ }, 5, function () awful.util.spawn_with_shell("mpc volume -5")end)))

vicious.register(mpdwidget, vicious.widgets.mpd,
function(widget, args)
  -- play
  if (args["{state}"] == "Play") then
    mpdicon:set_image(beautiful.widget_music_on)
    return "<span background='#121212' font='Visitor TT2 BRK 10'> <span font='Visitor TT2 BRK 10'>" .. "<span color='#e54c62'>" .. args["{Title}"] .. "</span>" .. "<span color='#dedede'>" .. " - " .. "</span>" .. "<span color='#b2b2b2'>"  .. args["{Artist}"] .. "</span>" .. " </span></span>"
  -- pause
  elseif (args["{state}"] == "Pause" or args["{state}"] == "Stop") then
    mpdicon:set_image(beautiful.widget_music)
    return "<span background='#121212' font='Visitor TT2 BRK 10'> <span font='Visitor TT2 BRK 10'>" .. colwhi .. args["{Title}"] .. coldef .. colwhi .. " - " .. coldef .. colwhi  .. args["{Artist}"] .. coldef .. " </span></span>"
  else
    mpdicon:set_image(beautiful.widget_music)
    return "<span font='Visitor TT2 BRK 10' color='#e54c62'>musico </span>"
  end
end, 1)

-- Battery widget
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_battery)
baticon:buttons(awful.util.table.join(
awful.button({ }, 1, function () show_smth(nil, "Z-z-z-z-z-z-z", iconsdir .. "/important.svg", 1, nil, nil, nil, nil) end, function () awful.util.spawn_with_shell("systemctl suspend")end)))


function batstate()
  local batstate = nil
  local file = io.open("/sys/class/power_supply/BAT0/status", "r")

  if (file == nil) then
    return "Cable plugged"
  end

  batstate = file:read("*line")
  file:close()

  if (batstate == 'Discharging' or batstate == 'Charging') then
    return batstate
  else
    return "Fully charged"
  end
end

batwidget = wibox.widget.textbox()
batwidget:buttons(awful.util.table.join(
awful.button({ }, 4, function () awful.util.spawn_with_shell(bri_up)end),
awful.button({ }, 5, function () awful.util.spawn_with_shell(bri_down) end)))

vicious.register(batwidget, vicious.widgets.bat,
function (widget, args)
-- plugged
  if (batstate() == 'Cable plugged') then
    baticon:set_image(beautiful.widget_ac)
    return '<span background="#121212" font="Fixed 14"><span font="Visitor TT2 BRK 10"color="#46A8C3">AC</span></span>'
    -- critical
  elseif (args[2] <= 7 and batstate() == 'Discharging') then
    baticon:set_image(beautiful.widget_battery_empty)
    awful.util.spawn("systemctl suspend")
  elseif (batstate() == 'Discharging' and args[2] <= 10) then
    show_smth("⚡ Внимание! ⚡", "Очень  мало энергии", iconsdir .. "/battery-red.svg", 1, nil, nil, nil, nil )
  elseif (args[2] <= 15) then
    baticon:set_image(beautiful.widget_battery_empty)
  elseif (args[2] <= 25) then
    baticon:set_image(beautiful.widget_battery_very_low)
  elseif (args[2] <= 45) then
    baticon:set_image(beautiful.widget_battery_low)
 elseif (args[2] <= 89) then
    baticon:set_image(beautiful.widget_battery_mid)
 elseif (args[2] >= 90) then
    baticon:set_image(beautiful.widget_battery_high)
  end
   if (batstate() == 'Discharging') then
    return '<span background="#121212" color="#e54c62" font="Fixed 9">↓ <span rise="1000" font="mintsstrong 7">' .. args[3] .. '<span color="#aeaeae">p' .. args[2] ..' </span></span></span>'
   elseif (batstate() == 'Charging' and args[2] ~= 100) then
    return '<span background="#121212" font="Fixed 9" color="#7AC82E">↑ <span rise="1000" font="mintsstrong 7">' .. args[3] .. '<span color="#aeaeae">p' .. args[2] ..' </span></span></span>'
   else 
    return '<span background="#121212" color="#46A8C3" font="Fixed 9">⚡ <span rise="1000" font="mintsstrong 7">AC<span color="#aeaeae">p' .. args[2] ..' </span></span></span>' end
end, 3, 'BAT0')

-- Keyboard layout widget
kbdwidget = wibox.widget.textbox()
kbdcolb = "<span font='mintsmild 7' color='#aeaeae'>> "
kbdcole = "</span>"
kbdwidget.border_width = 0
kbdwidget.border_color = beautiful.fg_normal
kbdwidget:set_markup(kbdcolb .. "en-us" .. kbdcole)
dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
    local data = {...}
    local layout = data[2]
    lts = {[0] = "en-us", [1] = "ru-ru"}
    kbdwidget:set_markup (kbdcolb..""..lts[layout]..""..kbdcole)
    end
)

-- Mail widget
 mygmail = wibox.widget.textbox()
 mygmail:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(browser .. " gmail.com") end)))
--Register widget
 vicious.register(mygmail, vicious.widgets.gmoil, 
  ' <span color="#FFA963" font="Visitor TT2 BRK 10">${count}</span>', 260)
 mygmailimg = wibox.widget.imagebox(beautiful.widget_mail)
 mygmailimg:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(browser .. " gmail.com") end)))

-- CPU widget
 cpuicon = wibox.widget.imagebox()
 cpuicon:set_image(beautiful.widget_cpu)
 cpuwidget = wibox.widget.textbox()
 vicious.register(cpuwidget, vicious.widgets.cpu, '<span font="mintsstrong 7" color="#46A8C3"> CPU <span color="#aeaeae">$1<span font="Visitor TT2 BRK 10">% </span></span></span>', 3)

-- Weather widget
tempicon = wibox.widget.imagebox()
tempicon:set_image(beautiful.widget_temp)
tempicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("gnome-weather") end)))
   tempicon:connect_signal("mouse::enter", function()
                                                 show_smth(nil, weather_t, nil, 0, nil, "#eeeeee", nil, nil)
                                              end)
   tempicon:connect_signal("mouse::leave", function(c)
                                                 hide_smth()
                                              end)
weatherwidget = wibox.widget.textbox()
weatherwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("gnome-weather") end)))
   weatherwidget:connect_signal("mouse::enter", function()
                                                 show_smth(nil, weather_t, nil, 0, nil, "#eeeeee", nil, nil)
                                              end)
   weatherwidget:connect_signal("mouse::leave", function()
                                                 hide_smth()
                                              end)

vicious.register(weatherwidget, vicious.widgets.weather,
                function (widget, args)
                    weather_t = "City: " .. args["{city}"] .."\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"] .. "%"
                    if args["{tempc}"] == "N/A" then
                      return '<span font="Visitor TT2 BRK 10" color="#dedede">:(</span>'
                    elseif args["{tempc}"] <= 0 then
                      return '<span font="Visitor TT2 BRK 10" color="#69E0CC">' .. args["{tempc}"] .. 'C</span>'
                    elseif args["{tempc}"] <= 14 then
                      return '<span font="Visitor TT2 BRK 10" color="#E4E876">+' .. args["{tempc}"] .. 'C</span>'
                    elseif args["{tempc}"] <= 30 then
                      return '<span font="Visitor TT2 BRK 10" color="#E09620">+' .. args["{tempc}"] .. 'C</span>'
                    elseif args["{tempc}"] > 30 then
                      return '<span font="Visitor TT2 BRK 10" color="#E05721">fuck, it\'s +' .. args["{tempc}"] .. 'C</span>'
                    end
                end, 600, "UMMS")
                --'600': check every 10 minutes.
                --'UMMS': the Minsk ICAO code.

-- Volume widget
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol_hi)
volicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(volpa_mute) end)))
volumewidget = wibox.widget.textbox()
volumewidget:buttons(awful.util.table.join(
  awful.button({ }, 4, function () awful.util.spawn_with_shell(vol_up) end),
  awful.button({ }, 5, function () awful.util.spawn_with_shell(vol_down) end),
  awful.button({ }, 1, function () awful.util.spawn("pavucontrol") end )))
vicious.register(volumewidget, vicious.widgets.volume,
function (widget, args)
  if (args[2] ~= "♩" ) then
      if (args[1] == 0) then volicon:set_image(beautiful.widget_vol_no)
      elseif (args[1] <= 35) then  volicon:set_image(beautiful.widget_vol_low)
        elseif (args[1] <= 70) then  volicon:set_image(beautiful.widget_vol_med)
      else volicon:set_image(beautiful.widget_vol_hi)
      end
  else volicon:set_image(beautiful.widget_vol_mute)
  end
  return '<span font="mintsstrong 7" color="#aeaeae">' .. args[1] .. '<span font="Visitor TT2 BRK 10">%</span></span>'
end, 1, "Master")

-- Net widget
netwidget = wibox.widget.textbox()
neticon = wibox.widget.imagebox()
neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("systemctl restart wpa_supplicant@wlp3s0 systemd-networkd") end)))
netwidget:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.util.spawn("wpa_gui") end),
awful.button({ }, 3, function () awful.util.spawn_with_shell("pkill wpa_gui") end)
))
vicious.register(netwidget, vicious.widgets.wifi, 
  function (widget, args)
      link = args['{link}']
      -- wifiicon.visible = true  -- didnt help
      if link > 65 then
        neticon:set_image(beautiful.widget_net_hi)
      elseif link > 30 and link <= 65 then
        neticon:set_image(beautiful.widget_net_mid)
      elseif link > 0 and link <= 30 then
        neticon:set_image(beautiful.widget_net_low)
      else
        neticon:set_image(beautiful.widget_net_no)
      end
      return '<span font="fixed 7" color="#aeaeae" rise="-1000">' .. args['{ssid}'] .. '</span>'
      --end
    end,
  2,"wlp3s0")

snetwidget = wibox.widget.textbox()
snetwidget:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.util.spawn("wpa_gui")
 end),
awful.button({ }, 3, function () awful.util.spawn_with_shell("pkill wpa_gui") end)
))
vicious.register(snetwidget, vicious.widgets.net,'<span font="mintsstrong 7" color="#aeaeae"> <span color="#7ac82e">${wlp3s0 down_kb}</span><span color="#aeaeae" rise="-1000"> ↓</span><span rise="-1000">↑ </span><span color="#46A8C3">${wlp3s0 up_kb}</span></span>', 3)


-- Separators
face = wibox.widget.textbox('<span color="#e54c62" font="Visitor TT2 BRK 10">//\\(o.o_)/\\\\</span>')
face:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.util.spawn_with_shell(scripts .. "/change_config.sh") end, awesome.restart),
awful.button({ }, 3, function(c)
  local f = io.popen("fortune -s") 
  local quote = f:read("*all") 
  f:close()
  show_smth("Wisdom spider", quote, nil, 0, nil, nil, "Fixed 9", "bottom_right") 
  end)
))
face:connect_signal("mouse::enter", function(c)
  local f = io.popen("fortune -s") 
  local quote = f:read("*all") 
  f:close()
  show_smth("Wisdom spider :", quote, nil, 0, nil, nil, "Fixed 9", "bottom_right") end)
face:connect_signal("mouse::leave", function(c)
hide_smth()
end)

bral = wibox.widget.textbox('<span color="#aeaeae">[ </span>')
brar = wibox.widget.textbox('<span color="#aeaeae"> ]</span>')
spr = wibox.widget.textbox(' ')
sepl = wibox.widget.textbox('<span color="#aeaeae" font="Visitor TT2 BRK 10"> tasks: </span>')
sepr = wibox.widget.textbox('<span color="#aeaeae" font="Visitor TT2 BRK 10"> :systray </span>')
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)
yf = wibox.widget.imagebox()              
yf:set_image(beautiful.yf)
yf:buttons(awful.util.table.join(
  awful.button({ }, 1, function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'URxvt'}) 
   end                                                      
   awful.client.run_or_raise(terminal, matcher)
 end)))
bf = wibox.widget.imagebox()
bf:set_image(beautiful.bf)
bf:buttons(awful.util.table.join(
  awful.button({ }, 1, function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'URxvt'}) 
   end                                                      
   awful.client.run_or_raise(terminal, matcher)
 end)
  ))   
gf = wibox.widget.imagebox()
gf:set_image(beautiful.gf)
gf:buttons(awful.util.table.join(awful.button(
  { }, 1, function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'URxvt'}) 
   end                                                      
   awful.client.run_or_raise(terminal, matcher)
 end)
))   


-- Create a textclock widget
mytextclock = awful.widget.textclock("<span font='mintsstrong 7' color='#aeaeae'>| %I%M%p </span>")
 orglendar.files = { home .. "/Documents/Notes/work.org",    -- Specify here all files you want to be parsed, separated by comma.
                     home .. "/Documents/Notes/home.org" }
orglendar.register(mytextclock)
clockicon=wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)

-- Create a wibox for each screen and add it
mywibox = {}
mywibox_w = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag)
                   -- awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    --awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist1 = {'[ mytasklist ]'}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function (c) if c == client.focus then
                                                        mytaskmenu:toggle()
                                                      else
                                                        client.focus = c
                                                        c.minimized = false
                                                        mytaskmenu:toggle()
                                                      end
                                                      end),
                                              --if instance then
                                                  --instance:hide()
                                                  --instance = nil
                                              --else
                                                  --instance = awful.menu.clients({ width=250 })

                                              --end
                                          --end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end)
                     )

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.

    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(1, s, layouts) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1, s, layouts) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox

    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 16, opacity = 1 })
    mywibox_w[s] = awful.wibox({ position = "bottom", screen = s, height = 16, opacity = 1 })


    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(arrl)
    left_layout:add(mylayoutbox[s])
    left_layout:add(spr)
    left_layout:add(mypromptbox[s])
    local left_w = wibox.layout.fixed.horizontal()
    left_w:add(sepl)
    left_w:add(bral)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(bf)
    right_layout:add(gf)
    right_layout:add(yf)
    right_layout:add(spr)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(neticon)
    right_layout:add(netwidget)
    right_layout:add(snetwidget)
    right_layout:add(spr)
    right_layout:add(mygmailimg)
    --right_layout:add(spr)
    right_layout:add(mygmail)
    right_layout:add(spr)
    right_layout:add(spr)
    right_layout:add(mpdicon)
    right_layout:add(musicwidget.widget)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(spr)
    right_layout:add(kbdwidget)
        right_layout:add(spr)
    right_layout:add(tempicon)
    right_layout:add(weatherwidget) 
    right_layout:add(spr)
        right_layout:add(baticon)
    right_layout:add(batwidget)
    --right_layout:add(clockicon)
    right_layout:add(mytextclock)
    local right_w = wibox.layout.fixed.horizontal()
    right_w:add(brar)
    right_w:add(spr)
    right_w:add(face)
    right_w:add(spr)
    right_w:add(bral)
    if s == 1 then right_w:add(wibox.widget.systray()) end
    right_w:add(brar)
    right_w:add(sepr)
    right_w:add(spr)


    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    local layout_w = wibox.layout.align.horizontal()
    layout_w:set_left(left_w)
    layout_w:set_middle(mytasklist[s])
    layout_w:set_right(right_w)

    mywibox[s]:set_widget(layout)
    mywibox_w[s]:set_widget(layout_w)

end
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 1, function () mymainmenu:hide() end, function () mytaskmenu:hide() end),
    awful.button({ }, 3, function () mymainmenu:toggle() end, function () mytaskmenu:hide() end)
))
-- }}}

-- {{{ Key bindings


globalkeys = awful.util.table.join(
        awful.key({ }, "Print", function () awful.util.spawn_with_shell(sc_r) end, function () show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 1.5, nil, nil, nil, nil ) end),
    awful.key({ "Control", }, "Print", function () show_smth( nil, "Taking shot in 5s", iconsdir .. "/clock.svg", nil, nil, nil, nil, nil ) end,
    function () awful.util.spawn_with_shell(sc_r5) end, 
    function () show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 1.5, nil, nil, nil, nil ) end),
    awful.key({ "Shift", }, "Print", function () show_smth(nil, "Choose area", iconsdir .. "/screen-measure.svg", 1.5, nil, nil, nil, nil ) end, 
      function () awful.util.spawn_with_shell(sc_a) end),
    awful.key({ modkey,  }, "Print", function () awful.util.spawn_with_shell(sc_w) end, 
      function() show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 1.5, nil, nil, nil, nil )end),
    awful.key({ alt }, "Tab", function()
             local tag = awful.tag.selected()
             for i=1, #tag:clients() do
                tag:clients()[i].minimized=false end
             awful.client.focus.byidx(1) if client.focus then client.focus:raise() end end),

    --awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    --awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "q",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "e",  awful.tag.viewnext       ),
    awful.key({ "Control",           }, "Escape", function () mymainmenu:toggle() end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

    awful.key({  }, "F8", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    mywibox_w[mouse.screen].visible = not mywibox_w[mouse.screen].visible
    end),

    -- Standard program
    awful.key({ }, "XF86Sleep", function () show_smth(nil, "Z-z-z-z-z-z-z", iconsdir .. "/important.svg", 1, nil, nil, nil, nil) end, function () awful.util.spawn_with_shell("systemctl suspend") end),
    awful.key({            }, "XF86PowerOff",  function () awful.util.spawn_with_shell("zenity --question --text 'Are you sure you want to poweroff?' &&systemctl poweroff") end),
    awful.key({            }, "XF86Launch1",  function () awful.util.spawn_with_shell("zenity --question --text 'Are you sure you want to reboot?' &&systemctl reboot") end),
    awful.key({ "Control",           }, "k", function () awful.util.spawn("kamerka") end),
    awful.key({ "Control", "Shift"        }, "Tab", function () awful.util.spawn("gksudo pcmanfm") end),
    awful.key({ "Control",           }, "Tab", function () awful.util.spawn("pcmanfm") end),
    --awful.key({ "Control",           }, "m", function () awful.util.spawn("sonata") end),
    awful.key({ modkey   }, "Escape", function () awful.util.spawn("xscreensaver-command -activate") end),
    awful.key({ alt }, "F1", function () awful.util.spawn(translate_o_r) end),
    awful.key({ modkey }, "F1", function () awful.util.spawn(translate_r_e) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),

    --backlight control
    awful.key({            }, "XF86MonBrightnessUp",  function () awful.util.spawn_with_shell(bri_up) end),
    awful.key({            }, "XF86MonBrightnessDown",  function () awful.util.spawn_with_shell(bri_down) end),

           -- Volume control
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell(vol_up) end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell(vol_down) end),
    awful.key({modkey}, "Right", function () awful.util.spawn_with_shell(volpa_up) end),
    awful.key({modkey}, "Left", function () awful.util.spawn_with_shell(volpa_down) end),
    awful.key({ modkey }, "m", function () awful.util.spawn_with_shell(volpa_mute) end),
    awful.key({ modkey }, "Control","m", function () awful.util.spawn_with_shell(vol_mute) end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Control"   }, "space", function () awful.layout.inc(layouts, -1) end),

--run or raise clients
     awful.key({ modkey, }, "Return", function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'URxvt'}) 
   end                                                      
   awful.client.run_or_raise(terminal, matcher)
 end),
     awful.key({ "Control" }, "l", function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'subl'}) 
   end                                                      
   awful.client.run_or_raise('subl', matcher)
 end),
     awful.key({ "Control", "Shift" }, "l", function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'subl'}) 
   end                                                      
   awful.client.run_or_raise('gksudo subl', matcher)
 end),
     awful.key({ modkey }, "b", function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'Firefox'}) 
   end                                                      
   awful.client.run_or_raise('firefox', matcher)
 end),

    -- Prompt
    awful.key({ alt,           }, "F2",
              function () awful.prompt.run({prompt="> "},
                                           mypromptbox[mouse.screen].widget,
                                           check_for_terminal,
                                           clean_for_completion,
                                           awful.util.getdir("cache") .. "/history") 
              --arrl.visible = false
              end),
    awful.key({ modkey }, "F2",
              function ()
                  awful.prompt.run({ prompt = ">> " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
) -- end

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "w",      awful.client.floating.toggle),
    awful.key({ alt, }, "F4",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ alt,           }, "Escape", function (c) c.minimized = true end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                              awful.tag.viewonly(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ alt }, 1, awful.mouse.client.resize))
-- Set keys
musicwidget:append_global_keys()
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
            { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
            { rule_any = { class = { "Virt-manager", "Remmina", "VirtualBox" } },
      properties = { tag = tags[1][6] } },
            { rule_any = { class = { "Sonata", "Vlc", "Samowar", "Deadbeef" } },
      properties = { tag = tags[1][5] } },
            { rule_any = { class = { "Doublecmd", "Pcmanfm", "Dolphin", "Nautilus", "Nemo", "Thunar" } },
      properties = { tag = tags[1][1] } },
            { rule_any = { class = { "Pdfeditor", "Libre", "libreoffice-writer", "subl", "Evince",  "Atom" } },
      properties = { tag = tags[1][3] } },
            { rule_any = { class = { "SpiderOak", "Shotcut" ,"Openshot", "DraftSight", "jetbrains-clion" ,"Eclipse", "Qtcreator", "jetbrains-studio"} },
      properties = { tag = tags[1][4] } },
            { rule_any = { class = { "Steam" ,"Wine", "dota_linux" } },
      properties = { tag = tags[1][7] }, },
            { rule_any = { class = { "Firefox", "Vivaldi" } },
      properties = { tag = tags[1][2] }, },
            { rule_any = { class = { "Eiskaltdcpp", "Viber", "TeamSpeak", "Cutegram", "Telegram", "Cheese", "Kamerka", "Pidgin" } },
      properties = { tag = tags[1][8] } },
            { rule_any = { class = { "Zenity", "Doublecmd", "Nitrogen", "Samowar", "Wpa_gui", "Pavucontrol", "Lxappearance", "URxvt", "Pidgin", "Skype" }, },
      properties = { floating = true } },
            { rule_any = { class = { "Polkit-gnome-authentication-agent-1", "SpiderOak", "Doublecmd", "Shotcut", "gimp", "rawstudio", "Cutegram", "Telegram", "Cheese", "Kamerka", "Firefox", "Vivaldi", "Steam" ,"Wine", "Zenity", "Atom", 
            "jetbrains-studio", "subl", "Evince", "Eclipce", "QtCreator", "Libre", "libreoffice-writer", "jetbrains-clion", "Pcmanfm", "Sonata", "Vlc", 
            "Samowar", "Virt-manager", "Eiskaltdcpp", "Deadbeef", "VirtualBox", "Skype" } },
      properties = { switchtotag = true } },
            { rule_any = { class = { "Firefox", "Vivaldi", "Wine", "dota_linux", "gimp", "rawstudio", "Lightworks" } },
      properties = { border_width = 0 } },
            { rule_any = { class = { "Polkit-gnome-authentication-agent-1", "Zenity", "URxvt", "pavucontrol", "Wpa_gui", "Lxappearance", "Skype" } },
      properties = { ontop = true } },
            { rule = { instance = "plugin-container" },
  properties = { floating = true } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

--mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
--mywibox_w[mouse.screen].visible = not mywibox_w[mouse.screen].visible

--{{{ keychains
 keychains.init(globalkeys)
    keychains.add({ modkey }, "i", "IDE: ", iconsdir .. "/lamp.png",{
        e   =   {
            func    =   function()
                awful.util.spawn("eclipse")
            end,
            info    =   "- Eclipse"
        },
        a   =   {
            func    =   function()
                awful.util.spawn("android-studio")
            end,
            info    =   "- Android studio"
        },
        c   =   {
            func    =   function()
                awful.util.spawn("clion-eap")
            end,
            info    =   "- CLion"
        },
        q   =   {
            func    =   function()
                awful.util.spawn("qtcreator")
            end,
            info    =   "- QtCreator"
        },
    })
  keychains.add({ modkey }, "v", "VirtualBox: ", iconsdir .. "/screen-lightblue.png",{
        d   =   {
            func    =   function()
                awful.util.spawn("gksudo modprobe vboxdrv")
            end,
            info    =   "- load vboxdrv"
        },
        v   =   {
            func    =   function()
                awful.util.spawn("virt-manager")
            end,
            info    =   "- open virt-manager"
        },
        m   =   {
            func    =   function()
                awful.util.spawn("virtualbox --startvm makakka_xp")
            end,
            info    =   "- start makakka_xp"
        },
        o   =   {
            func    =   function()
                awful.util.spawn("virtualbox")
            end,
            info    =   "- open virtualbox"
        },
    })
  keychains.add({ modkey }, "s", "Screen record: ", iconsdir .. "/camera-video.png",{
        s   =   {
            func    =   function()
                awful.util.spawn_with_shell("sh " .. scripts .. "/record_screen.sh")
            end,
            info    =   "- Start recording"
        },
        q   =   {
            func    =   function()
                awful.util.spawn_with_shell("pkill ffmpeg")
            end,
            info    =   "- Quit recording"
        },
    })
 keychains.start(3)

-- local oldspawn = awful.util.spawn
-- awful.util.spawn = function (s)
--   oldspawn(s, false)
-- end

client.connect_signal("focus", function(c)
                              c.border_color = beautiful.border_focus
                              c.opacity = 1
                           end)
client.connect_signal("unfocus", function(c)
                                c.border_color = beautiful.border_normal
                                --awful.util.spawn("sudo renice -n 1 -p " .. c.pid)
                                c.opacity = 1
                             end)
-- }}}
