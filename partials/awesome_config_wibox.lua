local awful     = require("awful")
local wibox     = require("wibox")
local vicious   = require("vicious")
local beautiful = require("beautiful")

require("awesome_config_layouts")

-- Add widgets directory to package path
package.path = package.path .. ";" .. config_dir .. "/partials/widgets/?.lua"

-- Load widgets
require("awesome_config_volume_bar")
require("awesome_config_battery")
require("awesome_config_fs")
require("awesome_config_textclock")

-- Bar separator
bar_spr_txt = '<span font="Ubuntu 16">' .. markup("#d7ff87", " ❯") .. ' </span>'
bar_spr = wibox.widget.textbox(bar_spr_txt)

-- Configura taglist's buttons
mytaglist = {}
mytaglist.buttons = awful.util.table.join(

-- View only the selected tag with left mouse
awful.button({ }, 1, awful.tag.viewonly),

-- Add the selected tag to the viewed ones with right mouse
awful.button({ }, 3, awful.tag.viewtoggle),

-- Add the current window to another tag
awful.button({ modkey }, 3, awful.client.toggletag),

-- Scroll tags
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

-- Configure tasklists properties
mytasklist = {}
mytasklist.buttons = awful.util.table.join(

-- Left mouse toggle visibility
awful.button({ }, 1, function (c)
    if c == client.focus then
        c.minimized = true
    else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
    end
end),

-- Scroll over tasks will scroll the focus
awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end))

-- Battery widget
-- TODO: move to separate file
batterywidget = wibox.widget.textbox()
batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:connect_signal("timeout",
  function()
    fh = assert(io.popen("acpi | cut -d, -f 2 -", "r"))
    charging_state = io.popen("acpi | cut -d, -f 1 | cut -d' ' -f 3"):read()
    if charging_state == "Charging" then
        color = "#45D9FA"
    elseif charging_state == "Discharging" then
        color = "#FF0000"
    elseif charging_state == "Full" then
        color = "#00FF00"
    end
    batterywidget:set_markup('<span font="Ubuntu 14">' .. markup(color, fh:read("*l")) .. '</span>' .. bar_spr_txt)
    fh:close()
  end
)
batterywidgettimer:start()

-- Create the wibox
mywibox = {}
mypromptbox = {}
mylayoutbox = {}

-- 1 wibox for each screen
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Layoutbox
    mylayoutbox[s] = awful.widget.layoutbox(s)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", align = "center", screen = s, height = "30"})

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()

    -- promptbox
    left_layout:add(mypromptbox[s])
    left_layout:add(bar_spr)
    left_layout:add(mytaglist[s])
    left_layout:add(bar_spr)
    left_layout:add(mylayoutbox[s])
    left_layout:add(bar_spr)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    -- Add systray
    if s == 1 then
        right_layout:add(bar_spr)
        right_layout:add(wibox.widget.systray())
    end
    right_layout:add(bar_spr)

    -- Clock widget
    right_layout:add(batterywidget)
    right_layout:add(volumewidget)
    right_layout:add(wibox.widget.textbox(bar_spr_txt))
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
