local wezterm = require("wezterm")
local action = wezterm.action
local config = wezterm.config_builder()

config.font = wezterm.font("Monaco")
config.font_size = 15.0
config.audible_bell = "Disabled"
config.window_close_confirmation = "NeverPrompt"

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ""
            if has_selection then
                window:perform_action(action.CopyTo("ClipboardAndPrimarySelection"), pane)
                window:perform_action(action.ClearSelection, pane)
            else
                window:perform_action(action({ PasteFrom = "Clipboard" }), pane)
            end
        end),
    },
}

return config
