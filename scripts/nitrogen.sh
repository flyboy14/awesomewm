#!/bin/bash
echo 'local f = io.popen("cat ~/.config/nitrogen/bg-saved.cfg | grep file | sed 's/'file='//g'") local wpaper = f:read() f:close()  gears.wallpaper.maximized(wpaper,s,false)' | awesome-client
