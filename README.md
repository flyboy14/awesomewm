Tested with latest awesome-git

# Requirments

* awesome-git
* terminus-font
* ttf-visitor
* fortune-mod
* curl
* wget
* python2, python2-pillow (sripts)
* kbdd(keyboard layout)
* lua5.3
* pulseaudio,pamixer (widgets and bindings)
* nitrogen (wallpaper,optional)
* zenity (shutdown dialog,optional)
* gksu (graphical sudo, optional)
* xclip (patched promt.lua)
* gist (github gist mode)

# Features

* Two fully customized themes (color_arrows and dark_grey). Color arrows may be a bit outdated, cause I use only dark_grey for a while.

* various vicious/lain widgets

* archmenu extension

* calendar extension

* shifty/eminent dynamic tagging library

* awesompd extension (with some fixes)

* some nice icons from numix-icon-theme (and some others)

* wisdom spider quoting fortunes

* extra layouts from lain

* other yummies

# Usage

* Backup your ~/.config/awesome folder as ~/.config/awesome.bak, then replace it with my config cloning this repo into ~/.config/awesome

* Make a symbolic link prompt.lua.patched to /usr/share/awesome/lib/awful/prompt.lua (sudo ln -svf ~/.config/awesome/prompt.lua.patched /usr/share/awesome/lib/awful/prompt.lua)

* Edit local variables and keybindings in themes/_theme-name_/{vars, bindings}.lua
  * Custom rules for windows placing and behavior can be set in theme/_theme-name_/{shifty,myrules}.lua

* If issue any problems, feel free to report it on github or contact me at https://t.me/twiceaday28

* Have fun!

# Shortcuts cheat-sheet

* Navigation / tag management
  * modkey + "1..9" : view # tag
  * Shift + modkey + "1..9" : move client to # tag
  * modkey + Control + "1..9" : merge active tag with # tag
  * modkey + "e" : view next active tag
  * modkey + "q" : view prev active tag
  * Shift + modkey + "e" : move active client to next active tag
  * Shift + modkey + "q" : move active client to prev active tag
  * modkey + "Down" : create new tag
  * modkey + "Up" : rename active tag
  * modkey + "d" : delete active tag (only if it has no clients)
  * modkey + Space : select next layout for clients on active tag
  * modkey + Control + Space : select prev layout for client on active tag

* Client controls
  * modkey + mouse1 : grab and move active client
  * L_Alt + mouse1 : grab and resize active client
  * modkey + mouse{4,5} (scroll wheel) : change active client's opacity up/down
  * L_Alt + Tab : cycle through unminimized clients on active tag
  * modkey + Tab : cycle through all clients on active tag
  * L_Alt + Escape : minimize active client
  * modkey + Escape : minimize all clients except active one
  * L_Alt + "F4" : kill active client
  * modkey + "F4" : kill all clients on current tag except active one
  * modkey + "p" : increase master width factor by 0.05
  * modkey + "Control" + "p" : decrease master width factor by 0.05

* Prompts
  * L_Alt + "F2" : command prompt
  * modkey + "F2" : awesome-client's lua prompt
  * VoidSymbol(CapsLock) : Cheeky as-you-type client switcher (bound via setxkbmap -option caps:none )
  * modkey + "c" : calculator prompt

* Keychains
  * modkey + "w" + .. : client mode
    * "w" : toggle floating state
    * "f" : toggle fullscreen state
    * "t" : toggle ontop state
    * "x" : unmaximize vertically and horizontally
  * modkey + "t" + .. : translate mode
    * "e" : translate ENG to RUS prompt
    * "r" : translate RU to ENG prompt
    * "c" + .. : translate from clipboard
      * "e" : ENG to RUS
      * "r" : RUS to ENG
  * modkey + "g" + .. : gist mode
    * "a" : pull clipboard containments to gist.github.com and copy link to clipboard
    * "o" : pull clipboard containments to gist.github.com and open link in browser

* Launchers
  * modkey + "b" : run or raise browser
  * modkey + {Enter,KP_Enter} : run or rise terminal
  * modkey + {Enter,KP_Enter} : launch a new instance of terminal
  * modkey + "\`" : run or raise graphical file manager
  * modkey + Control + "\`" : launch graphical file manager (sudo)
  * modkey + "s" : run or raise skype client
  * modkey + "l" : run or raise graphical text editor
  * modkey + Control + "l" : launch graphical text editor (sudo)
  * {XF86PowerOff, XF86Launch1} : launch shutdown dialog
  * modkey + Control + Escape : activate lockscreen
  * XF86Sleep : suspend computer
  * XF86MonBrightnessUp : run bright up script
  * XF86monBrightnessDown : run bright down script
  * XF86AudioMute : mute audio output
  * XF86AudioRaiseVolume : raise audio volume (no unmute)
  * XF86AudioLowerVolume : lower audio volume (no unmute)
  * XF86AudioToggle : toggle play/pause audio state

* Awesome controls
  * modkey + Control + "r" : restart awesome
  * modkey + "h" : toggle useless gaps
  * mouse2 on spider : toggle awesome theme (replaces rc.lua)
  * modkey + "f" : show/hide bottom wibox with tray

* Screenshots (dark_grey theme)
  * ![Alt text](/screenshot/dark_grey_1?raw=true "1")
  * ![Alt text](/screenshot/dark_grey_2?raw=true "2")
  * ![Alt text](/screenshot/dark_grey_3?raw=true "3")
