local shifty = require("shifty")
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
  awful.button({ }, 1,
    function ()
      mymainmenu:hide()
      mytaskmenu:hide()
      if musicwidget.main_menu ~= nil then
        musicwidget.main_menu:hide()
      end
    end
  ),
  awful.button({ }, 3,
    function ()
      mymainmenu:toggle()
      mytaskmenu:hide()
      if musicwidget.main_menu ~= nil then
        musicwidget.main_menu:hide()
      end
    end
  )
))
-- }}}

-- {{{ Key bindings

-- mapping for modal client keys
  client_mode = {
    -- Set client on top
    t = function (c) c.ontop = not c.ontop end,
    -- Redraw the client
    r = function (c) c:redraw() end,
    -- Toggle floating status of the client
    w = awful.client.floating.toggle,
    -- toggle mark
    o = awful.client.togglemarked,
    -- (un)sticky client
    s = function (c) c.sticky = not c.sticky end,
    -- make the client fullscreen
    f = function (c)
      c.fullscreen = not c.fullscreen
      if awful.rules.match(c, {class = 'URxvt'}) or awful.rules.match(c, {class = 'Skype'}) then
        if c.fullscreen == false then
          c.ontop = true
        end
      end   
    end,
    -- (un)maximize the client
    x = function (c)
          c.maximized_horizontal = not c.maximized_horizontal
          c.maximized_vertical   = not c.maximized_vertical
        end
}

globalkeys = awful.util.table.join(
  awful.key({ modkey }, "/", function() launch_cheeky() end),
  awful.key({            }, "Print", function () 
    awful.util.spawn_with_shell("escrotum $HOME/Pictures/Screenshots/screenshot-%0Y%0m%0d-%0k%0M%0S.png") 
    show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 2, nil, nil, nil, nil )
    end),
  awful.key({ modkey }, "Print", function () 
    show_smth(nil, "Choose area or window", iconsdir .. "/screen-measure.svg", 2, nil, nil, nil, nil )
    awful.util.spawn_with_shell("escrotum -s -C")
    --show_smth( nil, "Shot gonna be copied to clipboard (probably)", iconsdir .. "/camera.svg", 2, nil, nil, nil, nil )  
    end),
  awful.key({ "Control", }, "Print", function () 
    show_smth( nil, "Taking shot in 5s", iconsdir .. "/clock.svg", nil, nil, nil, nil, nil )
    awful.util.spawn_with_shell("sleep 4s && escrotum $HOME/Pictures/Screenshots/screenshot-%0Y%0m%0d-%0k%0M%0S.png") end),
  awful.key({ "Shift", }, "Print", function () 
    show_smth(nil, "Choose area or window", iconsdir .. "/screen-measure.svg", 2, nil, nil, nil, nil ) 
    awful.util.spawn_with_shell("escrotum -s $HOME/Pictures/Screenshots/screenshot-%0Y%0m%0d-%0k%0M%0S.png")
    --show_smth( nil, "Shot taken", iconsdir .. "/camera.svg", 2, nil, nil, nil, nil )
    end),
  awful.key({ modkey }, "Tab",
    function()
      local tag = awful.tag.selected()
      for i=1, #tag:clients() do
        tag:clients()[i].minimized=false
      end
      awful.client.focus.byidx(1)
      set_cursor_in_middle_of_focused_client()
    end
  ),
  awful.key({ alt }, "Tab",
    function()
      local tag = awful.tag.selected()
      awful.client.focus.byidx(1)
      set_cursor_in_middle_of_focused_client()
    end
  ),
  awful.key({modkey}, "q", awful.tag.viewprev),
  awful.key({ modkey, "Shift" }, "q",
                  function ()
                      shifty.send_prev()
                  end),
  awful.key({modkey}, "e", awful.tag.viewnext),
    awful.key({ modkey, "Shift" }, "e",
                  function ()
                      shifty.send_next()
                  end),
  awful.key({modkey}, "Down", function () awful.tag.viewonly(shifty.getpos(9)) end),
  awful.key({modkey, "Control"}, "n",
            function() shifty.add({ nopopup = true }) end
            ),
awful.key({modkey}, "Up", shifty.rename),
awful.key({modkey}, "d", shifty.del),
awful.key({ modkey }, "h", function () if beautiful.useless_gap_width == 8 then beautiful.useless_gap_width = 0 else beautiful.useless_gap_width = 8 end awful.tag.incmwfact(-0.01) awful.tag.incmwfact(0.01) end),
  awful.key({ "Control",           }, "Escape", function () mymainmenu:toggle() end),
  awful.key({ modkey,           }, "F8",  
    function() mywibox[mouse.screen.index].visible = not mywibox[mouse.screen.index].visible end       ),
  awful.key({ modkey,           }, "t",  function() mywibox_w[mouse.screen.index].visible = not mywibox_w[mouse.screen.index].visible end       ),

  awful.key({ modkey,           }, "j",
    function ()
      awful.client.focus.byidx( 1)
      set_cursor_in_middle_of_focused_client()
    end
  ),
  awful.key({ modkey,           }, "k",
    function ()
      awful.client.focus.byidx(-1)
      set_cursor_in_middle_of_focused_client()
    end
  ),

    -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j",
    function ()
      c = client.focus
      awful.client.swap.byidx(1)
      set_cursor_in_middle_of_focused_client()
      end
  ),
  awful.key({ modkey, "Shift"   }, "k",
    function ()
      c = client.focus
      awful.client.swap.byidx( -1)
      set_cursor_in_middle_of_focused_client()
    end
  ),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),




    -- Standard program
  awful.key({ }, "XF86Sleep",
    function ()
      show_smth(nil, "Z-z-z-z-z-z-z", iconsdir .. "/important.svg", 1, nil, nil, nil, nil)
  end,
    function ()
      awful.util.spawn_with_shell(lockscreen)
  end),
    -- function ()
    --   awful.util.spawn_with_shell("systemctl suspend")
    -- end),

  awful.key({ modkey, "Control"}, "t",
    function()
      touchpad_toggle()
    end,
    function ()
      show_smth(nil, "Touchpad control toggled!", iconsdir .. "/important.svg", 1, nil, nil, nil, nil)
    end
  ),
  awful.key({            }, "XF86PowerOff",
    function ()
      awful.util.spawn(scripts .. "/logout.sh")
    end
  ),
  --awful.key({      modkey      }, "v", function() awful.util.spawn(musicplr) end),
  awful.key({            }, "XF86Launch1",  function () awful.util.spawn_with_shell("zenity --question --text 'Reboot now?' && reboot") end),
  --awful.key({ "Control", modkey        }, "`", function () awful.util.spawn("gksudo pcmanfm") end),
  --awful.key({ modkey }, "`", function () awful.util.spawn("pcmanfm") end),
  awful.key({ "Control", modkey        }, "`", function () awful.util.spawn("gksudo " .. fm) end),
  --awful.key({ "Control",           }, "m", function () awful.util.spawn("sonata") end),
  awful.key({ alt }, "F1", function () awful.util.spawn_with_shell(translate_e_r) end),
  awful.key({ modkey }, "F1", function () awful.util.spawn_with_shell(translate_r_e) end),
  awful.key({ modkey, "Control" }, "Escape", function () awful.util.spawn_with_shell(lockscreen) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
-- Run or raise applications with dmenu
-- awful.key({ modkey }, "p", function ()
--     local f_reader = io.popen( "dmenu_path | dmenu -b -nb '".. beautiful.bg_normal .."' -nf '".. beautiful.fg_normal .."' -sb '#955'")
--     local command = assert(f_reader:read('*a'))
--     f_reader:close()
--     if command == "" then return end

--     -- Check throught the clients if the class match the command
--     local lower_command=string.lower(command)
--     for k, c in pairs(client.get()) do
--         local class=string.lower(c.class)
--         if string.match(class, lower_command) then
--             for i, v in ipairs(c:tags()) do
--                 awful.tag.viewonly(v)
--                 c:raise()
--                 c.minimized = false
--                 return
--             end
--         end
--     end
--     awful.util.spawn(command)
-- end),
  awful.key({ modkey }, "p", function () client.focus.maximized_vertical = false client.focus.maximized_horizontal = false end),

  -- backlight control

  awful.key({            }, "XF86MonBrightnessUp",  function () awful.util.spawn_with_shell(bri_up) end),
  awful.key({            }, "XF86MonBrightnessDown",  function () awful.util.spawn_with_shell(bri_down) end),

  -- Volume control
  awful.key({}, "XF86AudioMute", function () awful.util.spawn_with_shell(vol_mute) end),
  awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell(vol_up) end),
  awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell(vol_down) end),
  awful.key({ modkey }, "m", function () awful.util.spawn_with_shell(vol_mute) end),
  --awful.key({ modkey }, "Control","m", function () awful.util.spawn_with_shell(vol_mute) end),
  awful.key({ modkey,           }, "p",     function () awful.tag.incmwfact( 0.05)    end),
  awful.key({ modkey,  "Control"         }, "p",     function () awful.tag.incmwfact( -0.05)    end),
  --awful.key({ modkey,           }, beautiful.mycolor,     function () awful.tag.incmwfact(-0.05)    end),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
  --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
  --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
  awful.key({ modkey,           }, "space", function () awful.layout.inc(1, s, layouts) end),
  awful.key({ modkey, "Control"   }, "space", function () awful.layout.inc(-1, s, layouts) end),
  awful.key({ modkey, "Control"}, "Return", function () awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control"}, "KP_Enter", function () awful.util.spawn(terminal) end),
--run or raise clients

  awful.key({ modkey, }, "Return",
    function ()
      local matcher =
      function (c)
        return awful.rules.match(c, {class = 'terminology'})
      end
      awful.client.run_or_raise(terminal, matcher)
      set_cursor_in_middle_of_focused_client()
    end
  ),

  awful.key({ modkey, }, "KP_Enter",
    function ()
      local matcher =
      function (c)
        return awful.rules.match(c, {class = 'terminology'})
      end
      awful.client.run_or_raise(terminal, matcher)
      set_cursor_in_middle_of_focused_client()
    end
  ),

  awful.key({ modkey }, "b",
    function ()
      local matcher =
      function (c)
        return awful.rules.match(c, {class = 'vivaldi'})
      end
      awful.client.run_or_raise(browser, matcher)
      --set_cursor_in_middle_of_focused_client()
    end
  ),

  awful.key({ modkey }, "s",
    function ()
      local matcher =
      function (c)
        return awful.rules.match(c, {class = 'Skype'})
      end
      awful.client.run_or_raise("skype", matcher)
      --set_cursor_in_middle_of_focused_client()
    end
  ),

  awful.key({ modkey }, "l",
    function ()
      local matcher =
      function (c)
        return awful.rules.match(c, {class = 'Subl3'})
      end
      awful.client.run_or_raise(editor, matcher)
      --set_cursor_in_middle_of_focused_client()
    end
  ),
    awful.key({ modkey }, "`",
    function ()
      local matcher =
      function (c)
        return awful.rules.match(c, {class = "Worker"})
      end
      awful.client.run_or_raise(fm, matcher)
      --set_cursor_in_middle_of_focused_client()
    end
  ),
    -- Prompt

  awful.key({ alt, }, "F2",
    function ()
      awful.prompt.run(
        {prompt="<span font='Visitor TT2 BRK 10' color='" .. green_color .. "'> ~</span><span color='" .. white .. "'> " .. "> </span>", fg_cursor=green_color, selectall = not no_selectall, ul_cursor = "single" },
        mypromptbox[mouse.screen.index].widget,
        check_for_terminal,
        clean_for_completion,
        awful.util.getdir("cache") .. "/history"
      )
    end
  ),
  awful.key({ modkey }, "F2",
    function ()
      awful.prompt.run({ prompt = "<span font='Visitor TT2 BRK 10' color='" .. green_color .. "'> ~</span><span color='" .. white .. "'>" .. " >> </span>", fg_cursor=green_color, selectall = not no_selectall, ul_cursor = "single" },
        mypromptbox[mouse.screen.index].widget,
        awful.util.eval,
        nil,
        awful.util.getdir("cache") .. "/history_eval"
      )
    end
  ),
  awful.key({ modkey            }, "c",
    function ()
        awful.prompt.run(
          { prompt = "<span font='Visitor TT2 BRK 10' color='" .. green_color .. "'> ~<span font='Visitor TT2 BRK 10' color='" .. white .. "'> calculate </span>: </span>", fg_cursor=green_color, selectall = not no_selectall, ul_cursor = "single" },
          mypromptbox[mouse.screen.index].widget,
          function (expr)
              local result = awful.util.eval("return (" .. expr .. ")")
              naughty.notify({ text = "<span font='Visitor TT2 BRK 13'>" .. expr .. "=" .. result .. "</span>", timeout = 0, border_width = 0, bg = wibox_color(), fg = red_color })
          end,
          nil,
          awful.util.getdir("cache") .. "/calc"
        )
    end),
    awful.key({ modkey            }, "g",
    function ()
        awful.prompt.run(
          { prompt = "<span font='Visitor TT2 BRK 10' color='" .. green_color .. "'> ~<span font='Visitor TT2 BRK 10' color='" .. white .. "'> to RU </span>: </span>", fg_cursor=green_color, selectall = not no_selectall, ul_cursor = "single" },
          mypromptbox[mouse.screen.index].widget,
          function (expr)
              awful.util.spawn_with_shell(translate_e_r .. " " .. expr)
          end,
          nil,
          awful.util.getdir("cache") .. "/gtranslate_en"
        )
    end),
    awful.key({ modkey, "Control"            }, "g",
    function ()
        awful.prompt.run(
          { prompt = "<span font='Visitor TT2 BRK 10' color='" .. green_color .. "'> ~<span font='Visitor TT2 BRK 10' color='" .. white .. "'> to EN </span>: </span>", fg_cursor=green_color, selectall = not no_selectall, ul_cursor = "single" },
          mypromptbox[mouse.screen.index].widget,
          function (expr)
              awful.util.spawn_with_shell(translate_r_e .. " " .. expr)
          end,
          nil,
          awful.util.getdir("cache") .. "/gtranslate_ru"
        )
    end)
) --


clientkeys = awful.util.table.join(
   awful.key({ modkey }, "w", function(c)
     keygrabber.run(function(mod, key, event)
         if event == "release" then return true end
         keygrabber.stop()
         if client_mode[key] then client_mode[key](c) end
         return true
     end)
 end),
  --awful.key({ modkey,           }, "w",      awful.client.floating.toggle),
  awful.key({ alt,              }, "F4",      function (c) c:kill() end),
  awful.key({ modkey,           }, "F4",      function (c)
    local tag = awful.tag.selected()
    for i=1, #tag:clients() do
      if not (tag:clients()[i] == c) then
        tag:clients()[i]:kill()
      end
    end
  end),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
  --awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
  awful.key({ alt,              }, "Escape", function (c) c.minimized = true end),
  awful.key({ alt,              }, "z", function (c) c.minimized = true end),
  awful.key({ modkey,              }, "z", function (c) c.minimized = true end),
  awful.key({ modkey,           }, "Escape", function (c)
    local tag = awful.tag.selected()
    for i=1, #tag:clients() do
      if not (tag:clients()[i] == c) then
        tag:clients()[i].minimized=true
      end
    end
  end)
)

clientbuttons = awful.util.table.join(
  awful.button({         }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey  }, 1, awful.mouse.client.move),
  awful.button({ modkey  }, 4, function (c) client.focus = c; c.opacity = c.opacity+0.05 end),
  awful.button({ modkey  }, 5, function (c) client.focus = c; c.opacity = c.opacity-0.05 end),
  awful.button({ alt     }, 1, awful.mouse.client.resize))

-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                      awful.tag.viewonly(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      awful.tag.viewtoggle(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local t = shifty.getpos(i)
                          awful.client.movetotag(t)
                          awful.tag.viewonly(t)
                       end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          awful.client.toggletag(shifty.getpos(i))
                      end
                  end))
end
