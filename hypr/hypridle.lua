---@module 'hl'
---@diagnostic disable: undefined-global

hl.config({
	general = {
		-- avoid starting multiple hyprlock instances.
		lock_cmd = "pidof hyprlock || hyprlock",
		-- lock before suspend.
		before_sleep_cmd = "loginctl lock-session",
		-- to avoid having to press a key twice to turn on the display.
		after_sleep_cmd = "hyprctl dispatch dpms on",
	},
})

hl.config({
	listener = {
		-- 9.5min.
		timeout = 570,
		-- set monitor backlight to minimum, avoid 0 on OLED monitor.
		on_timeout = "brightnessctl -s set 10",
		-- monitor backlight restore.
		on_resume = "brightnessctl -r",
	},
})

hl.config({
	listener = {
		-- 10min
		timeout = 600,
		-- lock screen when timeout has passed
		on_timeout = "loginctl lock-session",
	},
})

hl.config({
	listener = {
		-- 10.5min
		timeout = 630,
		-- screen off when timeout has passed
		on_timeout = "hyprctl dispatch dpms off",
		-- screen on when activity is detected after timeout has fired.
		on_resume = "hyprctl dispatch dpms on && brightnessctl -r",
	},
})

hl.config({
	listener = {
		-- 30min
		timeout = 1800,
		-- suspend pc
		on_timeout = "systemctl suspend",
	},
})
