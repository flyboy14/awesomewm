local shifty = require("shifty")
require("themes/dark_grey/bindings")
-- Shifty configured tags.
--"⌂ ", "℺ ", "¶ ", "⚒ ", "♫ ","♿ ", "⚔ ", "➴ "
shifty.config.tags = {  
    home = {
        layout    = awful.layout.suit.float,
        mwfact    = 0.60,
        exclusive = true,    
        position  = 1,
        --init      = true,
        screen    = 1,
        slave     = true,
        persist = "true",
        leave_kills = "true"
    },
    ide = {
        layout    = awful.layout.suit.tile,
        mwfact    = 0.60,
        exclusive = true,    
        position  = 4,
        --init      = true,
        screen    = 1,
        slave     = true,
    },
    web = {
        layout      = awful.layout.suit.tile.bottom,
        mwfact      = 0.65,
        exclusive   = true,
        max_clients = 3,
        position    = 2,
        --spawn       = browser,
    },
    media = {
        layout    = awful.layout.suit.float,
        exclusive = false,
        position  = 5,
        nopopup = true
    },
    editor = {
        layout   = awful.layout.suit.tile,
        position = 3,
        exclusive = true,
    },
    wine = {
        layout   = awful.layout.suit.float,
        position = 6,
        nopopup = true
    },
    virtual = {
        layout   = awful.layout.suit.float,
        position = 7,
    },
    im = {

        --leave_kills = "true"
    },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    {
        match = {
            "Navigator",
            "Vimperator",
            "Gran Paradiso",
            "firefox", 
            "google*", 
            "chromium", 
            "Vivaldi", 
            "Pale moon"
        },
        tag = "web",
    },
    {
        match = {
            "Worker",
            "Pcmanfm",
            "Dolphin", 
            "Nautilus", 
            "Nemo", 
            "Thunar"
        },
        tag = "home",
        slave = true,
    },
    {
        match = {
            "Pdfeditor", 
            "Wps", 
            "Wpp", 
            "Et", 
            "Libre", 
            "libreoffice-writer", 
            "Subl3", 
            "Evince", 
            "DjView", 
            "Atom"
        },
        tag = "editor",
    },
    {
        match = {
            "GitKraken", 
            "Rawstudio", 
            "Audacity", 
            "Ninja-ide", 
            "Inkscape" ,
            "Gimp", 
            "QtCreator", 
            "SpiderOak", 
            "Shotcut" ,
            "Openshot", 
            "DraftSight", 
            "jetbrains-clion" ,
            "Eclipse", 
            "jetbrains-studio", 
            "draftsight"
        },
        tag = "ide",
    },
    {
        match = {
            "Mplayer.*",
            "Vlc",
            "Sonata",
        },
        tag = "media",
    },
    {
        match = {
            "Putty", 
            "File-roller", 
            "Worker", 
            "Download", 
            "Oblogout", 
            "Org.gnome.Weather.Application", 
            "Covergloobus", 
            "Zenity", 
            "Doublecmd", 
            "Nitrogen", 
            "Wpa_gui", 
            "Pavucontrol", 
            "Lxappearance", 
            "Pidgin", 
            "terminology", 
            "URxvt", 
            "Skype", 
            "plugin-container"
        },
        float = true,
    },
    {
        match = {
            "Wine", 
            "Steam" ,
            "*.exe", 
            "*.EXE", 
            "dota2", 
            "*.tmp", 
            "*.TMP", 
            "Baumalein", 
            "teeworlds"
        },
        tag = "wine",
    },
    {
        match = {
            "VirtualBox*", 
            "Virt-manager", 
            "Remmina", 
            "rdesktop*"
        },
        tag = "virtual",
    },
    {
        match = {
            "Oblogout", 
            "Putty", 
            "slock", 
            "Skype*", 
            "Nitrogen", 
            "Polkit-gnome-authentication-agent-1", 
            "terminology",
            "URxvt", 
            "Zenity", 
            "pavucontrol", 
            "Wpa_gui", 
            "Lxappearance", 
            "Pidgin", 
        },
        ontop = true
    },
    {
        match = {
            "Viber", 
            "Skype*", 
            "telegram*", 
            "Pidgin", 
        },
        --layout  = awful.layout.suit.magnifier,
        persist = "true",
        rel_index = 1
    },
    {
        match = {
            "Oblogout", 
            "Kodi"
        },
        fullscreen = true
    },
    {
        match = {
            terminal,
            "Putty",
            "Gcolor*"
        },
        honorsizehints = false,
        float = true,
        slave = true,
        intrusive = true,
    },
    {
        match = {""},
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({modkey}, 1, function(c)
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
                end),
            awful.button({alt}, 1, awful.mouse.client.resize)
            )
    },
}

-- SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.float,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
    maximized_vertical   = false,
    maximized_horizontal = false,
}

shifty.taglist = mytaglist