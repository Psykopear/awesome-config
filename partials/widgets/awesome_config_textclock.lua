local lain  = require("lain")

markup      = lain.util.markup
mytextclock = lain.widgets.abase({
    timeout  = 60,
    cmd      = "date +'%A %d %B %R'",
    settings = function()
    local t_output = ""
    local o_it = string.gmatch(output, "%S+")

    for i=1,3 do t_output = t_output .. " " .. o_it(i) end

    widget:set_markup(markup("#45d9Fa", t_output) .. markup("#FFFFFF", " > ") .. markup("#fe5e1e", o_it(1)) .. " ")
end})

-- Attach calendar
lain.widgets.calendar:attach(mytextclock, { font = "Ubuntu Mono", font_size = 12 })
