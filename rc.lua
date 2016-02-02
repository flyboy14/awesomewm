-- Standard awesome library
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
my_launcher = require("launcher_my")
my_launcher_n = require("launcher_my_nocommand")
wibox = require("wibox")
beautiful = require("beautiful")
vicious = require("vicious")
awesompd = require("awesompd/awesompd")
naughty = require("naughty")
eminent = require("eminent")
xdg_menu = require("archmenu")
lain = require("lain")
--scratch = require("scratch")
require("awful.autofocus")
require("vars")
require("functions")
require("menus")
require("widgets")
require("mywiboxes")
require("bindings")
require("mysignals")

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

for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

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

--awesompd
musicwidget:run()

-- Set keys
musicwidget:append_global_keys()
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons,
      size_hints_honor = false,
      maximized_vertical   = false,
      maximized_horizontal = false,
      switchtotag = true
    }
  },
  {
    rule_any = { class = { "Virt-manager", "Remmina", "VirtualBox" } },
    properties = { tag = tags[1][6] }
  },
  {
    rule_any = { class = { "Kodi", "Sonata", "Vlc", "Samowar", "Deadbeef" } },
    properties = { tag = tags[1][5] }
  },
  {
    rule_any = { class = { "Pcmanfm", "Worker", "Dolphin", "Nautilus", "Nemo", "Thunar" } },
    properties = { tag = tags[1][1] }
  },
  {
    rule_any = { class = { "Pdfeditor", "Wps", "Wpp", "Et", "Libre", "libreoffice-writer", "Subl3", "Evince", "DjView",  "Atom" } },
    properties = { tag = tags[1][3], dockable = false, urgent = false, fixed = false }
  },
  {
    rule_any = { class = { "GitKraken", "Audacity", "Ninja-ide", "Inkscape" ,"Gimp", "QtCreator", "SpiderOak", "Shotcut" ,"Openshot", "DraftSight", "jetbrains-clion" ,"Eclipse", "jetbrains-studio", "draftsight"} },
    properties = { tag = tags[1][4] }
  },
  {
    rule_any = { class = { "Wine", "Steam" ,".exe", ".EXE", "dota2", ".tmp", ".TMP", "Baumalein", "teeworlds" } },
    properties = { tag = tags[1][7] },
  },
  {
    rule_any = { class = { "firefox", "google-chrome", "chromium", "Vivaldi", "Navigator", "Pale moon" } },
    properties = { tag = tags[1][2] },
  },
  {
    rule_any = { class = { "Haguichi", "Covergloobus", "Eiskaltdcpp", "Viber", "TeamSpeak", "Cutegram", "Telegram", "Cheese", "Kamerka", "Pidgin", "Transmission" } },
    properties = { tag = tags[1][8] }
  },
  {
    rule_any = { class = { "Putty", "File-roller", "Worker", "Download", "Oblogout", "Org.gnome.Weather.Application", "Covergloobus", "Zenity", "Doublecmd", "Nitrogen", "Wpa_gui", "Pavucontrol", "Lxappearance", "Pidgin", "terminology", "URxvt", "Skype", "Skype-Electron" }, instance = {"plugin-container"} },
    properties = { floating = true }
  },
  {
    rule_any = { class = { "Skype", "Steam", "VIrtualBox", "Skype-Electron" } },
    properties = { switchtotag = false }
  },
  {
    rule_any = { class = { "Oblogout", "Covergloobus", "dota_linux" } },
    properties = { border_width = 0 }
  },
  {
    rule_any = { class = { "Oblogout", "Putty", "slock", "Skype", "Nitrogen", "Polkit-gnome-authentication-agent-1", "terminology","URxvt", "Zenity", "pavucontrol", "Wpa_gui", "Lxappearance", "Pidgin", "Skype-Electron" } },
    properties = { ontop = true }
  },
  {
    rule_any = { class = { "Kodi", "Oblogout" } },
    properties = { fullscreen = true }
  },
  {
    rule_any = { class = { "slock", "Oblogout" } },
    properties = { sticky = true }
  },

}
-- }}}

-- mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
-- mywibox_w[mouse.screen].visible = not mywibox_w[mouse.screen].visible

-- local oldspawn = awful.util.spawn
-- awful.util.spawn = function (s)
--   oldspawn(s, false)
-- end
-- }}}
