local awful         = require("awful")
local beautiful     = require("beautiful")
local menubar       = require("menubar")

require("awesome_config_layouts")

-- Configure menubar
menubar.menu_gen.all_menu_dirs = { "/usr/share/applications/", "/usr/local/share/applications", "~/.local/share/applications" }
menubar.geometry = {
   height = 40,
   width = 1920,
   x = 0,
   y = 18
}


-- Globalkeys
globalkeys = awful.util.table.join(
    -- Move between workspaces
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    -- Change brightness
    awful.key({                   }, "XF86MonBrightnessDown", function() awful.util.spawn("xbacklight -dec 15") end),
    awful.key({                   }, "XF86MonBrightnessUp",   function() awful.util.spawn("xbacklight -inc 15") end),
    -- Shutdown pc with ctrl-esc
    awful.key({ "Control",        }, "Escape",                function() awful.util.spawn("systemctl poweroff") end),
    -- Control volume
    awful.key({                   }, "XF86AudioRaiseVolume",  function() awful.util.spawn("pactl set-sink-volume 1 +5%", false) end),
    awful.key({                   }, "XF86AudioLowerVolume",  function() awful.util.spawn("pactl set-sink-volume 1 -5%", false) end),
    -- Vim like controls to move between windows
    awful.key({ modkey,           }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end
    ),
    awful.key({ modkey,           }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end
    ),
    awful.key({ modkey,           }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end
    ),
    awful.key({ modkey,           }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end
    ),
    -- Win tab to switch focus
    awful.key({ modkey,           }, "Tab", 
        function () 
            awful.client.focus.byidx(1) 
            if client.focus 
                then client.focus:raise() 
            end 
        end
    ),
    -- Spawn terminal
    awful.key({ modkey,           }, "Return", function() awful.util.spawn(terminal) end),
    -- Restart and quit from awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    -- Switch layouts
    awful.key({ modkey,           }, "space", function() awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function() awful.layout.inc(layouts, -1) end),
    -- Menubar
    awful.key({ modkey,           }, "p",     function() menubar.show() end)
)
-- ClientKeys
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "q",     function(c) c:kill()                     end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end
    )
)

-- Bind all key number to tags
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = mouse.screen
                local tag = awful.tag.gettags(screen)[i]
                if tag then
                    awful.tag.viewonly(tag)
                end
            end
        ),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                local tag = awful.tag.gettags(client.focus.screen)[i]
                if client.focus and tag then
                    awful.client.movetotag(tag)
                end
            end
        )
    )
end

-- Finally set keys
root.keys(globalkeys)

-- Client buttons
clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Awful rules for all clients
awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = {},
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            keys = clientkeys,
            buttons = clientbuttons 
        } 
    },
}


