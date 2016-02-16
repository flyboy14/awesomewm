function is_only_client()
  local count = 0
  local tag = awful.tag.selected()
  for i = 1, #tag:clients() do
    if not tag:clients()[i].minimized
      then count = count + 1
    end
  end

  if count == 1 then
    return true
  else
    return false
  end
end

function set_cursor_in_middle_of_focused_client()
  if client.focus then
    client.focus:raise()
    mouse.coords({x=client.focus:geometry()['x']+client.focus:geometry()['width']/2, y=client.focus:geometry()['y']+client.focus:geometry()['height']/2})
  end
end

function record_screen()
  awful.util.spawn_with_shell(scripts .. "/record_screen.sh")
end

function color_systray()
  local f = io.popen(scripts .. "/getcolor2.py 1306 760")
  beautiful.systray = f:read()
  f:close()
end

function mouse_on_wibox()
  if mouse.object_under_pointer() == client.focus then
    return false
  end

  if mouse.coords()["y"] >= 750 or mouse.coords()["y"] <= 18 then
    return true
  else
    return false
  end
end

function restore_colors()
        green_color = green
        blue_color = blue
        red_color = red
        yellow_color = yellow
        orange_color = orange
        grey_color = grey
end

function revert_colors()
        green_color = stronggreen
        blue_color = strongblue
        red_color = strongred
        yellow_color = grey
        orange_color = grey
        grey_color = strongblue
end

-- }}}
function wibox_color()
  local tag = awful.tag.selected()
  local val = beautiful.mycolor .. "44"
  local finished = false
  local c = tag:clients()
  for i=1, #c do
    if not c[i].minimized and finished == false then
      if (c[i]:geometry()['y'] <= 17 or c[i]:geometry()['y'] + c[i]:geometry()['height'] >= 748) then
        finished = true
        val = beautiful.mycolor
        break
      else
        val = beautiful.mycolor .. "44"
        finished = false
      end
    end
  end
  return val
end

function is_fullscreen()
  local val = false
  local tag = awful.tag.selected()
  local c = tag:clients()
  for i=1, #c do
    if not c[i].minimized and finished == false then
      if (c[i]:geometry()['y'] <= 17 and c[i]:geometry()['y'] + c[i]:geometry()['height'] >= 748) then
        val = true
        finished = true
        break
      else
        val = false
        finished = false
      end
    end
  end
  return val
end

function bool_to_str(boole)
  if boole then
    return "true"
  else
    return "false"
  end
end

function touchpad_toggle()
  local f = io.popen('synclient -l | grep TouchpadOff | sed "s_ __g"|cut -d= -f2')
  local state = f:read()
  f:close()
  if state == "1" then
    awful.util.spawn_with_shell("synclient TouchpadOff=0")
  else
    awful.util.spawn_with_shell("synclient TouchpadOff=1")
  end
end

function show_smth(tiitle, teext, icoon, timeeout, baackground, fooreground, foont, poosition)
  hide_smth()
  noti = naughty.notify{title = tiitle or nil, text = teext or nil, icon = icoon or "", timeout = timeeout or 5
  , bg = baackground or wibox_color(), fg = fooreground or "#dedede", font = foont or beautiful.font, position = poosition or "top_right", opacity = 1, border_color = "#000000", border_width = 0 }
end

function hide_smth()
  naughty.destroy(noti)
end

-- }}}
-- Autorun programs
function run_once(why, what)
  if what == nil then
    what = why
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. why .. " || (" .. what .. ")")
end

function run_when(why, what)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. why .. " && (" .. what .. ")")
end

function run_when_once(why, why2, what)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. why .. " && pgrep -u $USER -x " .. why2 .. " || (" .. what .. ")")
end

-- {{{ functions to help launch run commands in a terminal using ":" keyword


function check_for_terminal (command)
   if command:sub(1,1) == ":" then
      command = terminal .. ' -e "' .. command:sub(2) .. '"'
   end
   awful.util.spawn_with_shell("source ~/.zshrc &&" .. command .. " &2>/dev/null")
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

-- {{{ get wallpaper from nitrogen config file
function set_wallpaper ()
  local f = io.popen("cat " .. home .. "/.config/nitrogen/bg-saved.cfg | grep file= | sed 's_'file='__g'")
  wpaper = f:read()
  f:close()

  if wpaper == nil then
    if beautiful.wallpaper then
      wpaper = beautiful.wallpaper
    end
  end

  for s = 1, screen.count() do
    --gears.wallpaper.centered(wpaper, s, false)
    gears.wallpaper.fit(wpaper,s,false)
    --gears.wallpaper.maximized(wpaper,s,false)
  end
end
-- }}}