
-- {{{ Menu
-- Create a laucher widget and a main menu
mmyawesomemenu = {
    { " edit", editor .. " " .. awesome.conffile, iconsdir .. "/clipboard.svg" },
    { " restart", awesome.restart, iconsdir .. "/media-circling-arrow.svg" },
    { " quit", "pkill -9 awesome", iconsdir .. "/media-no.svg" }
}

myworkspacemenu = {
    { "Home",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[1]
        if tag then
          awful.client.movetotag(tag) awful.tag.viewonly(tag)
        end
      end
    end
    },
    { "Browse",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[2]
        if tag then
          awful.client.movetotag(tag) awful.tag.viewonly(tag)
        end
      end
    end
    },
    { "Doc",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[3]
        if tag then
          awful.client.movetotag(tag) awful.tag.viewonly(tag)
        end
      end
    end
    },
    { "IDE",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[4]
        if tag then
          awful.client.movetotag(tag) awful.tag.viewonly(tag)
        end
      end
    end
    },
    { "Media",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[5]
        if tag then
          awful.client.movetotag(tag) awful.tag.viewonly(tag)
        end
      end
    end
    },
    { "Virtual",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[6]
        if tag then
          awful.client.movetotag(tag) awful.tag.viewonly(tag)
        end
      end
    end
    },
    { "Wine",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[7]
        if tag then
          awful.client.movetotag(tag) awful.tag.viewonly(tag)
        end
      end
    end
    },
    { "Etc",
    function ()
      if client.focus then
        local tag = awful.tag.gettags(client.focus.screen)[8]
        if tag then
          awful.client.movetotag(tag)
          awful.tag.viewonly(tag)
        end
      end
    end
    },
}
mytaskmenu = awful.menu({ items = {
                                    { "DEBUFF", 
                                      function ()
                                        c = client.focus
                                        c.ontop = false
                                        c.togglemarked = false
                                        c.sticky = false
                                        c.maximized = false
                                        c.maximized_vertical = false
                                        c.maximized_horizontal = false
                                      end,
                                    },
                                    { "Send to tag:", myworkspacemenu },
                                    { "  Toggle ontop",
                                      function ()
                                        client.focus.ontop = not client.focus.ontop 
                                        --set_cursor_in_middle_of_focused_client()
                                      end,
                                      iconsdir .. "/ontop.svg"
                                    },
                                    { "  Toggle fullscreen",
                                      function ()
                                        client.focus.fullscreen = not client.focus.fullscreen
                                      end,
                                      iconsdir .. "/display.svg"
                                    },
                                    { "  Minimize",
                                      function ()
                                        client.focus.minimized = true
                                      end,
                                      iconsdir .. "/view-restore.svg"
                                    },
                                    { "  Close",
                                      function()
                                        client.focus:kill()
                                      end, iconsdir .. "/media-no.svg"
                                    },
                                  }
})

mymainmenu = awful.menu({ items = {
                                    { "Apps", xdgmenu },
                                    { "Regenerate menu", scripts .. "/menu_gen.sh"},
                                    --{ "Worker", "worker" },
                                    { "  Wallpaper", "nitrogen", iconsdir .. "/greylink-dc.png" }
                                  }
})

mylauncher = awful.widget.launcher({ image = iconsdir .. "/tv_icon.gif", menu = mymainmenu})
