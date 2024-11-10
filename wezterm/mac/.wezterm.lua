-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Configrations
-- Colors & Appearance
config.color_scheme = "Tokyo Night (Gogh)"
config.window_background_opacity = 0.97
config.default_cursor_style = "SteadyBar"
config.use_ime = true
config.audible_bell = "Disabled"

-- Launching Programs
config.launch_menu = {
	{
		args = { "top" },
	},
	{
		label = "Docker: debian:bullseye",
		args = { "/usr/local/bin/docker", "run", "-it", "debian:bullseye" },
	},
}

-- Key binding
local act = wezterm.action
config.keys = {
	-- Pane
	{
		key = "s",
		mods = "SHIFT|CMD",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "SHIFT|CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- Tab
	{
		key = "{",
		mods = "SHIFT|CMD",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "}",
		mods = "SHIFT|CMD",
		action = act.MoveTabRelative(1),
	},
}

return config
