local lain      = require("lain")
local wibox     = require("wibox")

-- ALSA volume bar
volume = lain.widgets.alsabar({ card = "0", ticks = true,
    colors = {
        mute = '#de5e1e',
        unmute = '#d7ff87'
    }
})
volmargin = wibox.layout.margin(volume.bar, 5, 8, 50)
volmargin:set_top(7)
volmargin:set_bottom(7)
volumewidget = wibox.widget.background(volmargin)
