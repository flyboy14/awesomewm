require("themes/dark_grey/functions")
local shifty = require("shifty")
-- Create a wibox for each screen and add it
mytaglist.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

mytasklist = {}
mytasklist1 = {'[ mytasklist ]'}
mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1,
    function (c)
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
    end
  ),
  awful.button({ }, 3,
    function (c)
      if c == client.focus then
        mytaskmenu:toggle()
      else
        client.focus = c
        c.minimized = false
        mytaskmenu:toggle()
      end
    end
  ),
  awful.button({ }, 4,
    function ()
      awful.client.focus.byidx(1)
      if client.focus then
        client.focus:raise()
      end
    end
  ),
  awful.button({ }, 5,
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then
        client.focus:raise()
      end
    end
  )
)

for s = 1, screen.count() do
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.

  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(1, s, shifty.config.layouts) end),
    awful.button({ }, 3, function () awful.layout.inc(-1, s, shifty.config.layouts) end)
  ))
  -- Create a taglist widget
  --mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, mytaglist.buttons)
  shifty.taglist = mytaglist
  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
  --mytasklist[s].set_bg(beautiful.bg_tasklist)
  -- Create the wibox

  mywibox[s] = awful.wibox({ position = "top", screen = s, height = 18, opacity = 1, bg = beautiful.mycolor .. "44", margin_left = 10 })
  mywibox_w[s] = awful.wibox({ position = "bottom", screen = s, height = 18, opacity = 1, bg = beautiful.mycolor })
  --mywibox[s].set_margins(5)

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  --left_layout:add(mylauncher)
  left_layout:add(spr)
  left_layout:add(mylayoutbox[s])
  left_layout:add(spr)
  left_layout:add(mytaglist[s])
  --left_layout:add(arrl)
    left_layout:add(mypromptbox[s])
  left_layout:add(mpdicon)
  left_layout:add(music)
  -- left_layout:add(musicwidget.widget)
  left_layout:add(spr)

  local left_w = wibox.layout.fixed.horizontal()
  left_w:add(sepl)
  --left_w:add(bral)

  -- Widgets that are aligned to the right
  local right_layout = wibox.layout.fixed.horizontal()
  right_layout:add(bf)
  right_layout:add(gf)
  right_layout:add(yf)
  right_layout:add(spr)
  right_layout:add(spr)
  right_layout:add(cpuicon)  
  right_layout:add(cpuwidget)
  right_layout:add(tempicon)
  right_layout:add(tempwidget)
  right_layout:add(memicon)
  right_layout:add(memwidget)
  right_layout:add(neticon)
  right_layout:add(netwidget)
  right_layout:add(spr)
  right_layout:add(spr)
  right_layout:add(netupinfo)
  right_layout:add(arrows)
  right_layout:add(netdowninfo)
  right_layout:add(spr)
  right_layout:add(volicon)
  right_layout:add(volumewidget)
  right_layout:add(kbdwidget)
  right_layout:add(spr)
  right_layout:add(spr)
  right_layout:add(weathericon)
  right_layout:add(myweather)
  right_layout:add(spr)
  right_layout:add(baticon)
  right_layout:add(batwidget)
  right_layout:add(clockicon)
  right_layout:add(mytextclock)

  local tray_layout = wibox.layout.fixed.horizontal()
  local right_w = wibox.layout.fixed.horizontal()
  --right_w:add(brar)
  right_w:add(spr)
  right_w:add(face)
  right_w:add(spr)
  right_w:add(bral)
  if s == 1 then right_w:add(mysystray) end
    --right_w:add(brar)
  right_w:add(spr_huge)
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
  layout_w:set_expand(outside)
  mywibox[s]:set_widget(layout)
  mywibox_w[s]:set_widget(layout_w)
  mywibox_w[s].visible = false
end
-- }}}

shifty.taglist = mytaglist
shifty.init()
