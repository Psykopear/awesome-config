local lain = require("lain")

markup = lain.util.markup

theme                               = {}

theme.dir                           = os.getenv("HOME") .. "/.config/awesome/theme/"
theme.wallpaper                     = theme.dir .. "/wall.png"

theme.font                          = "Ubuntu 14"

-- | Layout | --

theme.layout_floating   = theme.dir .. "/icons/layouts/floating.png"
theme.layout_tile       = theme.dir .. "/icons/layouts/tile.png"
theme.layout_tileleft   = theme.dir .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop    = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_fairv      = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_fairh      = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_spiral     = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_dwindle    = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_max        = theme.dir .. "/icons/layouts/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/layouts/maxfullscreen.png"
theme.layout_magnifier  = theme.dir .. "/icons/layouts/magnifier.png"

-- Colors
theme.fg_normal                     = "#EEEEEE"
theme.fg_focus                      = "#FFFFFF"
theme.bg_normal                     = "#020202"
theme.bg_focus                      = "#020202"
theme.fg_urgent                     = "#000000"
theme.bg_urgent                     = "#FFFFFF"
theme.bar_background                = "#0f0f0f"
theme.border_width                  = 5
-- theme.border_normal                 = "#FFFFFF"
-- theme.border_marked                 = "#FFFF00"
theme.taglist_fg_focus              = "#00ddFF"
theme.taglist_bg_focus              = "png:" .. theme.dir .. "/icons/taglist_bg_focus.png"
-- theme.menu_height                   = ""
-- theme.menu_width                    = "150"

theme.ocol                          = "<span color='" .. theme.fg_normal .. "'>"
theme.ccol                          = "</span>"
theme.tasklist_sticky               = ""
theme.tasklist_ontop                = ""
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

theme.taglist_squares_sel           = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel         = theme.dir .. "/icons/square_unsel.png"
theme.disk                          = theme.dir .. "/icons/disk.png"
theme.vol_bg                        = theme.dir .. "/icons/vol_bg.png"
theme.vol                           = theme.dir .. "/icons/vol.png"
theme.vol_low                       = theme.dir .. "/icons/vol_low.png"
theme.vol_no                        = theme.dir .. "/icons/vol_no.png"
theme.vol_mute                      = theme.dir .. "/icons/vol_mute.png"
theme.ac                            = theme.dir .. "/icons/ac.png"
theme.bat                           = theme.dir .. "/icons/bat.png"
theme.bat_low                       = theme.dir .. "/icons/bat_low.png"
theme.bat_no                        = theme.dir .. "/icons/bat_no.png"

return theme
