local wezterm = require("wezterm")
local action = wezterm.action
local config = wezterm.config_builder()

local function target_os()
   local target = wezterm.target_triple
   if target:find("linux") then
        return "linux"
    elseif target:find("darwin") then
        return "apple"
    else
        return "windows"
    end
end

-- Font
if target_os() == "apple" then
    config.font = wezterm.font("Monaco")
    config.font_size = 15.0
else
    -- consolas font is designed by Microsoft
    config.font = wezterm.font("consolas")
    config.font_size = 13.0
end

config.audible_bell = "Disabled"
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"

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
