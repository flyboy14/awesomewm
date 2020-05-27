shifty = require("shifty")
require("themes/dark_grey/bindings")
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,               -- 1
    lain.layout.uselesstile,                  -- 2
    lain.layout.uselesstile.bottom,           -- 3
    lain.layout.uselesspiral,                 -- 4
    lain.layout.cascade,                      -- 5    
    lain.layout.termfair,                     -- 6
    lain.layout.uselesspiral,                 -- 7
    lain.layout.centerworkd,                  -- 8
    lain.layout.centerhwork,                  -- 9
}
shifty.config.layouts = layouts
-- }}}
-- Shifty configured tags.
shifty.config.tags = { 
    doc = {
        position  = 0,
        rel_index = 1,
    }, 
    home = {
        layout    = layouts[6],
        exclusive = false,    
        position  = 1,
        leave_kills = true,
    },
    ide = {
        layout    = layouts[2],
        exclusive = false,    
        position  = 4,
        --init      = true,
        slave     = true,
        leave_kills = true,
    },
    web = {
        layout      = layouts[2],
        mwfact      = 0.65,
        exclusive   = false,
        position    = 2,
        max_clients = 2,
        leave_kills = true,
        --spawn       = browser,
    },
    media = {
        layout    = layouts[6],
        exclusive = false,
        position  = 5,
    },
    edit = {
        layout   = layouts[2],
        position = 3,
        exclusive = false,
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
        layout   = layouts[7],
        exclusive = true,
        position = 8,
        mwfact = 0.65,
        leave_kills = true,
    },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    {
        match = {
            "Navigator",
            "qutebrowser",
            "firefox",
            "vivaldi*",
            "google*", 
            "chromium", 
            "Opera*",
            "Pale moon",
        },
        tag = "web",
        ontop = false,
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
            "Doublecmd",
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
            "Simplenote",
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
            "draw.io"
        },
        tag = "doc",
    },
    {
        match = {
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
            "draftsight",
            "Linuxdcpp",
            "Anydesk"
        },
        tag = "ide",
        ontop = false
    },
    {
        match = {
            "Mplayer.*",
            "vlc",
            "mpv",
            "Sonata",
            "Deadbeef",
            "Android*",
            "baka-mplayer*"
        },
        tag = "media",
    },
    {
        match = {
            "VirtualBox*", 
            "Virt-manager*",
            "virt-manager", 
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
            "ghetto",
            "Skype*",
            "TeamSpeak",
            "Viber",
            "Pidgin",
            "Telegram", 
            "Zoom"
        },
        tag = "im",
        minimized = true
    },
    {
        match = {
            "Putty", 
            "slock", 
            "KeePassXC",
            "Nitrogen", 
            "Polkit-gnome-authentication-agent-1", 
            "terminology",
            "URxvt*",
            "Tilix", 
            "Zenity", 
            "pavucontrol", 
            "Wpa_gui", 
            "Lxappearance",  
            "Docky",
            "Insync.py",
            "kurs",
            "mplayer",
            "mpv",
            "bomi",
            "File-roller",
            "Guake",
            name = {"Developer*", "Copy*", "New*"},
            role = {"pop-up", "GtkFileChooser*"}
        },
        ontop = true
    },
    {
        match = {
            "Zenity", 
            "Nitrogen", 
            "Wpa_gui", 
            "Pavucontrol", 
            "Lxappearance", 
            "KeePassXC",
            "plugin-container",
            "Putty",
            "Gcolor*",
            "Zenity",
            "terminology", 
            "URxvt*",
            "Tilix",
            "File-roller",
            "*mplayer",
            "Archive*",
            "Insync.py",
            "mpv",
            "bomi",
            "Gnome-alsamixer",
            "*mplayer",
            "Gnome-sound-recorder",
            "feh",
            "Guake",
            "Gnome-alsamixer",
            "Webcamoid",
            name = {"Developer*", "Copy*", "Move*", "New*", "Worker Configuration", "Directory bookmarks", "start prog", "Search:"},
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
        leave_kills = false,
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
            "KeePassXC",
            "Guake"
        },
        sticky = true
    },
    {
        match = {
            "Putty",
            "Pavucontrol",
            "KeePassXC",
            "Gcolor*",
            "Zenity",
            "URxvt*",
            "Tilix",
            "mplayer",
            "mpv",
            "bomi",
            "terminology",
            "File-roller",
            "Gnome-alsamixer",
            "Archive*",
            "Gnome-sound-recorder",
            "Insync.py",
            "Webcamoid",
            "Guake",
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