local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font = wezterm.font("Monaco")
config.font_size = 15.0
config.audible_bell = "Disabled"
return config
