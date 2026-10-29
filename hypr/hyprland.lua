---@module 'hl'
---@diagnostic disable: undefined-global

--###############
--## MONITORS ###
--###############

-- Framework laptop screen
hl.monitor({
	output = "eDP-1",
	mode = "2256x1504@60",
	position = "auto",
	scale = 1.333,
})

-- Home setup: 1440p on top, 1080p@165 stacked below
hl.monitor({
	output = "HDMI-A-2",
	mode = "2560x1440@60",
	position = "0x0",
	scale = 1,
})
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@165",
	position = "auto-center-up",
	scale = 1,
})

-- East Office TV
-- hl.monitor({
-- 	output = "DP-4",
-- 	mode = "1920x1080@120",
-- 	position = "auto-center-up",
-- 	scale = 1,
-- })

-- Asus monitor
-- hl.monitor({
-- 	output = "DP-4",
-- 	mode = "2560x1440@60",
-- 	position = "auto",
-- 	scale = 1,
-- })

-- AOC curved monitor
-- hl.monitor({
-- 	output = "DP-4",
-- 	mode = "1920x1080@165.00",
-- 	position = "auto",
-- 	scale = 1,
-- })

-- Laptop screen when mirroring to the home TV
-- hl.monitor({
-- 	output = "eDP-1",
-- 	mode = "1920x1080@60",
-- 	position = "auto",
-- 	scale = 1.175,
-- })

-- War room TV / home TV, mirroring eDP-1
-- hl.monitor({
-- 	output = "DP-4",
-- 	mode = "1920x1080@60",
-- 	position = "mirror",
-- 	scale = 1,
-- })

--############################
--## ENVIRONMENT VARIABLES ###
--############################

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- hyprland's `env` takes a literal value, so expand the command here instead
local xdg = io.popen("xdg-user-dir PICTURES")
local pictures = xdg:read("*l")
xdg:close()
hl.env("HYPRSHOT_DIR", pictures .. "/screenshots")

--################
--## AUTOSTART ###
--################

hl.on("hyprland.start", function()
	hl.exec_cmd("$HOME/.config/hypr/scripts/hyprstartup.sh")
	hl.exec_cmd("[workspace special:obsidian silent] obsidian")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)

--####################
--## LOOK AND FEEL ###
--####################

hl.config({
	general = {
		gaps_in = 10,
		gaps_out = 30,
		border_size = 0,
		layout = "dwindle",
		no_focus_fallback = true,
	},
})

hl.config({
	decoration = {
		rounding = 12,
		shadow = { enabled = false },
		blur = { enabled = false },
	},
})

hl.config({
	dwindle = {
		preserve_split = true,
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
	},
})

hl.config({
	cursor = {
		inactive_timeout = 1,
	},
})

--###########
--## MISC ###
--###########

hl.config({
	misc = {
		disable_hyprland_logo = true,
	},
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.config({
	debug = {
		-- VFR causes issues with the integrated graphics on the Framework 13
		vfr = false,
	},
})

--##################
--## KEYBINDINGS ###
--##################

local mainMod = "SUPER"

-- Windows
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Toggle big outer gaps on the active workspace, so a lone window shrinks into a centered box.
-- Gaps are per-workspace, so this creates a workspace rule on first use and toggles it after that.
local focusRules = {}
hl.bind(mainMod .. " + G", function()
	local ws = hl.get_active_workspace()
	if not ws then
		return
	end
	local rule = focusRules[ws.name]
	if rule then
		rule:set_enabled(not rule:is_enabled())
	else
		local mon = ws.monitor or hl.get_active_monitor()
		local w, h = mon.width / mon.scale, mon.height / mon.scale
		local x, y = math.floor(w * 0.2), math.floor(h * 0.12)
		focusRules[ws.name] = hl.workspace_rule({
			workspace = ws.name,
			gaps_out = { top = y, right = x, bottom = y, left = x },
		})
	end
end)

-- Apps
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("rofi -modi emoji:rofimoji -show emoji"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("dunstctl set-paused toggle"))

-- Eww
hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd("eww open --toggle dashboard --screen $(hyprctl activewindow -j | jq '.monitor')")
)
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("$HOME/.config/eww/powermenu/powermenu.sh"))
hl.bind("escape", hl.dsp.exec_cmd("eww close-all"), { non_consuming = true })

-- Scratchpads. SUPER+P fires both binds: launch Bitwarden (if needed) and toggle its workspace
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("[workspace special:bitwarden silent] bitwarden-desktop"))
-- Size bitwarden's gaps based off of currently focused monitors resolution
local bitwardenRules = {}
hl.bind(mainMod .. " + P", function()
	local mon = hl.get_active_monitor()
	if mon then
		for name, rule in pairs(bitwardenRules) do
			rule:set_enabled(name == mon.name)
		end
		if not bitwardenRules[mon.name] then
			local w, h = mon.width / mon.scale, mon.height / mon.scale
			local x, y = math.floor(w * 0.18), math.floor(h * 0.13)
			bitwardenRules[mon.name] = hl.workspace_rule({
				workspace = "special:bitwarden",
				gaps_in = 50,
				gaps_out = { top = y, right = x, bottom = y, left = x },
			})
		end
	end
	hl.dispatch(hl.dsp.workspace.toggle_special("bitwarden"))
end)
hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special("obsidian"))

-- Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces: SUPER+[0-9] to switch, SUPER+SHIFT+[0-9] to move the active window (0 is workspace 10)
for ws = 1, 10 do
	local key = ws % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = ws }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- Cycle through existing workspaces, Ubuntu style
hl.bind("CTRL + ALT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT + left", hl.dsp.focus({ workspace = "e-1" }))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -z -m region"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -z -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -z -m output"))

-- Volume and brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true })

-- Media
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--######################
--## WORKSPACE RULES ###
--######################

hl.workspace_rule({
	workspace = "special:obsidian",
	gaps_in = 50,
	gaps_out = { top = 100, right = 250, bottom = 100, left = 250 },
})

--###################
--## WINDOW RULES ###
--###################

hl.window_rule({
	name = "all-windows",
	match = { class = ".*" },
	suppress_event = "maximize",
	idle_inhibit = "fullscreen",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "xwayland-drag-fix",
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

hl.window_rule({
	name = "scratchpads",
	match = { class = ".*(Bitwarden|obsidian).*" },
	stay_focused = true,
})

hl.window_rule({
	name = "runelite",
	match = { class = "net-runelite-.*" }, -- matches both launcher-Launcher and client-RuneLite
	float = true,
	center = true,
	size = { 1000, 800 }, -- pins Hyprland's saved floating size so movewindow can't revert it
})

hl.window_rule({
	name = "bolt-launcher",
	match = { class = ".*bolt.*" },
	float = true,
	center = true,
	size = { "(monitor_w/2.2)", "(monitor_h/1.8)" },
})

hl.window_rule({
	name = "translucent-apps",
	match = { class = ".*(ghostty|zathura).*" },
	opacity = "1 0.6",
	border_color = "rgb(EBDBB2)",
	border_size = 1,
})

-- Keep terminals running cbonsai/lavat fully opaque, overriding the rule above
hl.window_rule({
	name = "opaque-terminal-art",
	match = { title = ".*(cbonsai|lavat).*" },
	opacity = "1.0",
})

-- Turn off XDG top level drag
hl.window_rule({
	name = "no-csd-drag",
	match = {
		class = ".*",
	},
	no_xdg_drags = true,
})
