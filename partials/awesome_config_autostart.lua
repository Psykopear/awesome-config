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
-- Use compton instead
-- run_once("compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible --shadow-red 0.9 --shadow-blue 0.5 --shadow-green 1.0  -r 10 -l -15 -t -15 -o 0.3")
run_once("compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible")
-- Network Manager applet
run_once("nm-applet &")
-- Megasync
run_once("megasync")
-- ROFI launcher
run_once("rofi -key-run SuperL+o -terminal gnome-terminal")
