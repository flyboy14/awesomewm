
-- Standard awesome library
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
my_launcher = require("launcher_my")
wibox = require("wibox")
beautiful = require("beautiful")
vicious = require("vicious")
awesompd = require("awesompd/awesompd")
naughty = require("naughty")
xdg_menu = require("archmenu")
lain = require("lain")
require("cheeky")
require("awful.autofocus")
require("themes/dark_grey/vars")
require("themes/dark_grey/functions")
require("themes/dark_grey/bindings")
require("themes/dark_grey/shifty")
require("themes/dark_grey/menus")
require("themes/dark_grey/widgets")
require("themes/dark_grey/mywiboxes")
require("themes/dark_grey/mysignals")


-- {{{ Localization
os.setlocale(os.getenv("LANG"))
-- }}}

-- {{{ Error Handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Произошла ошибка при запуске awesome! :(",
    text = awesome.startup_errors,
    timeout = 3
  })
end

-- Handle runtime errors after startup
do
  in_error = false
  awesome.connect_signal("debug::error",
    function (err)
      -- Make sure we don't go into an endless error loop
      if in_error then
        return
      end

      in_error = true
      naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Произошла ошибка при работе awesome :c",
        text = err,
        timeout = 3
      })
      in_error = false
    end
  )
end

-- Wallpaper
set_wallpaper()
color_systray()
-- }}}

--- {{{ Autorun apps
  run_once_ifnot("kbdd", "slock") -- run slock only if kbdd didn't start e.g. first launch after login
  run_once("nm-applet")
  run_once("parcellite")
  run_once("kbdd")
  run_once("skypeforlinux")
  run_once("telegram-desktop")
  run_once("slack", "slack -us")
  run_once_ifnot("xbanish", "xbanish -bt4000")
  run_once("blueberry")
  run_once("udiskie", "udiskie -as")
  run_once_ifnot("picom", "picom --shadow-blue 0.05 -cGz -r 9 -t -8 -l -8 -D 5 -I 1 -O 1 --xrender-sync-fence" )
  ----inactive-dim 0.35 
  --"xcowsay 'Moo, brother, moo.'"
-- }}}

--awesompd
musicwidget:run()

-- Set keys
musicwidget:append_global_keys()
root.keys(globalkeys)
-- }}}

-- mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
-- mywibox_w[mouse.screen].visible = not mywibox_w[mouse.screen].visible

-- local oldspawn = awful.util.spawn
-- awful.util.spawn = function (s)
--   oldspawn(s, false)
-- end
-- }}}

