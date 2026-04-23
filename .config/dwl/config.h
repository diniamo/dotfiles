#define COLOR(NAME, hex)               \
	static const float NAME[] = {      \
		((hex >> 24) & 0xFF) / 255.0f, \
		((hex >> 16) & 0xFF) / 255.0f, \
		((hex >> 8)  & 0xFF) / 255.0f, \
		(hex         & 0xFF) / 255.0f  \
	};
COLOR(rootcolor,     0x222222ff)
COLOR(bordercolor,   0x444444ff)
COLOR(focuscolor,    0x005577ff)
COLOR(urgentcolor,   0xff0000ff)
COLOR(fullscreen_bg, 0x000000ff)
#undef COLOR

// 31 at most
#define                   TAGCOUNT                    9
static int                log_level                 = WLR_ERROR;
static const int          sloppyfocus               = 1; // Focus follows mouse
static const int          bypass_surface_visibility = 0; // Allow idle inhibitors without visible surfaces
static const unsigned int borderpx                  = 1;
static const int          smartborders              = 1;

static const Env envs[] = {
	{ "WLR_RENDERER", "vulkan" },
	{ "WLR_DRM_NO_ATOMIC", "1" },
	{ "XDG_CURRENT_DESKTOP", "X-Generic" },
	{ "SDL_VIDEODRIVER", "wayland,x11,windows" }
};

static const char *const autostart[] = {
	"pipewire", NULL,
	"gammastep", NULL,
	"playerctld", NULL,
	NULL
};

static const Rule rules[] = {
	// app_id,    title,                 tag mask,       isfloating, monitor
	{  "Firefox", "Picture-in-Picture",  0,              1,          -1 }
};

static const char *cursor_theme  = "Bibata-Modern-Classic";
static const char  cursor_size[] = "24";

static int global_tearing  = 0;
static int global_adaptive = 0;

static const Layout layouts[] = {
	{ "tile",    tile },
	{ "monocle", monocle },
};

static const struct xkb_rule_names xkb_rules = {
	.layout  = "hu",
	.options = "altwin:swap_lalt_lwin,caps:swapescape",
};
static const int                                 repeat_rate             = 25;
static const int                                 repeat_delay            = 600;

static const int                                 tap_to_click            = 0;
static const int                                 tap_and_drag            = 0;
static const int                                 drag_lock               = 1;
static const int                                 natural_scrolling       = 0;
static const int                                 disable_while_typing    = 1;
static const int                                 left_handed             = 0;
static const int                                 middle_button_emulation = 0;
static const enum libinput_config_scroll_method  scroll_method           = LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN;
static const enum libinput_config_click_method   click_method            = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;
static const uint32_t                            send_events_mode        = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;
static const enum libinput_config_accel_profile  accel_profile           = LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT;
static const double                              accel_speed             = 0.0;
static const enum libinput_config_tap_button_map button_map              = LIBINPUT_CONFIG_TAP_MAP_LRM;

#define MOD   WLR_MODIFIER_LOGO
#define CTRL  WLR_MODIFIER_CTRL
#define SHIFT WLR_MODIFIER_SHIFT
#define ALT   WLR_MODIFIER_ALT

#define KEY(NAME) XKB_KEY_##NAME

#define CMD(...)   { .v = (const char*[]){ __VA_ARGS__, NULL } }
#define SH(SCRIPT) CMD("/bin/sh", "-c", SCRIPT)

#define TAGKEYS(NUMBER, SHIFT_KEY) \
	{ MOD,            KEY(NUMBER), view,       {.ui = 1 << (NUMBER - 1)} }, \
	{ MOD|CTRL,       KEY(NUMBER), toggleview, {.ui = 1 << (NUMBER - 1)} }, \
	{ MOD|SHIFT,      SHIFT_KEY,   tag,        {.ui = 1 << (NUMBER - 1)} }, \
	{ MOD|CTRL|SHIFT, SHIFT_KEY,   toggletag,  {.ui = 1 << (NUMBER - 1)} }

static const Button buttons[] = {
	{ MOD, BTN_LEFT,   moveresize,     {.ui = CurMove} },
	{ MOD, BTN_MIDDLE, togglefloating, {0} },
	{ MOD, BTN_RIGHT,  moveresize,     {.ui = CurResize} }
};

// Try to keep common keybindings toward the start
static const Key keys[] = {
	TAGKEYS(1, KEY(apostrophe)),
	TAGKEYS(2, KEY(quotedbl)),
	TAGKEYS(3, KEY(plus)),
	TAGKEYS(4, KEY(exclam)),
	TAGKEYS(5, KEY(percent)),
	TAGKEYS(6, KEY(slash)),
	TAGKEYS(7, KEY(equal)),
	TAGKEYS(8, KEY(parenleft)),
	TAGKEYS(9, KEY(parenright)),

	{ MOD,       KEY(Tab),                   view,             {0} },
	{ MOD,       KEY(0),                     view,             {.ui = ~0} },
	{ MOD|SHIFT, KEY(section),               tag,              {.ui = ~0} },
	{ MOD,       KEY(q),                     killclient,       {0} },
	{ MOD,       KEY(j),                     focusstack,       {.i = +1} },
	{ MOD,       KEY(k),                     focusstack,       {.i = -1} },
	{ MOD|SHIFT, KEY(J),                     movestack,        {.i = +1} },
	{ MOD|SHIFT, KEY(K),                     movestack,        {.i = -1} },
	{ MOD,       KEY(h),                     setmfact,         {.f = -0.05f} },
	{ MOD,       KEY(l),                     setmfact,         {.f = +0.05f} },
	{ MOD|SHIFT, KEY(H),                     incnmaster,       {.i = +1} },
	{ MOD|SHIFT, KEY(L),                     incnmaster,       {.i = -1} },
	{ MOD,       KEY(d),                     zoom,             {0} },
	{ MOD,       KEY(m),                     setlayout,        {0} },
	{ MOD,       KEY(s),                     togglefloating,   {0} },
	{ MOD,       KEY(f),                     togglefullscreen, {0} },
	{ MOD,       KEY(comma),                 focusmon,         {.i = WLR_DIRECTION_LEFT} },
	{ MOD,       KEY(period),                focusmon,         {.i = WLR_DIRECTION_RIGHT} },
	{ MOD|SHIFT, KEY(question),              tagmon,           {.i = WLR_DIRECTION_LEFT} },
	{ MOD|SHIFT, KEY(colon),                 tagmon,           {.i = WLR_DIRECTION_RIGHT} },

	{ MOD,       KEY(Return),                spawn,            CMD("alacritty") },
	{ MOD,       KEY(space),                 spawn,            CMD("fuzzel") },
	{ MOD,       KEY(w),                     spawn,            CMD("firefox") },
	{ 0,         KEY(XF86Calculator),        spawn,            CMD("alacritty", "-e", "qalc") },
	{ 0,         KEY(XF86HomePage),          spawn,            CMD("firefox") },

	{ MOD,       KEY(g),                     spawn,            SH("~/.local/bin/status") },
	{ MOD,       KEY(x),                     spawn,            SH("~/.local/bin/power") },

	{ MOD,       KEY(BackSpace),             spawn,            CMD("makoctl", "dismiss") },
	{ MOD,       KEY(o),                     spawn,            CMD("makoctl", "menu", "--", "fuzzel", "--dmenu", "--placeholder", "Select action") },

	{ 0,         KEY(Print),                 spawninfo,        SH("~/.local/bin/screenshot monitor") },
	{ ALT,       KEY(Sys_Req),               spawninfo,        SH("~/.local/bin/screenshot window") },
	{ CTRL,      KEY(Print),                 spawn,            SH("~/.local/bin/screenshot selection") },
	{ SHIFT,     KEY(Print),                 spawn,            SH("~/.local/bin/screenshot open-selection") },
	{ MOD,       KEY(c),                     spawn,            CMD("hyprpicker", "--autocopy") },

	{ 0,         KEY(XF86AudioNext),         spawn,            CMD("playerctl", "next") },
	{ 0,         KEY(XF86AudioPrev),         spawn,            CMD("playerctl", "previous") },
	{ 0,         KEY(XF86AudioPlay),         spawn,            CMD("playerctl", "play-pause") },
	{ 0,         KEY(XF86AudioStop),         spawn,            CMD("playerctl", "position", "0") },
	{ 0,         KEY(XF86AudioLowerVolume),  spawn,            CMD("wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05-") },
	{ 0,         KEY(XF86AudioRaiseVolume),  spawn,            CMD("wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05+") },
	{ 0,         KEY(XF86AudioMute),         spawn,            CMD("wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle") },

	{ 0,         KEY(XF86MonBrightnessDown), spawn,            CMD("brightnessctl", "set", "2%-", "-n") },
	{ 0,         KEY(XF86MonBrightnessUp),   spawn,            CMD("brightnessctl", "set", "2%+") },

#define CHVT(n) { CTRL|ALT, XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = n} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6), CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
#undef CHVT

#include "device.h"
