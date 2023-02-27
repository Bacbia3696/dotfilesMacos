local wezterm = require("wezterm")
local colors = require('colors')
local utils = require('utils')
local keys = require('keys')

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
        "Operator Mono SSm Lig",
        "SF Pro",
        "Apple Color Emoji",
    }),
    bold_brightens_ansi_colors = true,
    font_rules = {
        {
            intensity = 'Half',
            font = wezterm.font { family = "Operator Mono SSm Lig", weight = 400 },
        },
        {
            intensity = 'Bold',
            font = wezterm.font { family = "Operator Mono SSm Lig", weight = 400 },
        },
    },
    font_size = 14,
    enable_wayland = false,
    pane_focus_follows_mouse = false,
    warn_about_missing_glyphs = false,
    show_update_window = false,
    check_for_updates = false,
    line_height = 1.15,
    cell_width = 1,
    window_decorations = "RESIZE",
    window_close_confirmation = "NeverPrompt",
    audible_bell = "Disabled",
    window_padding = { left = 5, right = 5, top = 5, bottom = 5 },
    initial_cols = 110,
    initial_rows = 25,
    inactive_pane_hsb = { saturation = 1.0, brightness = 0.80 },
    enable_scroll_bar = true,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    window_background_opacity = 0.85,
    tab_max_width = 50,
    hide_tab_bar_if_only_one_tab = true,
    disable_default_key_bindings = false,
    default_cursor_style = 'BlinkingBar',
    colors = {
        split = colors.surface0,
        foreground = colors.text,
        background = colors.base,
        cursor_bg = colors.rosewater,
        cursor_border = colors.rosewater,
        cursor_fg = colors.base,
        selection_bg = colors.surface2,
        selection_fg = colors.text,
        visual_bell = colors.surface0,
        indexed = { [16] = colors.peach,[17] = colors.rosewater },
        scrollbar_thumb = colors.surface2,
        compose_cursor = colors.flamingo,
        ansi = {
            colors.surface1,
            colors.red,
            colors.green,
            colors.yellow,
            colors.blue,
            colors.pink,
            colors.teal,
            colors.subtext0,
        },
        brights = {
            colors.subtext0,
            colors.red,
            colors.green,
            colors.yellow,
            colors.blue,
            colors.pink,
            colors.teal,
            colors.surface1,
        },
        tab_bar = {
            background = colors.crust,
            active_tab = {
                bg_color = "none",
                fg_color = colors.subtext1,
                intensity = "Bold",
                underline = "None",
                italic = false,
                strikethrough = false,
            },
            inactive_tab = { bg_color = colors.crust, fg_color = colors.surface2 },
            inactive_tab_hover = {
                bg_color = colors.mantle,
                fg_color = colors.subtext0,
            },
            new_tab = { bg_color = colors.crust, fg_color = colors.subtext0 },
            new_tab_hover = {
                bg_color = colors.crust,
                fg_color = colors.subtext0,
            },
        },
    },
    hyperlink_rules = {
        { regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",      format = "$0" },
        { regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",    format = "$0" },
        { regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],                format = "mailto:$0" },
        { regex = [[\bfile://\S*\b]],                           format = "$0" },
        { regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
        { regex = [[\b[tT](\d+)\b]],                            format = "https://example.com/tasks/?t=$1" },
    },
}
