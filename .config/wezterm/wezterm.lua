local wezterm = require('wezterm')
local action = wezterm.action

local padding = {
    left = '1cell',
    right = '1cell',
    top = '0.5cell',
    bottom = '0.5cell',
}

function is_editor(pane)
    local process_name = pane:get_foreground_process_name()
    if process_name then
        return process_name:find('vim')
    end
    return false
end

wezterm.on('update-status', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if is_editor(pane) then
        overrides.window_padding = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0
        }
    else
        overrides.window_padding = padding
    end
    window:set_config_overrides(overrides)
end)

return {
    color_scheme = 'Catppuccin Mocha',
    font = wezterm.font('Hack Nerd Font Mono'),
    font_size = 11.0,

    window_padding = padding,
    window_decorations = 'NONE',

    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    window_frame = {
        font = wezterm.font { family = 'Inter Nerd Font', weight = 'Medium' },
    },

    window_close_confirmation = 'NeverPrompt',
    adjust_window_size_when_changing_font_size = false,
    show_new_tab_button_in_tab_bar = false,
    warn_about_missing_glyphs = false,

    keys = {
        -- Useful default binds:
        -- Ctrl + Shift + x => ActivateCopyMode
        -- Ctrl + Shift + space => QuickSelect
        -- Ctrl + Shift + p => CommandPalette
        {
            mods = 'ALT',
            key = 'h',
            action = action.SendKey { key = 'LeftArrow' }
        },
        {
            mods = 'ALT',
            key = 'j',
            action = action.SendKey { key = 'DownArrow' }
        },
        {
            mods = 'ALT',
            key = 'k',
            action = action.SendKey { key = 'UpArrow' }
        },
        {
            mods = 'ALT',
            key = 'l',
            action = action.SendKey { key = 'RightArrow' }
        },

        {
            mods = 'CTRL|SHIFT',
            key = 'Backspace',
            action = action.ResetFontSize
        },
        {
            mods = 'ALT',
            key = 'Enter',
            action = action.SendKey { mods = 'ALT', key = 'Enter' }
        },
        {
            key = 'F11',
            action = action.ToggleFullScreen,
        },

        {
            mods = 'CTRL|ALT',
            key = 't',
            action = action.SpawnWindow
        },

        {
            mods = 'CTRL|SHIFT',
            key = 'LeftArrow',
            action = action.MoveTabRelative(-1)
        },
        {
            mods = 'CTRL|SHIFT',
            key = 'RightArrow',
            action = action.MoveTabRelative(1)
        },
        { mods = 'CTRL|ALT', key = '0', action = action.ActivateTab(-1) },
        { mods = 'CTRL|ALT', key = '1', action = action.ActivateTab(0) },
        { mods = 'CTRL|ALT', key = '2', action = action.ActivateTab(1) },
        { mods = 'CTRL|ALT', key = '3', action = action.ActivateTab(2) },
        { mods = 'CTRL|ALT', key = '4', action = action.ActivateTab(3) },
        { mods = 'CTRL|ALT', key = '5', action = action.ActivateTab(4) },
        { mods = 'CTRL|ALT', key = '6', action = action.ActivateTab(5) },
        { mods = 'CTRL|ALT', key = '7', action = action.ActivateTab(6) },
        { mods = 'CTRL|ALT', key = '8', action = action.ActivateTab(7) },
        { mods = 'CTRL|ALT', key = '9', action = action.ActivateTab(8) },
    },
}
