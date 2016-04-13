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

-- Separator
bar_spr = wibox.widget.textbox('<span font="Tamsyn 8"> </span>' .. markup("#0599ca", "||||") .. '<span font="Tamsyn 8"> </span>')
half_bar_spr = wibox.widget.textbox('<span font="Tamsyn 8"> </span>' .. markup("#0599ca", "||") .. '<span font="Tamsyn 8"> </span>')
--
-- {{{ Wibox
-- vicious.register(volumewidget, vicious.widgets.volume)
-- vicious.register(batwidget, vicious.widgets.battery)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mytaglist = {}
mylayoutbox = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
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
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do

    -- Layout text
    -- local layout_string  = awful.layout.getname(awful.layout.get(s)):gsub("^%l", string.upper)
    -- layout_textbox[s] = wibox.widget.textbox(markup("#DDC246", layout_string))


    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
    -- Layoutbox
    mylayoutbox[s] = awful.widget.layoutbox(s)
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "18" })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    -- left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(half_bar_spr)
    left_layout:add(mylayoutbox[s])
    left_layout:add(half_bar_spr)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(half_bar_spr)
    -- Add systray
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(half_bar_spr)
    -- Disk icon and widget
    right_layout:add(diskicon)
    right_layout:add(diskwidget)
    -- Volume icon and widget
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    -- Battery icon and widget
    right_layout:add(baticon)
    right_layout:add(batwidget)
    -- Clock widget
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
