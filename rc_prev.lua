-- Standard awesome library
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
awful.remote = require("awful.remote")
my_launcher = require("launcher_my")
my_launcher_n = require("launcher_my_nocommand")
require("awful.autofocus")
wibox = require("wibox")
beautiful = require("beautiful")
vicious = require("vicious")
awesompd = require("awesompd/awesompd_colorarrows")
naughty = require("naughty")
eminent = require("eminent")
xdg_menu = require("archmenu")
lain = require("lain")
require("themes/color_arrows/vars")
require("themes/color_arrows/functions")
require("themes/color_arrows/menus")
require("themes/color_arrows/widgets")
require("themes/color_arrows/mywiboxes")
require("themes/color_arrows/bindings")
require("themes/color_arrows/myrules")
require("themes/color_arrows/mysignals")

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

-- wallpaper
set_wallpaper()

--- {{{ Autorun apps
  awful.util.spawn_with_shell(home .. "/.config/autostart/autostart.sh")
  run_once("kbdd", "slock") -- run slock only if kbdd didn't start e.g. first launch after login
  run_once("nm-applet")
  run_once("caffeine")
  run_once("parcellite")
  if inet_on then
    run_once("skype")
    run_once("dropbox")
  end
  run_once("kbdd")
  awful.util.spawn_with_shell("systemctl --user restart hidcur")
  run_once("compton", "compton -b --sw-opti --shadow-blue 0.05 --inactive-dim 0.25 -cfGz -r 4 -t -6 -l -6 -D 5 -I 0.03 -O 0.03 --xrender-sync --respect-prop-shadow --mark-ovredir-focused --config ~/.config/compton.conf")
  --"xcowsay 'Moo, brother, moo.'"
-- }}}

-- Set keys
musicwidget:append_global_keys()
root.keys(globalkeys)
-- }}}
