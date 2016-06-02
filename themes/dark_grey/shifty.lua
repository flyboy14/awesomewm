shifty = require("shifty")
require("themes/dark_grey/bindings")
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,               -- 1
    lain.layout.uselesstile,                  -- 2
    lain.layout.uselesstile.bottom,            -- 3
    lain.layout.uselesspiral,                 -- 4
    lain.layout.cascade,                      -- 5    
    lain.layout.termfair,                     -- 6
    lain.layout.uselessfair,                  -- 7
    lain.layout.centerworkd,                  -- 8
    lain.layout.centerhwork,                  -- 9
}
shifty.config.layouts = layouts
-- }}}
-- Shifty configured tags.
shifty.config.tags = {  
    home = {
        layout    = layouts[3],
        exclusive = false,    
        position  = 1,
        leave_kills = true,
    },
    ide = {
        layout    = layouts[2],
        exclusive = true,    
        position  = 4,
        --init      = true,
        slave     = true,
    },
    web = {
        layout      = layouts[3],
        mwfact      = 0.65,
        exclusive   = true,
        position    = 2,
        --leave_kills = true,
        --spawn       = browser,
    },
    media = {
        layout    = layouts[6],
        exclusive = true,
        position  = 5,
    },
    edit = {
        layout   = layouts[8],
        position = 3,
        exclusive = true,
        leave_kills = true,
    },
    wine = {
        layout   = layouts[1],
        position = 6,
        nopopup = false,
        exclusive = true,  
    },
    virtual = {
        layout   = layouts[1],
        position = 7,
        --      leave_kills = true,
    },
    im = {
        layout   = layouts[8],
        position = 8,
        mwfact = 0.65,
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
            "Atom",
            "Subl*",
            "Libre", 
            "libreoffice-writer", 
            "Evince", 
            "DjView", 
        },
        tag = "edit",
    },
    {
        match = {
            "Pdfeditor", 
            "Wps", 
            "Wpp", 
            "Et", 
            "Libre", 
            "libreoffice-writer", 
            "Evince", 
            "DjView", 
        },
        tag = "doc",
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
            "kurs",
            class = {"sun-awt-X11*", "jetbrains-*"},
            "Eclipse", 
            "draftsight"
        },
        tag = "ide",
        ontop = false
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
            "Skype*",
            "TeamSpeak",
            "Viber",
            "Pidgin",
            "Telegram", 
        },
        tag = "im"
    },
    {
        match = {
            "Putty", 
            "slock", 
            --"Skype*", 
            "Nitrogen", 
            "Polkit-gnome-authentication-agent-1", 
            "terminology",
            "URxvt*", 
            "Zenity", 
            "pavucontrol", 
            "Wpa_gui", 
            "Lxappearance", 
            "Pidgin",  
            "Docky",
            "Insync.py",
            "kurs",
            name = {"Developer*", "Copy*", "New*"},
            role = {"pop-up", "GtkFileChooser*"}
        },
        ontop = true
    },
    {
        match = {
            "File-roller", 
            "Archive*",
            "Download", 
            "Covergloobus", 
            "Zenity", 
            "Doublecmd", 
            "Nitrogen", 
            "Wpa_gui", 
            "Pavucontrol", 
            "Lxappearance", 
            "Pidgin", 
            --"Skype*", 
            "plugin-container",
            "Putty",
            "Gcolor*",
            "Zenity",
            "terminology", 
            "URxvt*",
            "File-roller",
            "Archive*",
            "Insync.py",
            "kurs",
            name = {"Developer*", "Copy*", "New*", "Worker Configuration", "Directory bookmarks", "start prog", "Search:"},
            role = {"pop-up", "GtkFileChooser*"}
        },
        float = true,
    },
    {
        match = {
            "Viber", 
            --"Skype*", 
            "telegram*", 
            "Pidgin", 
            "Nitrogen",
            name = {"TeamViewer"}
        },
        leave_kills = "true",
        rel_index = 1
    },
    {
        match = {
            "Kodi",
            class = {"rdesktop*", "Robin", "dota2"}
        },
        fullscreen = true
    },
    {
        match = {
            "URxvt*",
            "terminology",
        },
        sticky = true
    },
    {
        match = {
            "Putty",
            "Gcolor*",
            "Zenity",
            "URxvt*",
            "terminology",
            "File-roller",
            "Archive*",
            "Insync.py",
            name = {"Developer*", "Copy*", "New*", "Worker Configuration", "Directory bookmarks", "start prog", "Search:"},
            role = {"pop-up", "GtkFileChooser*"}
        },
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
    floatBars = false,
    guess_name = true,
    guess_position = true,
    maximized_vertical   = false,
    maximized_horizontal = false,
}
shifty.taglist = mytaglist