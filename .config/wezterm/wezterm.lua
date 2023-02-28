local wezterm = require("wezterm")
local utils = require('utils')
local keys = require('keys')
local theme = require("theme")

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

local dimmer = { brightness = 0.07 }

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
    enable_scroll_bar = true,
    min_scroll_bar_height = '2cell',
    background = {
        -- This is the deepest/back-most layer. It will be rendered first
        {
            source = { File = './Backgrounds/spaceship_bg_1.png' },
            -- The texture tiles vertically but not horizontally.
            -- When we repeat it, mirror it so that it appears "more seamless".
            -- An alternative to this is to set `width = "100%"` and have
            -- it stretch across the display
            repeat_x = 'Mirror',
            hsb = dimmer,
            -- When the viewport scrolls, move this layer 10% of the number of
            -- pixels moved by the main viewport. This makes it appear to be
            -- further behind the text.
            attachment = { Parallax = 0.1 },
        },
        -- Subsequent layers are rendered over the top of each other
        {
            source = {
                File = '/Users/nguyenthanhdat/.config/wezterm/Backgrounds/spaceship_bg_1.png',
            },
            width = '100%',
            repeat_x = 'NoRepeat',

            -- position the spins starting at the bottom, and repeating every
            -- two screens.
            vertical_align = 'Bottom',
            repeat_y_size = '200%',
            hsb = dimmer,

            -- The parallax factor is higher than the background layer, so this
            -- one will appear to be closer when we scroll
            attachment = { Parallax = 0.2 },
        },
        {
            source = {
                File = '/Users/nguyenthanhdat/.config/wezterm/Overlays/overlay_2_alienball.png',
            },
            width = '100%',
            repeat_x = 'NoRepeat',

            -- start at 10% of the screen and repeat every 2 screens
            vertical_offset = '10%',
            repeat_y_size = '200%',
            hsb = dimmer,
            attachment = { Parallax = 0.3 },
        },
        {
            source = { File = './Overlays/overlay_3_lobster.png' },
            width = '100%',
            repeat_x = 'NoRepeat',

            vertical_offset = '30%',
            repeat_y_size = '200%',
            hsb = dimmer,
            attachment = { Parallax = 0.4 },
        },
        {
            source = {
                File = '/Users/nguyenthanhdat/.config/wezterm/Overlays/overlay_4_spiderlegs.png',
            },
            width = '100%',
            repeat_x = 'NoRepeat',

            vertical_offset = '50%',
            repeat_y_size = '150%',
            hsb = dimmer,
            attachment = { Parallax = 0.5 },
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
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    window_background_opacity = 1,
    tab_max_width = 50,
    hide_tab_bar_if_only_one_tab = true,
    disable_default_key_bindings = false,
    default_cursor_style = 'BlinkingBar',
    colors = theme,
    hyperlink_rules = {
        { regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",      format = "$0" },
        { regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",    format = "$0" },
        { regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],                format = "mailto:$0" },
        { regex = [[\bfile://\S*\b]],                           format = "$0" },
        { regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
        { regex = [[\b[tT](\d+)\b]],                            format = "https://example.com/tasks/?t=$1" },
    },
}
