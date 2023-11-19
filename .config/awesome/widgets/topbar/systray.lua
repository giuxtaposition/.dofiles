--Standard Modules
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Separator
local separator = wibox.widget.textbox(" ")
local initial_systray_status = false

local build_widget = function(widget)
	return wibox.widget({
		{
			widget,
			left = dpi(4),
			right = dpi(4),
			top = dpi(3),
			bottom = dpi(3),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_normal,
		shape = gears.shape.rounded_rect,
		widget = wibox.container.background,
	})
end

--Systray Widget
local systray = wibox.widget({
	wibox.widget.systray(),
	widget = wibox.container.margin,
	left = dpi(0),
	right = dpi(0),
	top = dpi(2),
	bottom = dpi(2),
	visible = initial_systray_status,
})

--Tray toggle widget
local tray_toggle_widget = wibox.widget({
	id = "icon",
	widget = wibox.widget.imagebox,
	image = beautiful.icons.right_arrow,
})

local tray_toggle = build_widget(tray_toggle_widget)

-- Main Widget
local systray_widget = wibox.widget({
	{
		{
			separator,
			systray,
			separator,
			tray_toggle,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.background,
		shape = gears.shape.rounded_bar,
		bg = beautiful.bg_normal,
	},
	left = dpi(3),
	right = dpi(3),
	top = dpi(5),
	bottom = dpi(5),
	widget = wibox.container.margin,
})

--Toggle function for systray
tray_toggle:connect_signal("button::press", function(_, _, _, button)
	systray.visible = not systray.visible
	if systray.visible then
		tray_toggle_widget:set_image(beautiful.icons.right_arrow)
	else
		tray_toggle_widget:set_image(beautiful.icons.left_arrow)
	end
end)

return systray_widget
