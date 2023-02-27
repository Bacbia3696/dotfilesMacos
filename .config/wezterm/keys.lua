local act = require "wezterm".action
return {
    -- fix wezterm can't send <C-Q> keystroke
    { mods = "CTRL", key = "q",               action = act { SendString = "\x11" } },
    {
        mods = "CMD",
        key = [[\]],
        action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    },
    {
        mods = "CMD|SHIFT",
        key = [[|]],
        action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }),
    },
    { key = "z",     mods = "CMD",            action = act.TogglePaneZoomState },
    { key = "F11",   mods = "",               action = act.ToggleFullScreen },
    { key = "h",     mods = "CMD|CTRL",       action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "j",     mods = "CMD|CTRL",       action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "k",     mods = "CMD|CTRL",       action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "l",     mods = "CMD|CTRL",       action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = '[',     mods = 'CMD',            action = act.ActivatePaneDirection 'Prev' },
    { key = ']',     mods = 'CMD',            action = act.ActivatePaneDirection 'Next' },
    { key = 'J',     mods = 'CMD|SHIFT',      action = act.MoveTabRelative( -1) },
    { key = 'K',     mods = 'CMD|SHIFT',      action = act.MoveTabRelative(1) },
    { key = 'J',     mods = 'CMD|SHIFT|CTRL', action = act.ScrollByPage(0.25) },
    { key = 'K',     mods = 'CMD|SHIFT|CTRL', action = act.ScrollByPage( -0.25) },
    -- { key = "v", mods = "ALT", action = wezterm.action.ActivateCopyMode },
    { key = "=",     mods = "CMD",            action = act.IncreaseFontSize },
    { key = "-",     mods = "CMD",            action = act.DecreaseFontSize },
}
