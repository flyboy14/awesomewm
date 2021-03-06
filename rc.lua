
-- Standard awesome library
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
my_launcher = require("launcher_my")
wibox = require("wibox")
beautiful = require("beautiful")
vicious = require("vicious")
--awesompd = require("awesompd/awesompd")
naughty = require("naughty")
xdg_menu = require("archmenu")
lain = require("lain")
--require("cheeky")
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
run_once_ifnot("dwall", "dwall -s forest")
--set_wallpaper()
color_systray()
-- }}}

--- {{{ Autorun apps
  run_once_ifnot("kbdd", "slock") -- run slock only if kbdd didn't start e.g. first launch after login
  run_once_ifnot("nm-applet")
  run_once_ifnot("copyq")
  run_once_ifnot("kbdd")
  run_once_ifnot("telegram-desktop")
  run_once_ifnot("skypeforlinux")
  run_once_ifnot("slack", "slack -us")
  run_once_ifnot("xbanish", "xbanish -bt5000")
  run_once_ifnot("udiskie", "udiskie -as")
  run_once_ifnot("blueman", "blueman-applet")
  run_once_ifnot("picom", "picom --shadow-blue 0.05 -z -r 11 -t -8 -l -8 -D 5 -I 1 -O 1 --xrender-sync-fence --use-ewmh-active-win --backend xrender " )
  ----inactive-dim 0.35 --inactive-dim-fixed
-- }}}

--awesompd
--musicwidget:run()

-- Set keys
--musicwidget:append_global_keys()
root.keys(globalkeys)
-- }}}

-- mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
-- mywibox_w[mouse.screen].visible = not mywibox_w[mouse.screen].visible

-- local oldspawn = awful.util.spawn
-- awful.util.spawn = function (s)
--   oldspawn(s, false)
-- end
-- }}}
