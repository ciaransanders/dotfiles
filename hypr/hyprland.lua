---@module 'hl'
---@diagnostic disable: undefined-global

--###############
--## MONITORS ###
--###############

-- Framework Laptop Screen
hl.monitor({
	output = "eDP-1",
	mode = "2256x1504@60",
	position = "auto",
	scale = 1.333,
})

-- Asus monitor
hl.monitor({
	output = "DP-4",
	mode = "2560x1440@60",
	position = "auto",
	scale = 1,
})

-- For mirroring my laptop to my home TV
-- hl.monitor({
-- 	output = "eDP-1",
-- 	mode = "1920x1080@60",
-- 	position = "auto",
-- 	scale = 1.175,
-- })

-- AOC Curved Montior
-- hl.monitor({
-- 	output = "DP-4",
-- 	mode = "1920x1080@165.00",
-- 	position = "auto",
-- 	scale = 1,
-- })

-- War Room TV / Home TV
-- monitor=DP-4,1920x1080@60,0x0,1,mirror,eDP-1
-- hl.monitor({
-- 	output = "DP-4",
-- 	mode = "1920x1080@60",
-- 	position = "mirror",
-- 	scale = 1,
-- })

--################
--## AUTOSTART ###
--################

hl.on("hyprland.start", function()
	hl.exec_cmd("$HOME/.config/hypr/scripts/hyprstartup.sh")
	hl.exec_cmd("[workspace special:obsidian silent] obsidian")
end)

--############################
--## ENVIRONMENT VARIABLES ###
--############################

hl.env("XCURSOR_SIZE", 24)

hl.env("HYPRCURSOR_SIZE", 24)

--##################
--## PERMISSIONS ###
--##################

--####################
--## LOOK AND FEEL ###
--####################
hl.config({
	general = {
		gaps_in = 10,
		gaps_out = 30,
		border_size = 0,
		-- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
		-- col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
		-- col.inactive_border = rgba(595959aa)
		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,
		-- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
		allow_tearing = false,
		layout = "dwindle",
		no_focus_fallback = true,
	},
})

hl.config({
	decoration = {
		rounding = 12,
		rounding_power = 2,
		-- Change transparency of focused and unfocused windows
		-- active_opacity = .9
		-- inactive_opacity = .6
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		-- https://wiki.hyprland.org/Configuring/Variables/#blur
		blur = {
			enabled = false,
		},
	},
})

hl.config({
	dwindle = {
		-- You probably want this
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		-- Set to 0 or 1 to disable the anime mascot wallpapers
		force_default_wallpaper = 1,
		-- If true disables the random hyprland logo / anime girl background. :(
		disable_hyprland_logo = true,
	},
})

hl.config({
	debug = {
		-- set to false because it seems to cause issue with the integrated graphics on my Framework 13 laptop
		vfr = false,
	},
})

hl.config({
	cursor = {
		inactive_timeout = 1,
	},
})

--#################
--## ANIMATIONS ###
--#################
hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

--############
--## INPUT ###
--############

hl.config({
	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = -0.15,
		accel_profile = "flat",
		touchpad = {
			natural_scroll = false,
		},
	},
})

--##################
--## KEYBINDINGS ###
--##################

local mainMod = "SUPER"
local shiftMod = "SHIFT"

-- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + " .. "C", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float())
hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen())

-- Run ghostty
hl.bind(mainMod .. " + " .. "Q", hl.dsp.exec_cmd("uwsm app -- ghostty"))

-- Run rofi
hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd("uwsm app -- rofi -show drun"))

-- Run rofimoji
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd("uwsm app -- rofi -modi emoji:rofimoji -show emoji"))

-- Toggle dunst notifications
hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd("dunstctl set-paused toggle"))

-- Eww dashboard toggle
hl.bind(
	mainMod .. " + " .. "D",
	hl.dsp.exec_cmd("eww open --toggle dashboard --screen $(hyprctl activewindow -j| jq '.monitor')")
)

-- Eww powermenu toggle
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "P", hl.dsp.exec_cmd("$HOME/.config/eww/powermenu/powermenu.sh"))

-- Hyprlock lock screen binding
hl.bind(mainMod .. " + " .. "L", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- Special workspace for Bitwarden
hl.workspace_rule({
	workspace = "special:bitwarden",
	gaps_in = 50,
	gaps_out = { top = 200, right = 450, bottom = 200, left = 450 },
})
hl.bind(mainMod .. " + " .. "P", hl.dsp.exec_cmd("[workspace special:bitwarden silent] bitwarden-desktop"))
hl.bind(mainMod .. " + " .. "P", hl.dsp.workspace.toggle_special("bitwarden"))

-- Special workspace for Obsidian
hl.workspace_rule({
	workspace = "special:obsidian",
	gaps_in = 50,
	gaps_out = { top = 100, right = 250, bottom = 100, left = 250 },
})
hl.bind(mainMod .. " + " .. "O", hl.dsp.workspace.toggle_special("obsidian"))

-- Toggle through existing workspaces using Ubuntu style keybindings
hl.bind("CTRL + ALT" .. " + " .. "right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT" .. " + " .. "left", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Close all open eww windows when escape is pressed
hl.bind("escape", hl.dsp.exec_cmd("eww close-all"), { non_consuming = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--#############################
--## WINDOWS AND WORKSPACES ###
--#############################

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	name = "windowrule-1",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
	idle_inhibit = "fullscreen",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "windowrule-2",
	match = {
		class = "^$",
		title = "^$",
		xwayland = 1,
		float = 1,
		fullscreen = 0,
		pin = 0,
	},
	no_focus = true,
})

-- unscale XWayland
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

--#############################
--## Hyprshot ###
--#############################

-- Screenshot a window
hl.bind(mainMod .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -z -m window"))

-- Screenshot a region
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -z -m region"))

-- Screenshot a monitor
hl.bind(shiftMod .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -z -m output"))

--#############################
--## Custom Window-Rules ###
--#############################

hl.window_rule({
	name = "bitwarden-windowrule",
	match = {
		class = ".*Bitwarden.*",
	},
	stay_focused = true,
})

hl.window_rule({
	name = "obsidian-windowrule",
	match = {
		class = ".*obsidian.*",
	},
	stay_focused = true,
})

hl.window_rule({
	name = "runelite-windowrule",
	match = {
		class = ".*RuneLite.*",
	},
	float = true,
})

hl.window_rule({
	name = "bolt-launcher-windowrule",
	match = {
		class = ".*bolt.*",
	},
	float = true,
	center = true,
	size = { "(monitor_w/2.2)", "(monitor_h/1.8)" },
})

hl.window_rule({
	name = "ghostty-windowrule",
	match = {
		class = ".*ghostty.*",
	},
	opacity = "1 0.6",
	border_color = "rgb(EBDBB2)",
	border_size = 1,
})

hl.window_rule({
	name = "cbonsai-windowrule",
	match = {
		title = "^(.*cbonsai.*)$",
	},
	opacity = "1.0",
})
