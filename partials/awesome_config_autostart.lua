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
run_once("redshift -l 49.26:-123.23")
-- Unagi Composite Manager
run_once("unagi &")
-- DropwDown terminal 
run_once("tilda &")
-- Network Manager applet
run_once("nm-applet &")
-- Megasync
run_once("megasync")

