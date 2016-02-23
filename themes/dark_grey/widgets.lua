-- Memory widget
--memwidget = wibox.widget.textbox()
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
-- vicious.register(memwidget, vicious.widgets.mem, "<span font='Visitor TT2 BRK 10' color='#aeaeae'>$2MB/$3MB  </span>", 3)

memwidget = lain.widgets.mem({
  timeout = 3,
  settings = 
    function()
      local color = grey
      local mem = math.floor(mem_now.used)
      if mem < 1000 then color = green_color 
      elseif mem < 4000 then color = yellow_color
      elseif mem < 6000 then color = orange_color
      else color = red_color
      end
      widget:set_markup(markup(color, "<span color='"..grey_color.."' font='Visitor TT2 BRK 10'>RAM </span><span font='Visitor TT2 BRK 10'>"..mem.."MB </span>"))
    end
})

-- Battery widget



baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_battery)
batwidget = lain.widgets.bat({
  timeout = 3,
  notify = "on",
  settings = 
    function()
      local color = grey
      local perc = math.floor(bat_now.perc)
      local time = bat_now.time
      local status = bat_now.status
      local time_color = green_color
      --if (batstate() == 'Cable plugged') then
--     baticon:set_image(beautiful.widget_ac)
--     return '<span font="Visitor TT2 BRK 10" color="#46A8C3">AC </span>'
--     -- critical
  if (perc <= 7 and state == 'Discharging') then
    baticon:set_image(beautiful.widget_battery_empty)
    awful.util.spawn("systemctl suspend")
  elseif (state == 'Discharging' and perc <= 10) then
    show_smth("⚡ Caution! ⚡", "Battery energy entered critical state!", iconsdir .. "/battery-red.svg", 1, nil, nil, nil, nil )
  elseif (perc <= 15) then
    baticon:set_image(beautiful.widget_battery_empty)
  elseif (perc <= 25) then
    baticon:set_image(beautiful.widget_battery_very_low)
  elseif (perc <= 45) then
    baticon:set_image(beautiful.widget_battery_low)
  elseif (perc <= 89) then
    baticon:set_image(beautiful.widget_battery_mid)
  elseif (perc >= 90) then baticon:set_image(beautiful.widget_battery_high)
  end
      if status == "Discharging" then
        time_color = red_color
        time = '<span font="Clean 9" rise="-1000" color="'..time_color..'">↓ <span rise="400" font="Visitor TT2 BRK 10">'..time..'</span></span>'
      elseif status == "Charging" and perc ~= 100 then
        time_color = green_color
        time = '<span font="Clean 9" rise="-1000" color="'..time_color..'">↑ <span rise="400" font="Visitor TT2 BRK 10">'..time..'</span></span>'
      else
        time_color = blue_color
        time = '<span font="Clean 9" rise="-1000" color="'..time_color..'">⚡ <span rise="400" font="Visitor TT2 BRK 10">full</span></span>'
      end
      widget:set_markup(markup(color, time..'<span font="Visitor TT2 BRK 10">p'..perc..' </span>'))
    end
})

--
-- {{{ Variable definitions
kbd_dbus_sw_cmd = "qdbus ru.gentoo.KbddService /ru/gentoo/KbddService  ru.gentoo.kbdd.set_layout "
-- kbd_dbus_sw_cmd = "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.set_layout uint32:"
kbd_dbus_prev_cmd = "qdbus ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.prev_layout"
-- kbd_dbus_prev_cmd = "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.prev_layout"
kbd_dbus_next_cmd = "qdbus ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout"
-- kbd_dbus_next_cmd = "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout"
kbd_img_path = "/usr/share/icons/kbflags/"
-- }}}

-- {{{ Keyboard layout widgets
--- Create the menu
kbdmenu =awful.menu({ items = {  
  { "English", kbd_dbus_sw_cmd .. "0" },
  { "Русский", kbd_dbus_sw_cmd .. "1" }
  }
})

-- Create simple text widget
kbdwidget = wibox.widget.textbox()
-- kbdwidget.border_width = 1
-- kbdwidget.border_color = beautiful.fg_normal
kbdwidget.align="center"
kbdwidget:set_markup("<span font='Visitor TT2 BRK 10' color='#aeaeae'>en-us</span>")
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
  kbdwidget:set_markup("<span font='Visitor TT2 BRK 10' color='#aeaeae'>"..lts[layout].."</span>")
  --kbdwidget.bg_image = image(lts_img[layout])
  end)
-- }}}
--

-- Mail widget

-- mygmail = wibox.widget.textbox()
-- vicious.register(
--   mygmail,
--   vicious.widgets.gmail,
--   '<span color="#FFA963" font="Visitor TT2 BRK 10"> +${count}</span>',
--   260
-- )
 mygmailimg = my_launcher({
   image = beautiful.widget_mail,
   command = browser .. " mail.google.com/mail/u/1/h mail.google.com/mail/u/0/h"
 })

-- CPU widget

cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
  timeout = 3,
  settings = 
    function()
      local color = "#dedede"
      local cpu = math.floor(cpu_now.usage)
      if cpu < 20 then color = green_color
      elseif cpu < 55 then color = yellow_color
      elseif cpu < 75 then color = orange_color
      else color = red_color
      end
      widget:set_markup(markup(color, "<span color='"..grey_color.."' font='Visitor TT2 BRK 10'>CPU </span><span font='Visitor TT2 BRK 10'>"..cpu.."% </span>"))
    end
})

-- Temp widget

tempicon = wibox.widget.imagebox()
tempicon:set_image(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
  timeout = 5,
  settings = 
    function()
      local color = "#dedede"
      local temp = math.floor(coretemp_now)
      if temp < 50 then color = green_color
      elseif temp < 65 then color = yellow_color
      elseif temp < 75 then color = orange_color
      else color = red_color
      end
      widget:set_markup(markup(color, "<span color='"..grey_color.."' font='Visitor TT2 BRK 10'></span><span font='Visitor TT2 BRK 10'>"..temp.."°C </span>"))
    end
})

-- Weather widget



myweather = lain.widgets.weather({
  city_id = 625144, -- placeholder
  lang = "en",
  appid = "1830df4055002d2fac6351616ee174d9",
  settings =
    function()
      local descr = weather_now["weather"][1]["description"]:lower()
      local units = math.floor(weather_now["main"]["temp"])-273
      local unitscolor = "#aeaeae"
      if units < -12 then
        unitscolor = strongblue units = "fuck, it\'s " .. units
      elseif units <= 0 then
        unitscolor = blue
      elseif units <= 17 then
        unitscolor = strongyellow
      elseif units <= 30 then
        unitscolor = strongorange
      elseif units > 30 then
        unitscolor = hellorange units = "fuck, it\'s " .. units
      end
      widget:set_markup(markup(
        unitscolor,
        "<span font='Visitor TT2 BRK 10'><span color='#9e9e9e'>" .. descr .. "</span> " .. units .. "°C</span>"
      ))
    end
})

weathericon = my_launcher_n({
  image = beautiful.widget_weather,
  command = myweather.update
})

--Volume widget

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
    local volcolor = grey
    if (args[2] ~= "♩" ) then
      if (args[1] == 0) then
        volicon:set_image(beautiful.widget_vol_no)
        volcolor = red_color
      elseif (args[1] <= 10) then
        volicon:set_image(beautiful.widget_vol_med)
        volcolor = orange_color
      elseif (args[1] <= 20) then
        volicon:set_image(beautiful.widget_vol_med)
        volcolor = yellow_color
      elseif (args[1] <= 45) then
        volicon:set_image(beautiful.widget_vol_low)
        volcolor = green_color
      elseif (args[1] <= 60) then
        volicon:set_image(beautiful.widget_vol_low)
        volcolor = yellow_color
      elseif (args[1] <= 85) then
        volicon:set_image(beautiful.widget_vol_med)
        volcolor = orange_color
      else
        volicon:set_image(beautiful.widget_vol_hi)
        volcolor = red_color
      end

    else
      volicon:set_image(beautiful.widget_vol_mute)
    return '<span font="Visitor TT2 BRK 10" color="'..volcolor..'">p' .. args[1] .. '<span color="'..red_color..'">m  </span></span>'
    --return '<span font="Visitor TT2 BRK 10" color="#e54c62">muted<span font="Visitor TT2 BRK 10" color="#aeaeae">'.. args[3] ..'</span><span color="#aeaeae">%</span></span>'
    end
    return '<span font="Visitor TT2 BRK 10" color="'..volcolor..'">p' .. args[1] .. '  </span>'
      --return '<span font="Visitor TT2 BRK 10" color="#aeaeae">' .. args[3] ..'<span font="Visitor TT2 BRK 10">%</span></span>'
  end,
  1,
  "Master"
)

-- Net widget

netwidget = wibox.widget.textbox()
neticon = my_launcher({ image = beautiful.widget_net_no, command = "systemctl restart NetworkManager" })


netdowninfo = wibox.widget.textbox()
netupinfo = lain.widgets.net({
  settings =
  function()
    myinterface = iface
    widget:set_markup(markup(green_color, "<span font='Visitor TT2 BRK 10'>" .. net_now.received .. " </span>"))
    netdowninfo:set_markup(markup(blue_color, "<span font='Visitor TT2 BRK 10'>" .. net_now.sent .. " </span>"))
  end
})

vicious.register(
  netwidget,
  vicious.widgets.wifi,
  function (widget, args)
    link = args['{link}']
    if myinterface:find("enp") then  -- wired interfaces
      neticon:set_image(beautiful.widget_net_wired)
      inet_on = true
    elseif myinterface:find("wl") then
      -- naughty.notify({text = link})
      -- if link > 65 then
         neticon:set_image(beautiful.widget_net_hi)
      -- elseif link > 30 and link <= 65 then
      --   neticon:set_image(beautiful.widget_net_mid)
      -- elseif link > 0 and link <= 30 then
      --   neticon:set_image(beautiful.widget_net_low)
      -- end
      inet_on = true
    else
        neticon:set_image(beautiful.widget_net_no)
        inet_on = false
    end
    wireless_name = args['{ssid}']
    myweather.forecast_update()
    myweather.update()
    return '<span font="Clean 8" color="#aeaeae"> ' .. wireless_name .. '</span>'
  end,
  2,
  myinterface
)


-- Separators
face = wibox.widget.textbox('<span color="'..red_color..'" font="Visitor TT2 BRK 10">//\\(o.o_)/\\\\</span>')

face:buttons(awful.util.table.join(
  awful.button({ }, 3,
    function () awful.util.spawn_with_shell(scripts .. "/change_config.sh") end, awesome.restart),
    --function ()

      --awful.util.spawn_with_shell(browser .. " mail.google.com/mail/u/1/h mail.google.com/mail/u/0/h")
    --end
  --),
  awful.button({ }, 1,
    function(c)
      local f = io.popen("fortune -s")
      local quote = f:read("*all")
      f:close()
      show_smth("Wisdom spider", quote, nil, 0, nil, nil, "Clean 9", "bottom_right")
      color_systray()
    end
  )
))


face:connect_signal("mouse::enter",
  function(c)
    local f = io.popen("fortune -s")
    local quote = f:read("*all")
    f:close()
    show_smth("Wisdom spider :", quote, nil, 0, nil, nil, "Clean 9", "bottom_right")
  end
)

face:connect_signal("mouse::leave",
  function(c)
    hide_smth()
  end
)


bral = wibox.widget.textbox('<span color="#aeaeae"> </span>')
brar = wibox.widget.textbox('<span color="#aeaeae">> </span>')
spr = wibox.widget.textbox(' ')
arrows = wibox.widget.textbox('<span font="Clean 9" color="#aeaeae">' .. '↓↑ ' .. '</span>')

sepl = wibox.widget.textbox('<span color="#aeaeae" font="Visitor TT2 BRK 10"> tasks ></span>')
sepr = wibox.widget.textbox('<span color="#aeaeae" font="Visitor TT2 BRK 10"> > systray </span>')
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)

yf = wibox.widget.imagebox()
yf:set_image(beautiful.yf)
yf:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function ()
      awful.util.spawn(terminal)
    end
  )
))

bf = wibox.widget.imagebox()
bf:set_image(beautiful.bf)
bf:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function ()
      awful.util.spawn(terminal)
    end
  )
))

gf = wibox.widget.imagebox()
gf:set_image(beautiful.gf)
gf:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function ()
      awful.util.spawn(terminal)
    end
  )
))


-- Create a textclock widget
clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)
mytextclock = awful.widget.textclock("<span font='Visitor TT2 BRK 10' color='#aeaeae'>%I%M </span>")

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 9 })
lain.widgets.calendar:attach(clockicon, { font_size = 9 })

musicwidget = awesompd:create() -- Create awesompd widget
musicwidget.font = "Clean 9"
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
    port = 6600
  },
}
musicwidget:register_buttons({
  { "", awesompd.MOUSE_LEFT, musicwidget:command_toggle() },
  { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
  { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
  { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
  { "", "XF86AudioPlay", musicwidget:command_playpause() },
  { "", "XF86AudioNext", musicwidget:command_next_track() },
  { "", "XF86AudioPrev", musicwidget:command_prev_track() },
  { "", "XF86AudioStop", musicwidget:command_stop() },
})

-- Music icon
mpdicon = my_launcher({ image = beautiful.arrl, command = musicplr })