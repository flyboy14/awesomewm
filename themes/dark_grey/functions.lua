function is_only_client()
  local count = 0
  local tag = awful.tag.selected()
  for i = 1, #tag:clients() do
    if not tag:clients()[i].minimized then 
      count = count + 1
    end
    if count > 1 or count == 0 then return false end
  end
    return true
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
  local f = io.popen(scripts .. "/getcolor2.py " .. mywibox[mouse.screen.index].width .. " 760")
  beautiful.systray = f:read()
  f:close()
end

function mouse_on_wibox()
  -- if mouse.object_under_pointer() == client.focus then
  --   return false
  -- end
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

function launch_cheeky()
  local offset = { x = 0, y = 16 }

  if client.focus then
    offset = screen[client.focus.screen].workarea
  end

  cheeky.util.switcher({ 
    coords = { x = offset.x + mywibox[mouse.screen.index].width/2-200, y = offset.y + 10},
    menu_theme = { height = 20, width = 400 }, 
    show_tag = true,   
  })
end

-- }}}
function wibox_color()
  local tag = awful.tag.selected()
  if not tag then return beautiful.mycolor .. "44" end
  local c = tag:clients() or 0
  for i=1, #c do
    if not c[i].minimized then
      if (c[i]:geometry()['y'] <= mywibox[mouse.screen.index].height + beautiful.useless_gap_width) then -- or c[i]:geometry()['y'] + c[i]:geometry()['height'] >= 748
        return beautiful.mycolor
      end
    end
  end
  return beautiful.mycolor .. "44"
end

function is_fullscreen()
  local tag = awful.tag.selected()
  local c = tag:clients()
  for i=1, #c do
    if not c[i].minimized then
      if (c[i]:geometry()['y'] <= mywibox[mouse.screen.index].height and c[i]:geometry()['y'] + c[i]:geometry()['height'] >= 766 - mywibox_w[mouse.screen.index].height ) then
        return true
      end
    end
  end
  return false
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

-- function run_once(why, what)
--   if what == nil then
--     what = why
--   end
--   awful.util.spawn_with_shell("pgrep -u $USER -x " .. why .. " || (" .. what .. ")")
-- end

-- {{{ Run programm once
require("lfs") 
local function processwalker()
   local function yieldprocess()
      for dir in lfs.dir("/proc") do
        -- All directories in /proc containing a number, represent a process
        if tonumber(dir) ~= nil then
          local f, err = io.open("/proc/"..dir.."/cmdline")
          if f then
            local cmdline = f:read("*all")
            f:close()
            if cmdline ~= "" then
              coroutine.yield(cmdline)
            end
          end
        end
      end
    end
    return coroutine.wrap(yieldprocess)
end

function run_once(process, cmd)
   assert(type(process) == "string")
   local regex_killer = {
      ["+"]  = "%+", ["-"] = "%-",
      ["*"]  = "%*", ["?"]  = "%?" }

   for p in processwalker() do
      if p:find(process:gsub("[-+?*]", regex_killer)) then
   return
      end
   end
   return awful.util.spawn_with_shell(cmd or process)
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
   if command:sub(1,1) == "!" then
      awful.util.spawn_with_shell(command:sub(2))
      return
   end
    -- Check throught the clients if the class match the command
    local lower_command=string.lower(command)
    for k, c in pairs(client.get()) do
        local class=string.lower(c.class)
        if string.match(class, lower_command) then
            for i, v in ipairs(c:tags()) do
                awful.tag.viewonly(v)
                c.minimized = false
                c:raise()
                return
            end
        end
    end
   awful.util.spawn_with_shell(command)
   --mypromptbox[awful.screen.focused()]:spawn_and_handle_error(command, {floating=true})
end

function clean_for_completion (command, cur_pos, ncomp, shell)
   local term = false
   if command:sub(1,1) == ":" then
      term = true
      command = command:sub(2)
      cur_pos = cur_pos - 1
   end
   command, cur_pos = awful.completion.shell(command, cur_pos,ncomp,"zsh")
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
    --gears.wallpaper.fit(wpaper,s,false)
    gears.wallpaper.maximized(wpaper,s,false)
  end
end
-- }}}
