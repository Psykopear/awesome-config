local wibox     = require("wibox")
local beautiful = require("beautiful")
local awful     = require("awful")
local lain      = require("lain")

-- /home fs
diskicon = wibox.widget.imagebox(beautiful.disk)
diskbar = awful.widget.progressbar()
diskbar:set_color(beautiful.fg_normal)
diskbar:set_width(63)
diskbar:set_ticks(true)
diskbar:set_ticks_size(6)
diskbar:set_background_color(beautiful.bg_normal)
diskmargin = wibox.layout.margin(diskbar, 5, 8, 80)
diskmargin:set_top(7)
diskmargin:set_bottom(7)
fshomeupd = lain.widgets.fs({
    partition = "/",
    settings  = function()
        if fs_now.used < 90 then
            diskbar:set_color(beautiful.fg_normal)
        else
            diskbar:set_color("#EB8F8F")
        end
        diskbar:set_value(fs_now.used / 100)
    end
})
diskwidget = wibox.widget.background(diskmargin)
diskwidget:set_bgimage(beautiful.vol_bg)
