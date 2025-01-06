local wezterm = require("wezterm")

return {
    keys = {
        {
            key = "L",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Right" },
        },
        {
            key = "H",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Left" },
        },
        {
            key = "K",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Up" },
        },
        {
            key = "J",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Down" },
        },
        {
            key = "F",
            mods = "CTRL|SHIFT",
            action = wezterm.action.ToggleFullScreen,
        },
        {
            key = "%",
            mods = "CTRL|SHIFT",
            action = wezterm.action.SplitHorizontal,
        },
        {
            key = "\"",
            mods = "CTRL|SHIFT",
            action = wezterm.action.SplitVertical,
        },
        {
            key = "p",
            mods = "CTRL|SHIFT",
            action = wezterm.action { AdjustPaneSize = { "Up", 5 } }
        },
        {
            key = "n",
            mods = "CTRL|SHIFT",
            action = wezterm.action { AdjustPaneSize = { "Down", 5 } }
        },
        {
            key = "z",
            mods = "CTRL|SHIFT",
            action = "TogglePaneZoomState",
        },
        {
            key = "?",
            mods = "CTRL|SHIFT",
            action = wezterm.action{Search={CaseInSensitiveString=""}},
        },
    },
    force_reverse_video_cursor = true,
    colors = {
        foreground = "#dcd7ba",
        background = "black",

        cursor_bg = "#c8c093",
        cursor_fg = "#c8c093",
        cursor_border = "#c8c093",

        selection_fg = "#c8c093",
        selection_bg = "#2d4f67",

        scrollbar_thumb = "#16161d",
        split = "#16161d",

        ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
        brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
        indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
    },
    -- color_scheme = "Kanagawa Dragon (Gogh)",
    -- Disable audio bell
    audible_bell = "Disabled",

    -- Cursor shape
    default_cursor_style = "SteadyBlock",

    -- Font settings
    font = wezterm.font("CaskaydiaCove Nerd Font"),
    font_size = 12.0,

    -- Bold, italic, and bold-italic fonts
    font_rules = {
        {
            italic = true,
            font = wezterm.font("CaskaydiaCove Nerd Font", { italic = true }),
        },
        {
            intensity = "Bold",
            font = wezterm.font("CaskaydiaCove Nerd Font", { bold = true }),
        },
        {
            italic = true,
            intensity = "Bold",
            font = wezterm.font("CaskaydiaCove Nerd Font", { bold = true, italic = true }),
        },
    },

    -- Enable ligatures
    harfbuzz_features = { "calt", "liga", "dlig", "clig" },

    -- Window decorations
    window_decorations = "RESIZE",

    -- Window padding
    window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
    },


    inactive_pane_hsb = { -- inactive pane settings
        saturation = 0.6,  -- Lower value reduces color intensity
        brightness = 0.4,  -- Lower value dims the brightness
    },

    -- Tab bar settings
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = false,
    tab_max_width = 25,
    tab_bar_style = {
        new_tab = wezterm.format({
            { Text = " + " },
        }),
    },

    -- MacOS specific settings
    macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
}
