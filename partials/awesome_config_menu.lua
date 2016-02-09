local awful     = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

-- Menu
myawesomemenu = {
    { "restart", awesome.restart },
    { "quit", awesome.quit }
}
mymainmenu = awful.menu(
    { items = { 
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal },
    }
})
menubar.utils.terminal = terminal


