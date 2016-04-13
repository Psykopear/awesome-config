local awful = require("awful")

-- Run once
function run_once(cmd)
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace-1)
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- Redshift to save my eyes
run_once("redshift -l 43.1411627:12.2244593 -t 5700:3600  -m randr")
-- Unagi Composite Manager
-- run_once("unagi &")
-- Use compton instead
run_once("compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible")
-- DropwDown terminal
run_once("tilda &")
-- Network Manager applet
run_once("nm-applet &")
-- Megasync
run_once("megasync")
-- ROFI launcher
run_once("rofi -key-run SuperL+o -terminal gnome-terminal")
