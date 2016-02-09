local lain      = require("lain")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")

-- Battery
baticon = wibox.widget.imagebox(beautiful.bat)
batbar = awful.widget.progressbar()
batbar:set_color(beautiful.fg_normal)
batbar:set_width(63)
batbar:set_ticks(true)
batbar:set_ticks_size(7)
batbar:set_background_color(beautiful.bg_normal)
batmargin = wibox.layout.margin(batbar, 5, 8, 80)
batmargin:set_top(7)
batmargin:set_bottom(7)
batupd = lain.widgets.bat({
    settings = function()
       if bat_now.perc == "N/A" or bat_now.status == "Not present" then
            bat_perc = 100
            -- batbar:set_color(green)
            baticon:set_image(beautiful.ac)
       elseif bat_now.status == "Charging" then
            bat_perc = tonumber(bat_now.perc)
            baticon:set_image(beautiful.ac)

            if bat_perc >= 98 then
                batbar:set_color(green)
            elseif bat_perc > 50 then
                batbar:set_color(beautiful.fg_normal)
            elseif bat_perc > 15 then
                batbar:set_color(beautiful.fg_normal)
            else
                batbar:set_color(red)
            end
       else
            bat_perc = tonumber(bat_now.perc)

            if bat_perc >= 98 then
                batbar:set_color(green)
            elseif bat_perc > 50 then
                batbar:set_color(beautiful.fg_normal)
                baticon:set_image(beautiful.bat)
            elseif bat_perc > 15 then
                batbar:set_color(beautiful.fg_normal)
                baticon:set_image(beautiful.bat_low)
            else
                batbar:set_color(red)
                baticon:set_image(beautiful.bat_no)
            end
       end
       batbar:set_value(bat_perc / 100)
    end,
    battery = "BAT1"
})
batwidget = wibox.widget.background(batmargin)
batwidget:set_bgimage(beautiful.vol_bg)

