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
