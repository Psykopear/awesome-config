local awful     = require("awful")

require("awesome_config_layouts")

-- Tags
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({"Web", "Dev", "Chat", "File", "Music", "Other"}, s, layouts[1])
end
