local wezterm = require("wezterm")
local act = wezterm.action

local function is_vi_process(pane)
    return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditional_activate_pane(window, pane, pane_direction,
                                         vim_direction)
    if is_vi_process(pane) then
        window:perform_action(wezterm.action.SendKey({
            key = vim_direction,
            mods = "ALT",
        }), pane)
    else
        window:perform_action(wezterm.action.ActivatePaneDirection(
            pane_direction), pane)
    end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
    conditional_activate_pane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
    conditional_activate_pane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
    conditional_activate_pane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
    conditional_activate_pane(window, pane, "Down", "j")
end)

local colors = {
    rosewater = "#F4DBD6",
    flamingo = "#F0C6C6",
    pink = "#F5BDE6",
    mauve = "#C6A0F6",
    red = "#ED8796",
    maroon = "#EE99A0",
    peach = "#F5A97F",
    yellow = "#EED49F",
    green = "#A6DA95",
    teal = "#8BD5CA",
    sky = "#91D7E3",
    sapphire = "#7DC4E4",
    blue = "#8AADF4",
    lavender = "#B7BDF8",
    text = "#CAD3F5",
    subtext1 = "#B8C0E0",
    subtext0 = "#A5ADCB",
    overlay2 = "#939AB7",
    overlay1 = "#8087A2",
    overlay0 = "#6E738D",
    surface2 = "#5B6078",
    surface1 = "#f94D64",
    surface0 = "#363A4F",
    base = "#24273A",
    mantle = "#1E2030",
    crust = "#181926",
}

local function get_process(tab)
    local process_icons = {
        ["docker"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["docker-compose"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["nvim"] = {
            { Foreground = { Color = colors.green } },
            { Text = wezterm.nerdfonts.custom_vim },
        },
        ["vim"] = {
            { Foreground = { Color = colors.green } },
            { Text = wezterm.nerdfonts.dev_vim },
        },
        ["node"] = {
            { Foreground = { Color = colors.green } },
            { Text = wezterm.nerdfonts.mdi_hexagon },
        },
        ["zsh"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_terminal },
        },
        ["bash"] = {
            { Foreground = { Color = colors.subtext0 } },
            { Text = wezterm.nerdfonts.cod_terminal_bash },
        },
        ["htop"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
        },
        ["cargo"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_rust },
        },
        ["go"] = {
            { Foreground = { Color = colors.sapphire } },
            { Text = wezterm.nerdfonts.mdi_language_go },
        },
        ["lazydocker"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["git"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_git },
        },
        ["lazygit"] = {
            { Foreground = { Color = colors.peach } },
            { Text = wezterm.nerdfonts.dev_git },
        },
        ["lua"] = {
            { Foreground = { Color = colors.blue } },
            { Text = wezterm.nerdfonts.seti_lua },
        },
        ["wget"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.mdi_arrow_down_box },
        },
        ["curl"] = {
            { Foreground = { Color = colors.yellow } },
            { Text = wezterm.nerdfonts.mdi_flattr },
        },
        ["gh"] = {
            { Foreground = { Color = colors.mauve } },
            { Text = wezterm.nerdfonts.dev_github_badge },
        },
    }

    local process_name = string.gsub(tab.active_pane.foreground_process_name,
        "(.*[/\\])(.*)", "%2")

    if process_name == "" then
        process_name = "zsh"
    end

    return wezterm.format(process_icons[process_name] or {
        { Foreground = { Color = colors.sky } },
        { Text = string.format("[%s]", process_name) },
    })
end

local function get_current_working_dir(tab)
    local current_dir = tab.active_pane.current_working_dir
    local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

    return current_dir == HOME_DIR and "  ~" or
        string.format("  %s",
            string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab)
    return wezterm.format({
        { Attribute = { Intensity = "Half" } },
        { Text = string.format(" %s  ", tab.tab_index + 1) },
        "ResetAttributes",
        { Text = get_process(tab) },
        { Text = " " },
        { Text = get_current_working_dir(tab) },
        { Foreground = { Color = colors.base } },
        { Text = "  ▕" },
    })
end)

wezterm.on("update-right-status", function(window)
    window:set_right_status(wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Text = wezterm.strftime(" %A, %d %B %Y %I:%M %p ") },
    }))
end)

return {
    adjust_window_size_when_changing_font_size = false,
    font = wezterm.font_with_fallback({
        "Operator Mono SSm Lig",
        "Operator Mono Lig",
        "SF Pro",
    }),
    bold_brightens_ansi_colors = true,
    font_rules = {
        {
            intensity = 'Bold',
            font = wezterm.font { family = "Operator Mono Lig", weight = 900 },
        },
        {
            intensity = 'Normal',
            font = wezterm.font { family = "Operator Mono SSm Lig", weight = 400 },
        },
    },
    font_size = 14,
    enable_wayland = false,
    pane_focus_follows_mouse = false,
    warn_about_missing_glyphs = false,
    show_update_window = false,
    check_for_updates = false,
    line_height = 1.2,
    cell_width = 1,
    window_decorations = "RESIZE",
    window_close_confirmation = "NeverPrompt",
    audible_bell = "Disabled",
    window_padding = { left = 5, right = 5, top = 5, bottom = 5 },
    initial_cols = 110,
    initial_rows = 25,
    inactive_pane_hsb = { saturation = 1.0, brightness = 0.85 },
    enable_scroll_bar = true,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    window_background_opacity = 0.9,
    tab_max_width = 50,
    hide_tab_bar_if_only_one_tab = true,
    disable_default_key_bindings = false,
    default_cursor_style = 'BlinkingBar',
    -- front_end = "WebGpu",
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
    keys = {
        -- fix wezterm can't send <C-Q> keystroke
        {
            mods = "CTRL",
            key = "q",
            action = wezterm.action { SendString = "\x11" },
        },
        {
            mods = "CMD",
            key = [[\]],
            action = wezterm.action({
                SplitHorizontal = { domain = "CurrentPaneDomain" },
            }),
        },
        {
            mods = "CMD|SHIFT",
            key = [[|]],
            action = wezterm.action({
                SplitVertical = { domain = "CurrentPaneDomain" },
            }),
        },
        { key = "z",   mods = "CMD", action = wezterm.action.TogglePaneZoomState },
        { key = "F11", mods = "",    action = wezterm.action.ToggleFullScreen },
        {
            key = "h",
            mods = "CMD|CTRL",
            action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
        },
        {
            key = "j",
            mods = "CMD|CTRL",
            action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
        },
        {
            key = "k",
            mods = "CMD|CTRL",
            action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
        },
        {
            key = "l",
            mods = "CMD|CTRL",
            action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
        },
        { key = '[', mods = 'CMD',       action = act.ActivatePaneDirection 'Prev' },
        { key = ']', mods = 'CMD',       action = act.ActivatePaneDirection 'Next' },
        { key = 'J', mods = 'CMD|SHIFT', action = act.MoveTabRelative( -1) },
        { key = 'K', mods = 'CMD|SHIFT', action = act.MoveTabRelative(1) },
        -- { key = "v", mods = "ALT", action = wezterm.action.ActivateCopyMode },
        { key = "=", mods = "CMD",       action = act.IncreaseFontSize },
        { key = "-", mods = "CMD",       action = act.DecreaseFontSize },
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
