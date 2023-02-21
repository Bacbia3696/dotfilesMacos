local fmt = string.format
local wezterm = require("wezterm")
local colors = require('colors')
local G = {}

local function is_vi_process(pane)
    return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function get_current_working_dir(tab)
    local current_dir = tab.active_pane.current_working_dir
    local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

    return current_dir == HOME_DIR and "  ~" or
        string.format("  %s",
            string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

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

G.update_right_status = function(window, _)
    local cells = {}

    local config = window:effective_config()
    local session_color = colors.yellow
    local session_name = ""

    -- insert session name
    local session_icon = utf8.char(0xf490)
    for _, v in ipairs(config.unix_domains) do
        if v.name ~= nil and v.name ~= "" then
            session_name = v.name
            break
        else
            session_name = window:active_workspace()
        end
    end
    session_name = window:active_workspace()
    table.insert(cells, wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = session_color } },
        { Text = " " .. session_icon .. " " .. session_name },
    }))

    -- insert battery percentage
    for _, b in ipairs(wezterm.battery_info()) do
        table.insert(cells, fmt("%.0f%%", b.state_of_charge * 100))
    end

    -- insert local datetime and utc
    local datetime = fmt("%s (UTC %s)", wezterm.strftime("%H:%M"),
        wezterm.strftime_utc("%H:%M"))
    table.insert(cells, datetime)

    -- The elements to be formatted
    local formatted_cells = {}
    -- How many cells have been formatted
    local formatted_cells_count = 0
    -- Translate a cell into elements
    local function push(text, is_last)
        table.insert(formatted_cells, { Text = "" .. text .. "" })
        if not is_last then
            table.insert(formatted_cells, { Text = " ⋮ " })
        end
        formatted_cells_count = formatted_cells_count + 1
    end

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell, #cells == 0)
    end

    -- push a spacer cell
    push(" ", #cells == 0)
    window:set_right_status(wezterm.format(formatted_cells))
end

G.conditional_activate_pane = function(window, pane, pane_direction,
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

G.format_tab_title = function(tab)
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
end

return G
