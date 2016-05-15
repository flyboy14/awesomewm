shifty = require("shifty")
require("themes/dark_grey/bindings")
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,               -- 1
    awful.layout.suit.tile,                   -- 2
    awful.layout.suit.tile.left,              -- 3
    awful.layout.suit.tile.bottom,            -- 4
    awful.layout.suit.tile.top,               -- 5
    awful.layout.suit.spiral,                 -- 6
    awful.layout.suit.max,                    -- 7
    awful.layout.suit.max.fullscreen,         -- 8    
    awful.layout.suit.magnifier,              -- 9
}
shifty.config.layouts = layouts
-- }}}
-- Shifty configured tags.
--"⌂ ", "℺ ", "¶ ", "⚒ ", "♫ ","♿ ", "⚔ ", "➴ "
shifty.config.tags = {  
    home = {
        layout    = layouts[2],
        mwfact    = 0.60,
        exclusive = false,    
        position  = 1,
        screen    = 1,
        --leave_kills = true,
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
        layout      = layouts[5],
        mwfact      = 0.65,
        exclusive   = true,
        position    = 2,
        leave_kills = true,
        --spawn       = browser,
    },
    media = {
        layout    = layouts[7],
        exclusive = true,
        position  = 5,
        leave_kills = true,
    },
    editor = {
        layout   = layouts[6],
        position = 3,
        exclusive = true,
        leave_kills = true,
    },
    wine = {
        layout   = layouts[1],
        position = 6,
        nopopup = false,
        exclusive = true,  
        leave_kills = true,
    },
    virtual = {
        layout   = layouts[1],
        position = 7,
        --      leave_kills = true,
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
            "vivaldi*",
            "google*", 
            "chromium", 
            "Opera*",
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
            "Caja",
            name = {"Copy*"}
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
            class = {"sun-awt-X11*", "jetbrains-*"},
            "Eclipse", 
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
            "Archive*",
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
            "URxvt*", 
            "Skype*", 
            "plugin-container",
                    
        },
        float = true,
    },
    {
        match = {
            "VirtualBox*", 
            "Virt-manager", 
            "Remmina", 
            class = { "rdesktop"},
        },
        tag = "virtual"
    },
    {
        match = {
            "Wine", 
            "Steam",
            "dota2",
            class = {".exe", 
            ".EXE",  
            ".tmp", 
            ".TMP", 
            "._mp",
            "._MP"},
            "Baumalein", 
            "teeworlds"
        },
        tag = "wine",
        float = true
    },
    {
        match = {
            "Putty", 
            "slock", 
            "Skype*", 
            "Nitrogen", 
            "Polkit-gnome-authentication-agent-1", 
            "terminology",
            "URxvt*", 
            "Zenity", 
            "pavucontrol", 
            "Wpa_gui", 
            "Lxappearance", 
            "Pidgin", 
            "Oblogout", 
            "Docky",
            name = {"Developer*", "Copy*", "New*"},
            role = {"pop-up", "GtkFileChooser*"}
        },
        ontop = true
    },
    {
        match = {
            "Viber", 
            "Skype*", 
            "telegram*", 
            "Pidgin", 
            "Nitrogen",
            name = {"TeamViewer"}
        },
        --layout  = awful.layout.suit.magnifier,
        leave_kills = "true",
        rel_index = 1
    },
    {
        match = {
            "Oblogout", 
            "Kodi",
            class = {"rdesktop*", "Robin"}
        },
        fullscreen = true
    },
    {
        match = {
            terminal,
            "Putty",
            "Gcolor*",
            "URxvt*",
            "File-roller",
            "Archive*",
            name = {"Developer*", "Copy*", "New*", "Worker Configuration", "Directory bookmarks", "start prog"},
            role = {"pop-up", "GtkFileChooser*"}
        },
        float = true,
        --slave = true,
        intrusive = true,
    },
    {
        match = {""},
        buttons = clientbuttons,
        maximized_vertical   = false,
        maximized_horizontal = false,
        honorsizehints = false,
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
    layout = layouts[2],
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
    maximized_vertical   = false,
    maximized_horizontal = false,
}

shifty.taglist = mytaglist