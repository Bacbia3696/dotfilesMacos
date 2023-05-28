local wezterm = require("wezterm")
local utils = require("utils")
local keys = require("keys")
local theme = require("theme")
-- local background = require("background")

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	utils.conditional_activate_pane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	utils.conditional_activate_pane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	utils.conditional_activate_pane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	utils.conditional_activate_pane(window, pane, "Down", "j")
end)
wezterm.on("format-tab-title", utils.format_tab_title)
wezterm.on("update-right-status", utils.update_right_status)

return {
	keys = keys,
	adjust_window_size_when_changing_font_size = false,
	font = wezterm.font_with_fallback({
		{ family = "MonoLisa", weight = "Medium" },
		-- { family = "Symbols Nerd Font Mono", scale = 0.75 },
		"Apple Color Emoji",
	}),
	bold_brightens_ansi_colors = true,
	font_rules = {},
	enable_scroll_bar = true,
	min_scroll_bar_height = "2cell",
	font_size = 14,
	enable_wayland = false,
	pane_focus_follows_mouse = true,
	warn_about_missing_glyphs = false,
	show_update_window = false,
	check_for_updates = false,
	line_height = 1.1,
	cell_width = 0.85,
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	audible_bell = "Disabled",
	window_padding = { left = 5, right = 5, top = 5, bottom = 5 },
	initial_cols = 110,
	initial_rows = 25,
	inactive_pane_hsb = { saturation = 1.0, brightness = 0.80 },
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 0.8,
	tab_max_width = 50,
	hide_tab_bar_if_only_one_tab = true,
	disable_default_key_bindings = false,
	default_cursor_style = "BlinkingBar",
	colors = theme,
	hyperlink_rules = {
		{ regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b", format = "$0" },
		{ regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b", format = "$0" },
		{ regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], format = "mailto:$0" },
		{ regex = [[\bfile://\S*\b]], format = "$0" },
		{ regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
		{ regex = [[\b[tT](\d+)\b]], format = "https://example.com/tasks/?t=$1" },
	},
}
