local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("Monaco")
config.font_size = 15.0
config.audible_bell = "Disabled"
config.window_close_confirmation = "NeverPrompt"

config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = wezterm.action({ SendKey = { key = "]", mods = "CTRL" } })
    },
    {
        event = { Up = { streak = 1, button = "Right" } },
        mods = "CTRL",
        action = wezterm.action({ SendKey = { key = "o", mods = "CTRL" } })
    }
}

return config
