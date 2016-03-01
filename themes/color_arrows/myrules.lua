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
    rule_any = { class = { "GitKraken", "Rawstudio" "Audacity", "Ninja-ide", "Inkscape" ,"Gimp", "QtCreator", "SpiderOak", "Shotcut" ,"Openshot", "DraftSight", "jetbrains-clion" ,"Eclipse", "jetbrains-studio", "draftsight"} },
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