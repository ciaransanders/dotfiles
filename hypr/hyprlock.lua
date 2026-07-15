---@module 'hl'
---@diagnostic disable: undefined-global

hl.config({
	general = {
		hide_cursor = true,
		fail_timeout = 5000,
	},
})

-- uncomment to enable fingerprint authentication
-- auth {
--     fingerprint {
--         enabled = true
--         ready_message = Scan fingerprint to unlock
--         present_message = Scanning...
--         retry_delay = 250 # in milliseconds
--     }
-- }

hl.config({
	background = {
		-- set automatically on startup in ~/.config/hypr/hyprstartup.sh
		path = "~/.config/hypr/.current_wall",
	},
})

hl.config({
	input_field = {
		size = { 400, 60 },
		outline_thickness = 1,
		inner_color = { "rgba(0", 0, 0, "0.3)" },
		outer_color = { "rgba(0", 0, "0) rgba(0", 0, "0) 45deg" },
		check_color = { "rgba(168", 153, 132, "1) rgba(168", 153, 132, "1) 120deg" },
		fail_color = { "rgba(168", 153, 132, "1) rgba(168", 153, 132, "1) 40deg" },
		font_color = { "rgba(168", 153, 132, "1)" },
		fade_on_empty = false,
		rounding = 18,
		font_family = "JetBrainsMono Nerd Font",
		placeholder_text = {},
		fail_text = { "Incorrect", "please try again." },
		-- uncomment to use a letter instead of a dot to indicate the typed password
		-- dots_text_format = *
		-- dots_size = 0.4
		dots_spacing = 0.3,
		-- uncomment to use an input indicator that does not show the password length (similar to swaylock's input indicator)
		-- hide_input = true
		position = { 0, 0 },
		halign = "center",
		valign = "center",
	},
})

hl.config({
	label = {
		color = { "rgba(235", 219, 178, "1)" },
		text = { "Hello", USER },
		font_size = 18,
		font_family = "JetBrainsMono Nerd Font",
		position = { 0, 70 },
		halign = "center",
		valign = "center",
	},
})

hl.config({
	label = {
		color = { "rgba(235", 219, 178, "1)" },
		text = "cmd[update:1000] date+ %H:%M",
		font_size = 140,
		font_family = "JetBrainsMono Nerd Font",
		position = { 0, 450 },
		halign = "center",
		valign = "center",
	},
})

hl.config({
	label = {
		color = { "rgba(235", 219, 178, "1)" },
		text = "cmd[] date+ %a, %d %Y",
		font_size = 48,
		font_family = "JetBrainsMono Nerd Font",
		position = { 0, 300 },
		halign = "center",
		valign = "center",
	},
})
