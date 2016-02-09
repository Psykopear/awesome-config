local lain      = require("lain")
local wibox     = require("wibox")
local beautiful = require("beautiful")

-- ALSA volume bar
volicon = wibox.widget.imagebox(beautiful.vol)
volume = lain.widgets.alsabar({ card = "0", ticks = true, 
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(beautiful.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(beautiful.vol_no)
        elseif volume_now.level <= 50 then
            volicon:set_image(beautiful.vol_low)
        else
            volicon:set_image(beautiful.vol)
        end
    end,
    colors =
    {
        background = beautiful.bg_normal,
        mute = red,
        unmute = beautiful.bar_background
    }
})
volmargin = wibox.layout.margin(volume.bar, 5, 8, 80)
volmargin:set_top(7)
volmargin:set_bottom(7)
volumewidget = wibox.widget.background(volmargin)
volumewidget:set_bgimage(beautiful.vol_bg)
