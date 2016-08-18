-- External libraries needed
local gears     = require("gears")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local awful     = require("awful")

awful.rules     = require("awful.rules")
                  require("awful.autofocus")

-- Modkey (Windows key)
modkey = "Mod4"

-- Directories
config_dir = (os.getenv("HOME").."/.config/awesome")
themes_dir = (config_dir .. "/theme/")
beautiful.init(themes_dir .. "/theme.lua")

-- Signals connections
-- TODO: Move to a separate file

-- Remove border on maximixed windows
-- Here I check only for miximized_horizontal because i won't use it without
-- maximized_vertical in general, so that's enough for me to say that the window
-- is maximized
client.connect_signal("property::maximized_horizontal", function (c)
    if c.maximized_horizontal then
        c.border_width = 0
    else
        -- TODO: take border from the theme
        c.border_width = 5
    end
end
)

client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)
end)

-- Add current directory to package path
package.path = package.path .. ";" .. config_dir .. "/partials/?.lua"

-- Notify errors (startup and runtime)
require("awesome_config_notify_errors")

-- Default programs
require("awesome_config_default_programs")

-- Wallpaper
require("awesome_config_wallpaper")

-- Tags (virtual desktops)
require("awesome_config_tags")

-- Menu
require("awesome_config_menu")

-- Mouse bindings
require("awesome_config_mouse_bindings")

-- KeyBindings
require("awesome_config_key_bindings")

-- Wibox
require("awesome_config_wibox")

-- Autostart
require("awesome_config_autostart")

-- Turns off the terminal bell
awful.util.spawn_with_shell("/usr/bin/xset b off")

-- Set caps lock to ctrl
awful.util.spawn_with_shell("/usr/bin/setxkbmap -option ctrl:nocaps")
