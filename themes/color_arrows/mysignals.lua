require("themes/color_arrows/mywiboxes")
gears = require("gears")
awful = require("awful")
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

client.connect_signal("focus", 
  function(c)
    c.border_color = beautiful.border_focus
  end,
  function(c)
  local tag = awful.tag.selected()
  local ok = 0
  for i = 1, #tag:clients() do
    if (awful.layout.get(c.screen) == awful.layout.suit.floating or awful.client.property.get(tag:clients()[i], "floating") or tag:clients()[i].type == dialog or tag:clients()[i].floating) and tag:clients()[i].minimized == false then
      ok = 1
    end
  end
  if ok == 0 then 
    c:raise()
  end
    -- if wibox_color() == beautiful.bg_normal and is_only_client() and not is_fullscreen() and not awful.client.property.get(c, "floating") then
    --   c.border_color = beautiful.border_normal  -- for only unminimized non-floating client on tag
    -- else
    --   c.border_color = beautiful.border_focus
    -- end
  end)
client.connect_signal("unfocus", function(c)
                                c.border_color = beautiful.border_normal
                             end)

client.connect_signal("unmanage", function(c)
                                --if(not client.focus) then mouse.coords({x=683, y=384}) end 
                             end)

client.connect_signal("manage", function(c)
                                if(mouse.object_under_pointer() == client.focus) then return
                                  else mouse.coords({x=c:geometry()['x']+c:geometry()['width']/2, y=c:geometry()['y']+c:geometry()['height']/2}) end
end)
-- }}}