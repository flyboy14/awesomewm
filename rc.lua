-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
awful.remote = require("awful.remote")
my_launcher = require("launcher_my")
my_launcher_n = require("launcher_my_nocommand")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
vicious = require("vicious")
local awesompd = require("awesompd/awesompd_colorarrows")
naughty = require("naughty")
eminent = require("eminent")
xdg_menu = require("archmenu")
local lain      = require("lain")
scratch = require("scratch")

-- {{{ wibox 

markup = lain.util.markup
blue   = beautiful.fg_focus
red    = "#EB8F8F"
green  = "#8FEB8F"

-- }}}

--os.setlocale(os.getenv("LANG"))

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
active_theme = themes .. "/color_arrows"
-- Themes define colours, icons, and wallpapers
beautiful.init(active_theme .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
wireless_name = ""
myinterface = ""
wpaper = beautiful.wallpaper
font_main = "Fixed 14"
terminal = "urxvtc"
browser = "chromium-continuous-bin"
editor = "subl"
editor_cmd = terminal .. " -e " .. editor
musicplr = "mpd " .. home .. "/.mpd/mpd.conf"
sc_a = scripts .. "/screenshot-area.sh"
sc_w = scripts .. "/screenshot-wind.sh"
sc_r = scripts .. "/screenshot-root.sh"
sc_r5 = "sleep 5s && " .. scripts .. "/screenshot-root.sh"
vol_mute = scripts .. "/vol_pa_color.sh mute"
vol_up = scripts .. "/vol_pa_color.sh up"
vol_down = scripts .. "/vol_pa_color.sh down"
bri_up = scripts .. "/bright_color.sh up"
bri_down = scripts .. "/bright_color.sh down"
translate_o_r = scripts .. "/translate_en_ru.sh"
translate_r_e = scripts .. "/translate_ru_en.sh"
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

function run_once(why, what)
  if what == nil then what = why end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. why .. " || (" .. what .. ")")
end
function run_when(why, what)
  if what == nil then what = why end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. why .. " && (" .. what .. ")")
end

autorun = true
autorunApps =
{
   home .. "/.config/autostart/autostart.sh",
   run_once("urxvtd", "urxvtd -o -f -q"),
   run_once("pcmanfm", "pcmanfm -d"),
   run_once("kbdd"),
   --run_once("pidgin"),
   "systemctl --user restart hidcur",
   run_once("compton", "compton -b --sw-opti --shadow-blue 0.05 --sw-opti --inactive-dim 0.25 -cfGz -r 4 -t -6 -l -6 -D 5 -I 0.03 -O 0.03 --xrender-sync --respect-prop-shadow"),
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
      command = terminal .. ' -e "' .. command:sub(2) .. '"'
   end
   awful.util.spawn(command)
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
--local f = io.popen("cat " .. home .. "/.config/nitrogen/bg-saved.cfg | grep file | sed 's/'file='//g'") 
--local wpaper = f:read()
--f:close()  
--if wpaper == nil then
if beautiful.wallpaper then
for s = 1, screen.count() do
  gears.wallpaper.maximized(wpaper, s, false)
  --gears.wallpaper.maximized(wpaper,s,true)
end
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
 theme.taglist_font                  = font_main
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

myvirtualmenu = {
  { " vboxdrv", "gksu modprobe vboxdrv" },
  { " makakka_xp", "virtualbox --startvm makakka_xp" },
  { " Debian 8", "virtualbox --startvm debian8" },
  { " CentOS 7", "virtualbox --startvm centos7" }
}

myworkspacemenu = {
    { "Home", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[1] 
        if tag then 
          awful.client.movetotag(tag) awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
    { "Browse", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[2] 
        if tag then 
          awful.client.movetotag(tag) awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
    { "Doc", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[3] 
        if tag then 
          awful.client.movetotag(tag) awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
    { "IDE", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[4] 
        if tag then 
          awful.client.movetotag(tag) awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
    { "Media", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[5] 
        if tag then 
          awful.client.movetotag(tag) awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
    { "Virtual", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[6] 
        if tag then 
          awful.client.movetotag(tag) awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
    { "Wine", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[7] 
        if tag then 
          awful.client.movetotag(tag) awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
    { "Etc", 
    function () 
      if client.focus then 
        local tag = awful.tag.gettags(client.focus.screen)[8] 
        if tag then 
          awful.client.movetotag(tag) 
          awful.tag.viewonly(tag) 
        end 
      end 
    end 
    },
}
mytaskmenu = awful.menu({ items = {
                                    { "Отправить на тэг:", myworkspacemenu },
                                    { "  На весь экран", 
                                      function () 
                                        client.focus.fullscreen = not client.focus.fullscreen 
                                      end, 
                                      iconsdir .. "/display.svg" 
                                    },
                                    { "  Свернуть", 
                                      function () 
                                        client.focus.minimized = true 
                                        if client.focus then 
                                          mouse.coords({x=client.focus:geometry()['x']+client.focus:geometry()['width']/3, y=client.focus:geometry()['y']+client.focus:geometry()['height']/2}) 
                                        end 
                                      end,  
                                      iconsdir .. "/view-restore.svg"
                                    },
                                    { "  Закрыть", 
                                      function() 
                                        client.focus:kill() 
                                      end, iconsdir .. "/media-no.svg" 
                                    },
                                  }
})

mymainmenu = awful.menu({ items = {
                                    --{ "  Samowar (beta)", "samowar", iconsdir .. "/musical-note-stripped.svg" },
                                    --{ "  KeePassX", "keepassx", iconsdir .. "/keepassx.svg"},
                                    --{ "  DoubleCommander", "doublecmd", iconsdir .. "/doublecmd.svg"},
                                    --{ "  Файлообменник", "wine " .. home.. "/WINE/wineZ/drive_c/fayloobmennik.net.exe", iconsdir .. "/mailbox.svg" },
                                    { "Песочница", myvirtualmenu },
                                    { "Приложения", xdgmenu },
                                    --{ "Игры", mygamesmenu },
                                    { "  Обои", "nitrogen", iconsdir .. "/greylink-dc.png" }
                                  }
})

mylauncher = awful.widget.launcher({ image = iconsdir .. "/tv_icon.gif",
  	menu = mymainmenu})
-- Memory widget
memwidget = wibox.widget.textbox()
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
vicious.register(memwidget, vicious.widgets.mem, "<span font='Fixed 14' background='#EA9B84'> <span font='Visitor TT2 BRK 10' color='#4C3D3D' rise='1600'>$2MB/$3MB </span></span>", 3)

--awesompd

musicwidget = awesompd:create() -- Create awesompd widget
musicwidget.font = "Fixed 8"
musicwidget.font_color = "#DBCFE0"
 musicwidget.scrolling = false -- If true, the text in the widget will be scrolled
 musicwidget.output_size = 20 -- Set the size of widget in symbols
 musicwidget.update_interval = 1 -- Set the update interval in seconds
 musicwidget.path_to_icons = confdir .. "/awesompd/icons"
 musicwidget.jamendo_format = awesompd.FORMAT_MP3
 musicwidget.show_album_cover = true
 musicwidget.album_cover_size = 50
 musicwidget.mpd_config = home .. "/.mpd/mpd.conf"
 musicwidget.browser = browser

 musicwidget.ldecorator = "<span background='#4B3B51' font='Fixed 14'> <span font='Fixed 8' rise='1600'>"
 musicwidget.rdecorator = " </span></span>"
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

-- Music widget
mpdwidget = wibox.widget.textbox()
mpdicon = wibox.widget.imagebox()
mpdicon:set_image(beautiful.widget_music)
mpdicon:buttons(awful.util.table.join(
  awful.button({ }, 1, 
    function ()
      scratch.drop("urxvtc -e vimpc", "center", "center", .95, .95, "true", 1)
    --run_when_once("mpd", "vimpc","urxvtc -geometry 150x25 -e vimpc") 
    end, 
    function () awful.util.spawn_with_shell("mpd " .. home .. "/.mpd/mpd.conf") 
    end
  ),
  awful.button({ }, 2, function () awful.util.spawn_with_shell("urxvtc -geometry 150x40 -e vimpc") end),
  awful.button({ }, 3, function () awful.util.spawn_with_shell("pkill mpd") end),
  awful.button({ }, 4, function () awful.util.spawn_with_shell("mpc volume +5") end),
  awful.button({ }, 5, function () awful.util.spawn_with_shell("mpc volume -5") end)
))

vicious.register(mpdwidget, vicious.widgets.mpd,
function(widget, args)
  -- play
  if (args["{state}"] == "Play") then
    mpdicon:set_image(beautiful.widget_music_on)
    return ""
  -- pause
  elseif (args["{state}"] == "Pause" or args["{state}"] == "Stop") then
    mpdicon:set_image(beautiful.widget_music)
    return ""
  else
    mpdicon:set_image(beautiful.widget_music)
    return ""
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
    return '<span background="#6F766E" font="Fixed 14"> <span font="Visitor TT2 BRK 10"color="#46A8C3" rise="1600">AC</span></span>'
    -- critical
  elseif (args[2] <= 7 and batstate() == 'Discharging') then
    baticon:set_image(beautiful.widget_battery_empty)
    awful.util.spawn("systemctl suspend")
  elseif (batstate() == 'Discharging' and args[2] <= 10) then
        show_smth("⚡ Внимание! ⚡", "Очень  мало энергии", iconsdir .. "/battery-red.svg", 1, "#6F766E", "#474C3B", nil, nil )
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
    return '<span background="#6F766E" color="#8E1212" font="Fixed 14"> <span rise="1200" font="Clean 9">↓ <span font="Visitor TT2 BRK 10" rise="1600">' .. args[3] .. '<span color="#CEDCCC">p' .. args[2] ..' </span></span></span></span>'
   elseif (batstate() == 'Charging' and args[2] ~= 100) then
    return '<span background="#6F766E" font="Fixed 14" color="#AAD05B"> <span font="Clean 9" rise="1200">↑ <span font="Visitor TT2 BRK 10" rise="1600">' .. args[3] .. '<span color="#CEDCCC">p' .. args[2] ..' </span></span></span></span>'
   else 
    return '<span background="#6F766E" font="Fixed 14" color="#6CC0C0"> <span rise="1200" font="Clean 9">⚡ <span font="Visitor TT2 BRK 10" rise="1600">full<span color="#CEDCCC">p' .. args[2] ..' </span></span></span></span>' end
end, 1, 'BAT0')
-- Keyboard layout widget
kbdwidget = wibox.widget.textbox()
kbdcolb = "<span font='Fixed 14' background='#92B0A0'> <span rise='1600' font='Visitor TT2 BRK 10' color='#3D4C40'>"
kbdcole = "</span></span>"
kbdwidget.border_width = 0
kbdwidget.border_color = beautiful.fg_normal
kbdwidget:set_markup(kbdcolb .. "en-us " .. kbdcole)
dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
    local data = {...}
    local layout = data[2]
    lts = {[0] = "en-us ", [1] = "ru-ru "}
    kbdwidget:set_markup (kbdcolb..""..lts[layout]..""..kbdcole)
    end
)

-- Mail widget
 mygmailimg = wibox.widget.imagebox(beautiful.widget_mail)
 mygmailimg:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(browser .. " gmail.com") end)))

-- CPU widget
 cpuicon = wibox.widget.imagebox()
 cpuicon:set_image(beautiful.widget_cpu)
 cpuwidget = wibox.widget.textbox()
 vicious.register(cpuwidget, vicious.widgets.cpu, '<span background="#84D0D0" font="Fixed 14"> <span rise="1600" font="Visitor TT2 BRK 10" color="#005656">CPU <span color="#393E4A">$1<span font="Visitor TT2 BRK 10">%</span> </span></span></span>', 3)

-- Weather widget

myweather = lain.widgets.weather_colorarrows({
    city_id = 625144, -- placeholder
    lang = "ru",
    settings = function()
        local descr = weather_now["weather"][1]["description"]:lower()
        local units = math.floor(weather_now["main"]["temp"])
        local unitscolor = "#aeaeae"
        if units <= 0 then unitscolor = "#69E0CC"
        elseif units <= 17 then unitscolor = "#E4E876"
        elseif units <= 30 then unitscolor = "#E09620"
        elseif units > 30 then unitscolor = "#E05721" units = "fuck, it\'s " .. units end
        widget:set_markup(markup(unitscolor, "<span font='Fixed 14' background='#C2C2A4'> <span rise='1600' font='Clean 9'><span color='#5e5e5e'>" .. descr .. "</span> <span font='Visitor TT2 BRK 10'>" .. units .. "°C </span></span></span>"))
    end
})
  weathericon = my_launcher_n({
    image = beautiful.widget_weather,
    command = myweather.update
  })
-- Volume widget
volicon = my_launcher({
  image = beautiful.widget_vol_hi,
  command = vol_mute
})
volumewidget = wibox.widget.textbox()
volumewidget:buttons(awful.util.table.join(
  awful.button({ }, 4, function () awful.util.spawn_with_shell(vol_up) end),
  awful.button({ }, 5, function () awful.util.spawn_with_shell(vol_down) end),
  awful.button({ }, 1, function () awful.util.spawn("pavucontrol") end )
  ))
vicious.register(
  volumewidget, 
  vicious.widgets.volume,
  function (widget, args)
    if (args[2] ~= "♩" ) then
      if (args[1] == 0) then 
        volicon:set_image(beautiful.widget_vol_no)
      elseif (args[1] <= 35) then  
        volicon:set_image(beautiful.widget_vol_low)
      elseif (args[1] <= 70) then  
        volicon:set_image(beautiful.widget_vol_med)
      else 
        volicon:set_image(beautiful.widget_vol_hi)
      end

    else 
      volicon:set_image(beautiful.widget_vol_mute)
    return '<span background="#E2AE7C" font="Fixed 14"> <span rise="1600" font="Visitor TT2 BRK 10" color="#444444">p' .. args[1] .. '<span color="#e54c62">m </span></span></span>'
    --return '<span font="Visitor TT2 BRK 10" color="#e54c62">muted<span font="Visitor TT2 BRK 10" color="#aeaeae">'.. args[3] ..'</span><span color="#aeaeae">%</span></span>'
    end
    return '<span background="#E2AE7C" font="Fixed 14"> <span rise="1600" font="Visitor TT2 BRK 10" color="#444444">p' .. args[1] .. ' </span></span>'
      --return '<span font="Visitor TT2 BRK 10" color="#aeaeae">' .. args[3] ..'<span font="Visitor TT2 BRK 10">%</span></span>'
  end, 
  1, 
  "Master"
)

-- Net widget

netwidget = wibox.widget.textbox()
neticon = my_launcher({ image = beautiful.widget_net_no, command = "systemctl restart systemd-networkd wpa_supplicant@wlp3s0" })
netwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, 
    function ()      
      scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1)
    end
  ),

  awful.button({ }, 3, 
    function () 
      awful.util.spawn_with_shell("pkill wpa_gui") 
    end
  )
))


netdowninfo = wibox.widget.textbox()
netdowninfo:buttons(awful.util.table.join(
  awful.button({ }, 1, 
    function ()      
      scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1)
    end
  ),
  awful.button({ }, 3, 
    function () 
      awful.util.spawn_with_shell("pkill wpa_gui") 
    end
  )
))

netupinfo = lain.widgets.net({
  settings = 
  function()
    myinterface = iface
    -- if iface ~= "network off" and string.match(myweather._layout.text, "N/A") then
    --   myweather.update()
    --   netwidget.update()
    -- end
      
    widget:set_markup(markup("#7ac82e", '<span font="Fixed 14" background="#6F766E"> <span rise="1600" font="Visitor TT2 BRK 10">' .. net_now.received .. '</span></span>'))
    netdowninfo:set_markup(markup("#46A8C3", '<span font="Fixed 14" background="#6F766E"> <span rise="1600" font="Visitor TT2 BRK 10">' .. net_now.sent .. ' </span></span>'))
  end
})

netupinfo:buttons(awful.util.table.join(
  awful.button({ }, 1, 
    function ()      
      scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1)
    end
  ),
  awful.button({ }, 3, 
    function () 
      awful.util.spawn_with_shell("pkill wpa_gui") 
    end
  )
))

vicious.register(
  netwidget, 
  vicious.widgets.wifi, 
  function (widget, args)
    link = args['{link}']
    if myinterface:find("enp") then  -- wired interfaces
      neticon:set_image(beautiful.widget_net_wired)
    elseif myinterface:find("wl") then
      -- naughty.notify({text = link})
      -- if link > 65 then
         neticon:set_image(beautiful.widget_net_hi)
      -- elseif link > 30 and link <= 65 then
      --   neticon:set_image(beautiful.widget_net_mid)
      -- elseif link > 0 and link <= 30 then
      --   neticon:set_image(beautiful.widget_net_low)
      -- end
    else
        neticon:set_image(beautiful.widget_net_no)
    end
    wireless_name = args['{ssid}']
    return '<span font="Fixed 14" background="#6F766E"> <span rise="1600" font="Clean 8" color="#aeaeae">' .. wireless_name .. '</span></span>'
  end,
  2, 
  myinterface
)
-- Separators
face = wibox.widget.textbox('<span color="#e54c62" font="Visitor TT2 BRK 10">//\\(o.o_)/\\\\</span>')
face:buttons(awful.util.table.join(
awful.button({ }, 3, function () awful.util.spawn_with_shell(scripts .. "/change_config.sh") end, awesome.restart),
awful.button({ }, 1, function(c)
  local f = io.popen("fortune -s") 
  local quote = f:read("*all") 
  f:close()
  show_smth("Wisdom spider", quote, nil, 0, nil, nil, "Clean 9", "bottom_right") 
  end)
))
face:connect_signal("mouse::enter", function(c)
  local f = io.popen("fortune -s") 
  local quote = f:read("*all") 
  f:close()
  show_smth("Wisdom spider :", quote, nil, 0, nil, nil, "Clean 9", "bottom_right") end)
face:connect_signal("mouse::leave", function(c)
hide_smth()
end)


bral = wibox.widget.textbox('<span color="#949494">[ </span>')
brar = wibox.widget.textbox('<span color="#949494"> ]</span>')
spr = wibox.widget.textbox(' ')
arrows = wibox.widget.textbox('<span font="Fixed 14" background="#6F766E"> <span font="Clean 9" color="#aeaeae">' .. '↓↑' .. '</span></span>')
arrows:buttons(awful.util.table.join(
  awful.button({ }, 1, 
    function ()      
      scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1)
    end
  ),
  awful.button({ }, 3, 
    function () 
      awful.util.spawn_with_shell("pkill wpa_gui") 
    end
  )
))
sepl = wibox.widget.textbox('<span color="#949494" font="Visitor TT2 BRK 10"> tasks > </span>')
sepr = wibox.widget.textbox('<span color="#949494" font="Visitor TT2 BRK 10"> > systray </span>')
arrl_dl_vol = wibox.widget.imagebox()
arrl_ld_vol = wibox.widget.imagebox()
arrl_ld_vol:set_image(beautiful.arrl_ld_vol)
arrl_dl_vol:set_image(beautiful.arrl_dl_vol)
arrl_dl_lang = wibox.widget.imagebox()
arrl_dl_lang:set_image(beautiful.arrl_dl_lang)
arrl_ld_cpu = wibox.widget.imagebox()
arrl_ld_cpu:set_image(beautiful.arrl_ld_cpu)
arrl_dl_mail = wibox.widget.imagebox()
arrl_dl_mail:set_image(beautiful.arrl_dl_mail)
arrl_ld_mail = wibox.widget.imagebox()
arrl_ld_mail:set_image(beautiful.arrl_ld_mail)
arrl_dl_bat = wibox.widget.imagebox()
arrl_dl_bat:set_image(beautiful.arrl_dl_bat)
arrl_dl_net = wibox.widget.imagebox()
arrl_dl_net:set_image(beautiful.arrl_dl_net)
arrl_dl_temp = wibox.widget.imagebox()
arrl_dl_temp:set_image(beautiful.arrl_dl_temp)
arrl_dl_clock = wibox.widget.imagebox()
arrl_dl_clock:set_image(beautiful.arrl_dl_clock)
arrl_ld_mem = wibox.widget.imagebox()
arrl_ld_mem:set_image(beautiful.arrl_ld_mem)
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

clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)
 mytextclock = awful.widget.textclock("<span font='Fixed 14' background='#444444'> <span rise='1600' font='Visitor TT2 BRK 10' color='#aeaeae'>%I%M%p </span></span>")

-- Calendar
lain.widgets.calendar_colorarrows:attach(mytextclock, { font_size = 9 })
lain.widgets.calendar_colorarrows:attach(clockicon, { font_size = 9 })

-- Create a wibox for each screen and add it
mywibox = { }
mywibox_w = { }
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag)
                    )
mytasklist = {}
mytasklist1 = {'[ mytasklist ]'}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                                  mytaskmenu:hide()
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
                                                  mytaskmenu:hide()
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
    left_layout:add(mypromptbox[s])
    local left_w = wibox.layout.fixed.horizontal()
    left_w:add(sepl)
    --left_w:add(bral)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(bf)
    right_layout:add(gf)
    right_layout:add(yf)
    right_layout:add(spr)
    right_layout:add(arrl_ld_mem)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(arrl_ld_mail)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(arrl_dl_mail)
    right_layout:add(neticon)
    right_layout:add(netwidget)
   right_layout:add(netupinfo)
   right_layout:add(arrows)
   right_layout:add(netdowninfo)
    --right_layout:add(snetwidget)
    right_layout:add(arrl_ld_cpu)
    right_layout:add(mygmailimg)
    --right_layout:add(mygmail)
    right_layout:add(arrl_ld_vol)
    right_layout:add(mpdicon)
    right_layout:add(musicwidget.widget)
    right_layout:add(arrl_dl_vol)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(arrl_dl_lang)
    right_layout:add(kbdwidget)
    right_layout:add(arrl_dl_bat)
    right_layout:add(weathericon)
    right_layout:add(myweather)
    right_layout:add(arrl_dl_net)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(arrl_dl_temp)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)
    right_layout:add(arrl_dl_clock)
    right_layout:add(spr)
    right_layout:add(mylayoutbox[s])
    local right_w = wibox.layout.fixed.horizontal()
    --right_w:add(brar)
    right_w:add(spr)
    right_w:add(face)
    right_w:add(spr)
    --right_w:add(bral)
    if s == 1 then right_w:add(wibox.widget.systray()) end
    --right_w:add(brar)
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
    awful.key({            }, "Print", function () awful.util.spawn_with_shell(sc_r) end),
    awful.key({ "Control", }, "Print", function () show_smth( nil, "Taking shot in 5s", iconsdir .. "/clock.svg", nil, nil, nil, nil, nil ) end,
    function () awful.util.spawn_with_shell(sc_r5) end), 
    awful.key({ "Shift", }, "Print", function () show_smth(nil, "Choose area", iconsdir .. "/screen-measure.svg", 2, nil, nil, nil, nil ) end, 
      function () awful.util.spawn_with_shell(sc_a) end),
    awful.key({ modkey,  }, "Print", function () awful.util.spawn_with_shell(sc_w) end),
 awful.key({ modkey }, "Tab", 
    function()
      local tag = awful.tag.selected()
      for i=1, #tag:clients() do
        tag:clients()[i].minimized=false 
      end
      awful.client.focus.byidx(1) 
      if client.focus then 
        client.focus:raise() 
        mouse.coords({x=client.focus:geometry()['x']+client.focus:geometry()['width']/2, y=client.focus:geometry()['y']+client.focus:geometry()['height']/2}) 
      end 
    end
  ),
  awful.key({ alt }, "Tab", 
    function()
      local tag = awful.tag.selected()
      awful.client.focus.byidx(1) 
      if client.focus then 
        client.focus:raise() 
        mouse.coords({x=client.focus:geometry()['x']+client.focus:geometry()['width']/2, y=client.focus:geometry()['y']+client.focus:geometry()['height']/2}) 
      end 
    end
  ),
      awful.key({ modkey,           }, "q",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "e",  awful.tag.viewnext       ),
    awful.key({ "Control",           }, "Escape", function () mymainmenu:toggle() end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise()
            mouse.coords({x=client.focus:geometry()['x']+client.focus:geometry()['width']/2, y=client.focus:geometry()['y']+client.focus:geometry()['height']/2}) end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() 
            mouse.coords({x=client.focus:geometry()['x']+client.focus:geometry()['width']/2, y=client.focus:geometry()['y']+client.focus:geometry()['height']/2}) end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

    awful.key({ "Control" }, "F8", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    mywibox_w[mouse.screen].visible = not mywibox_w[mouse.screen].visible
    end),

    -- Standard program
    awful.key({      modkey      }, "v", function () scratch.drop("urxvtc -e vimpc", "center", "center", .95, .95, "true", 1) end),
    awful.key({      modkey      }, "i", function () scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1) end),
    awful.key({ }, "XF86Sleep", function () show_smth(nil, "Z-z-z-z-z-z-z", iconsdir .. "/important.svg", 1, nil, nil, nil, nil) end, function () awful.util.spawn_with_shell("systemctl suspend") end),
    awful.key({            }, "XF86PowerOff",  function () awful.util.spawn_with_shell("zenity --question --text 'Are you sure you want to poweroff?' &&systemctl poweroff") end),
    awful.key({            }, "XF86Launch1",  function () awful.util.spawn_with_shell("zenity --question --text 'Are you sure you want to reboot?' &&systemctl reboot") end),
    awful.key({ "Control", "Shift"        }, "Tab", function () awful.util.spawn("gksudo pcmanfm") end),
    awful.key({ "Control",           }, "Tab", function () awful.util.spawn("pcmanfm") end),
    awful.key({ "Control",           }, "m", function () awful.util.spawn("sonata") end),
    awful.key({ alt }, "F1", function () awful.util.spawn(translate_o_r) end),
    awful.key({ modkey }, "F1", function () awful.util.spawn(translate_r_e) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),

    --backlight control
    awful.key({            }, "XF86MonBrightnessUp",  function () awful.util.spawn_with_shell(bri_up) end),
    awful.key({            }, "XF86MonBrightnessDown",  function () awful.util.spawn_with_shell(bri_down) end),

           -- Volume control
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell(vol_up) end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell(vol_down) end),
    awful.key({modkey}, "Right", function () awful.util.spawn_with_shell(vol_up) end),
    awful.key({modkey}, "Left", function () awful.util.spawn_with_shell(vol_down) end),
    awful.key({ modkey }, "m", function () awful.util.spawn_with_shell(vol_mute) end),
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
     return awful.rules.match(c, {class = editor }) 
   end                                                      
   awful.client.run_or_raise(editor, matcher)
 end),
     awful.key({ "Control", "Shift" }, "l", function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = editor }) 
   end                                                      
   awful.client.run_or_raise('gksudo ' .. editor, matcher)
 end),
     awful.key({ modkey }, "b", function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'Firefox'}) 
   end                                                      
   awful.client.run_or_raise('firefox', matcher)
 end),
    -- Prompt
    awful.key({ alt,           }, "F2",
              function () awful.prompt.run({ prompt=">_ " },
                                           mypromptbox[mouse.screen].widget,
                                           check_for_terminal,
                                           clean_for_completion,
                                           awful.util.getdir("cache") .. "/history") end),
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
    awful.key({ alt, }, "F4",      function (c) c:kill() end),
    awful.key({ modkey, }, "w",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
  awful.key({ alt,              }, "Escape", function (c) c.minimized = true end),
  awful.key({ modkey,           }, "Escape", function (c) c.minimized = true end)
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
                     buttons = clientbuttons,
                     size_hints_honor = false } },
            { rule_any = { class = { "Virt-manager", "Remmina", "VirtualBox" } },
      properties = { tag = tags[1][6] } },
            { rule_any = { class = { "Sonata", "Vlc", "Samowar", "Deadbeef" } },
      properties = { tag = tags[1][5] } },
            { rule_any = { class = { "Doublecmd", "Pcmanfm", "Dolphin", "Nautilus", "Nemo", "Thunar" } },
      properties = { tag = tags[1][1] } },
            { rule_any = { class = { "Gvim", "Pdfeditor", "Libre", "libreoffice-writer", "subl", "Atril",  "Atom" } },
      properties = { tag = tags[1][3] } },
            { rule_any = { class = { "SpiderOak", "Shotcut" ,"Openshot", "DraftSight", "jetbrains-clion" ,"Eclipse", "Qtcreator", "jetbrains-studio", "draftsight"} },
      properties = { tag = tags[1][4] } },
            { rule_any = { class = { "Steam" ,".exe", "dota_linux" } },
      properties = { tag = tags[1][7] }, },
            { rule_any = { class = { "Firefox", "Vivaldi" } },
      properties = { tag = tags[1][2] }, },
            { rule_any = { class = { "Eiskaltdcpp", "Viber", "TeamSpeak", "Cutegram", "Telegram", "Cheese", "Kamerka", "Pidgin" } },
      properties = { tag = tags[1][8] } },
            { rule_any = { class = { "Zenity", "Doublecmd", "Nitrogen", "Samowar", "Wpa_gui", "Pavucontrol", "Lxappearance", "URxvt", "Pidgin", "Skype" }, },
      properties = { floating = true } },
            { rule_any = { class = { "SpiderOak", "Doublecmd", "Shotcut", "gimp", "rawstudio", "Cutegram", "Telegram", "Cheese", "Kamerka", "Firefox", "Vivaldi", "Steam" ,"Wine", "Zenity", "Atom", "jetbrains-studio", "subl", "Atril", "Eclipse", "QtCreator", "Libre", "libreoffice-writer", "jetbrains-clion", "Pcmanfm", "Sonata", "Vlc", 
            "Samowar", "Virt-manager", "Eiskaltdcpp", "Deadbeef", "VirtualBox", "Skype" } },
      properties = { switchtotag = true } },
            { rule_any = { class = { "Firefox", "Vivaldi", "Wine", "dota_linux", "gimp", "rawstudio", "Lightworks" } },
      properties = { border_width = 0 } },
            { rule_any = { class = { "Zenity", "URxvt", "pavucontrol", "Wpa_gui", "Lxappearance", "Skype" } },
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
            awful.placement.under_mouse(c)
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

-- {{{ keychains

-- local oldspawn = awful.util.spawn
-- awful.util.spawn = function (s)
--   oldspawn(s, false)
-- end

function under_pointer()
    local obj = mouse.object_under_pointer()
    if type(obj) == "client" then
        return obj
    end
end

client.connect_signal("focus", function(c)
                                c.border_color = beautiful.border_focus
                           end)
client.connect_signal("unfocus", function(c)
                                c.border_color = beautiful.border_normal
                             end)

client.connect_signal("unmanage", function(c)
                                if(not client.focus) then mouse.coords({x=683, y=384}) end 
                             end)

client.connect_signal("manage", function(c)
                                if(mouse.object_under_pointer() == client.focus) then return
                                  else mouse.coords({x=c:geometry()['x']+c:geometry()['width']/2, y=c:geometry()['y']+c:geometry()['height']/2}) end
end)
-- }}}
