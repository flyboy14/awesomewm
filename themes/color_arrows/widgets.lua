-- Memory widget
memwidget = wibox.widget.textbox()
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
vicious.register(memwidget, vicious.widgets.mem, "<span font='Fixed 14' background='" .. memcolor_back .. "'> <span font='Visitor TT2 BRK 10' color='#4C3D3D' rise='1600'>$2MB/$3MB </span></span>", 3)

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

musicwidget.ldecorator = "<span background='" .. mpdcolor_back .. "' font='Fixed 14'> <span font='Fixed 8' rise='1600'>"
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
      --awful.util.spawn("sonata")
      --scratch.drop("terminology -e vimpc", "center", "center", .95, .95, "true", 1)
    --run_when_once("mpd", "vimpc","terminology -geometry 150x25 -e vimpc") 
    end, 
    function () awful.util.spawn_with_shell("mpd " .. home .. "/.mpd/mpd.conf") 
    end
  ),
  awful.button({ }, 2, function () awful.util.spawn_with_shell("terminology -geometry 150x40 -e vimpc") end),
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
    return '<span background="' .. batterycolor_back .. '" font="Fixed 14"> <span font="Visitor TT2 BRK 10"color="' .. bluecolor .. '" rise="1600">AC</span></span>'
    -- critical
  elseif (args[2] <= 7 and batstate() == 'Discharging') then
    baticon:set_image(beautiful.widget_battery_empty)
    awful.util.spawn("systemctl suspend")
  elseif (batstate() == 'Discharging' and args[2] <= 10) then
        show_smth("⚡ Внимание! ⚡", "Очень  мало энергии", iconsdir .. "/battery-red.svg", 1, batterycolor_back, "#474C3B", nil, nil )
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
    return '<span background="' .. batterycolor_back .. '" color="#8E1212" font="Fixed 14"> <span rise="1200" font="Clean 9">↓ <span font="Visitor TT2 BRK 10" rise="1600">' .. args[3] .. '<span color="' .. batterycolor_front .. '">p' .. args[2] ..' </span></span></span></span>'
   elseif (batstate() == 'Charging' and args[2] ~= 100) then
    return '<span background="' .. batterycolor_back .. '" font="Fixed 14" color="#AAD05B"> <span font="Clean 9" rise="1200">↑ <span font="Visitor TT2 BRK 10" rise="1600">' .. args[3] .. '<span color="' .. batterycolor_front .. '">p' .. args[2] ..' </span></span></span></span>'
   else 
    return '<span background="' .. batterycolor_back .. '" font="Fixed 14" color="#6CC0C0"> <span rise="1200" font="Clean 9">⚡ <span font="Visitor TT2 BRK 10" rise="1600">full<span color="' .. batterycolor_front ..'">p' .. args[2] ..' </span></span></span></span>' end
end, 1, 'BAT0')

-- {{{ Keyboard layout widgets

-- {{{ Variable definitions
kbd_dbus_sw_cmd = "qdbus ru.gentoo.KbddService /ru/gentoo/KbddService  ru.gentoo.kbdd.set_layout "
-- kbd_dbus_sw_cmd = "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.set_layout uint32:"
kbd_dbus_prev_cmd = "qdbus ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.prev_layout"
-- kbd_dbus_prev_cmd = "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.prev_layout"
kbd_dbus_next_cmd = "qdbus ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout"
-- kbd_dbus_next_cmd = "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout"
kbd_img_path = "/usr/share/icons/kbflags/"
-- }}}

--- Create the menu
kbdmenu = awful.menu({ items = {  
  { "English", kbd_dbus_sw_cmd .. "0" },
  { "Русский", kbd_dbus_sw_cmd .. "1" }
  }, theme = { width = 100, bg_normal=keyboardcolor_back, bg_focus=keyboardcolor_back, fg_normal=keyboardcolor_front, fg_focus="#D8F8E7" }
})

-- Create simple text widget
kbdwidget = wibox.widget.textbox()
-- kbdwidget.border_width = 1
-- kbdwidget.border_color = beautiful.fg_normal
kbdwidget.align="center"
kbdwidget:set_markup("<span font='Fixed 14' background='" .. keyboardcolor_back .. "'> <span rise='1600' font='Visitor TT2 BRK 10' color='" .. keyboardcolor_front .. "'>en-us </span></span>")
--kbdwidget.bg_image = image (kbd_img_path .. "us.png")
kbdwidget.bg_align = "center"
--kbdwidget.bg_resize = true
--awful.widget.layout.margins[kbdwidget] = { left = 0, right = 10 }
kbdwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function() os.execute(kbd_dbus_prev_cmd) end),
  awful.button({ }, 2, function() os.execute(kbd_dbus_next_cmd) end),
  awful.button({ }, 3, function() kbdmenu:toggle () end)
))
-- }}}

-- {{{ Signals
dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
  local data = {...}
  local layout = data[2]
  lts = {[0] = "en-us", [1] = "ru-ru"}
  --lts_img = {[0] = kbd_img_path .. "us.png", [1] = kbd_img_path .. "ru.png", [2] = kbd_img_path .. "il.png", [3] = kbd_img_path .. "de.png" }
  kbdwidget:set_markup("<span font='Fixed 14' background='" .. keyboardcolor_back .. "'> <span rise='1600' font='Visitor TT2 BRK 10' color='" .. keyboardcolor_front .. "'>"..lts[layout].." </span></span>")
  --kbdwidget.bg_image = image(lts_img[layout])
  end)




-- kbdwidget = wibox.widget.textbox()
-- kbdcolb = "<span font='Fixed 14' background='" .. keyboardcolor_back .. "'> <span rise='1600' font='Visitor TT2 BRK 10' color='" .. keyboardcolor_front .. "'>"
-- kbdcole = "</span></span>"
-- kbdwidget.border_width = 0
-- kbdwidget.border_color = beautiful.fg_normal
-- kbdwidget:set_markup(kbdcolb .. "en-us " .. kbdcole)
-- dbus.request_name("session", "ru.gentoo.kbdd")
-- dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
-- dbus.connect_signal("ru.gentoo.kbdd", function(...)
--     local data = {...}
--     local layout = data[2]
--     lts = {[0] = "en-us ", [1] = "ru-ru "}
--     kbdwidget:set_markup (kbdcolb..""..lts[layout]..""..kbdcole)
--     end
-- )

-- Mail widget
 mygmailimg = my_launcher({
   image = beautiful.widget_mail,
   command = browser .. " mail.google.com/mail/u/1/h mail.google.com/mail/u/0/h"
 })
 -- mygmailimg = wibox.widget.imagebox(beautiful.widget_mail)
 -- mygmailimg:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(browser .. " gmail.com") end)))

-- CPU widget
 cpuicon = wibox.widget.imagebox()
 cpuicon:set_image(beautiful.widget_cpu)
 cpuwidget = wibox.widget.textbox()
 vicious.register(cpuwidget, vicious.widgets.cpu, '<span background="' .. cpucolor_back .. '" font="Fixed 14"> <span rise="1600" font="Visitor TT2 BRK 10" color="#005656">CPU <span color="' .. cpucolor_front .. '">$1<span font="Visitor TT2 BRK 10">%</span> </span></span></span>', 3)

-- Weather widget

myweather = lain.widgets.weather_colorarrows({
    city_id = 625144, -- placeholder
    lang = "ru",
    settings = function()
        local descr = weather_now["weather"][1]["description"]:lower()
        local units = math.floor(weather_now["main"]["temp"])
        local unitscolor = "#aeaeae"
        if units <= 0 then 
          unitscolor = "#69E0CC"
        elseif 
          units <= 17 then unitscolor = "#E4E876"
        elseif 
          units <= 30 then unitscolor = "#E09620"
        elseif 
          units > 30 then unitscolor = "#E05721" units = "fuck, it\'s " .. units 
        end
        widget:set_markup(markup(unitscolor, "<span font='Fixed 14' background='" .. weathercolor_back .. "'> <span rise='1600' font='Clean 9'><span color='" .. weathercolor_front .. "'>" .. descr .. " <span font='Visitor TT2 BRK 10'>" .. units .. "°C </span></span></span></span>"))
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
    return '<span background="' .. volumecolor_back .. '" font="Fixed 14"> <span rise="1600" font="Visitor TT2 BRK 10" color="' .. volumecolor_front .. '">p' .. args[1] .. '<span color="#e54c62">m </span></span></span>'
    --return '<span font="Visitor TT2 BRK 10" color="#e54c62">muted<span font="Visitor TT2 BRK 10" color="#aeaeae">'.. args[3] ..'</span><span color="#aeaeae">%</span></span>'
    end
    return '<span background="' .. volumecolor_back .. '" font="Fixed 14"> <span rise="1600" font="Visitor TT2 BRK 10" color="' .. volumecolor_front .. '">p' .. args[1] .. ' </span></span>'
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
      --scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1)
    end
  ),

  awful.button({ }, 3, 
    function () 
      --awful.util.spawn_with_shell("pkill wpa_gui") 
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

netupinfo = lain.widgets.net_colorarrows({
  settings = 
  function()
    myinterface = iface
    -- if iface ~= "network off" and string.match(myweather._layout.text, "N/A") then
    --   myweather.update()
    --   netwidget.update()
    -- end
      
    widget:set_markup(markup(greencolor, '<span font="Fixed 14" background="' .. wificolor_back .. '"> <span rise="1600" font="Visitor TT2 BRK 10">' .. net_now.received .. '</span></span>'))
    netdowninfo:set_markup(markup(bluecolor, '<span font="Fixed 14" background="' .. wificolor_back .. '"> <span rise="1600" font="Visitor TT2 BRK 10">' .. net_now.sent .. ' </span></span>'))
  end
})

netupinfo:buttons(awful.util.table.join(
  awful.button({ }, 1, 
    function ()      
      --scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1)
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
    return '<span font="Fixed 14" background="' .. wificolor_back .. '"> <span rise="1600" font="Clean 8" color="' .. clockcolor_front .. '">' .. wireless_name .. '</span></span>'
  end,
  2, 
  myinterface
)
-- Separators
face = wibox.widget.textbox('<span color="' .. redcolor ..'" font="Visitor TT2 BRK 10">//\\(o.o_)/\\\\</span>')
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
arrows = wibox.widget.textbox('<span font="Fixed 14" background="' .. batterycolor_back .. '"> <span font="Clean 9" color="' .. clockcolor_front .. '">' .. '↓↑' .. '</span></span>')
arrows:buttons(awful.util.table.join(
  awful.button({ }, 1, 
    function ()      
      --scratch.drop("wpa_gui", "center", "center", .40, .50, "true", 1)
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
     return awful.rules.match(c, {class = 'Terminology'}) 
   end                                                      
   awful.client.run_or_raise(terminal, matcher)
 end)))
bf = wibox.widget.imagebox()
bf:set_image(beautiful.bf)
bf:buttons(awful.util.table.join(
  awful.button({ }, 1, function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'Terminology'}) 
   end                                                      
   awful.client.run_or_raise(terminal, matcher)
 end)
  ))   
gf = wibox.widget.imagebox()
gf:set_image(beautiful.gf)
gf:buttons(awful.util.table.join(awful.button(
  { }, 1, function ()
     local matcher = function (c)                   
     return awful.rules.match(c, {class = 'Terminology'}) 
   end                                                      
   awful.client.run_or_raise(terminal, matcher)
 end)
))   

-- Create a textclock widget

clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)
 mytextclock = awful.widget.textclock("<span font='Fixed 14' background='" .. clockcolor_back .. "'> <span rise='1600' font='Visitor TT2 BRK 10' color='" .. clockcolor_front .. "'>%I%M%p </span></span>")

-- Calendar
lain.widgets.calendar_colorarrows:attach(mytextclock, { font_size = 9 })
lain.widgets.calendar_colorarrows:attach(clockicon, { font_size = 9 })
