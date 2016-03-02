shifty = require("shifty")
require("themes/dark_grey/bindings")
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,               -- 1
    awful.layout.suit.tile,                   -- 2
    awful.layout.suit.tile.left,              -- 3
    awful.layout.suit.tile.bottom,            -- 4
    --awful.layout.suit.tile.top,               -- 5
    --awful.layout.suit.fair,                   -- 6
    --awful.layout.suit.fair.horizontal,        -- 7
    awful.layout.suit.spiral,                 -- 8
    --awful.layout.suit.spiral.dwindle,         -- 9
    awful.layout.suit.max,                    -- 10
    awful.layout.suit.max.fullscreen,         -- 11
    awful.layout.suit.magnifier               -- 12
}
shifty.config.layouts = layouts
-- }}}
-- Shifty configured tags.
--"⌂ ", "℺ ", "¶ ", "⚒ ", "♫ ","♿ ", "⚔ ", "➴ "
shifty.config.tags = {  
    home = {
        layout    = layouts[1],
        mwfact    = 0.60,
        exclusive = true,    
        position  = 1,
        screen    = 1,
        leave_kills = true,
    },
    ide = {
        layout    = layouts[3],
        mwfact    = 0.60,
        exclusive = true,    
        position  = 4,
        --init      = true,
        screen    = 1,
        leave_kills = true,
        slave     = true,
    },
    web = {
        layout      = layouts[4],
        mwfact      = 0.65,
        exclusive   = true,
        max_clients = 3,
        position    = 2,
        leave_kills = true,
        --spawn       = browser,
    },
    media = {
        layout    = layouts[1],
        exclusive = false,
        position  = 5,
        leave_kills = true,
    },
    editor = {
        layout   = layouts[3],
        position = 3,
        exclusive = true,
        leave_kills = true,
    },
    wine = {
        layout   = layouts[1],
        position = 6,
        nopopup = true,
        leave_kills = true,
    },
    virtual = {
        layout   = layouts[1],
        position = 7,
        leave_kills = true,
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
            "Thunar",
        },
        tag = "home",
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
         buttons = clientbuttons
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