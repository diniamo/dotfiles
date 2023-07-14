# Missing: layouts, manual tiling, bar hide, bar, window moving/resizing, font

from libqtile import qtile, bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy

import os, subprocess
from libqtile import hook

mod = "mod4"
shift = "shift"
ctrl = "control"
alt = "mod1"

terminal = "kitty"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])

keys = [ # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Layouts
    Key([mod], "f", lazy.next_layout()),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, shift], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, shift], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, shift], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, shift], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, ctrl], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, ctrl], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, ctrl], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, ctrl], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Launch
    Key([mod], "Space", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/launcher")), desc="Launches the rofi launcher"),
    Key([mod], "r", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/runner")), desc="Launches the rofi runner"),

    Key([mod], "w", lazy.spawn("firefox"), desc="Launches firefox"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    Key([mod], "0", lazy.group["scratchpad"].dropdown_toggle("terminal"), desc="Opens the terminal scratchpad"),
    Key([],    "XF86Calculator", lazy.group["scratchpad"].dropdown_toggle("calculator"), desc="Opens the calculator scratchpad"),
    # Key([mod], "XF86Calculator", lazy.group["scratchpad"].dropdown_toggle("time"), desc="Opens a small window in the bottom left corner"),

    # Misc
    Key([mod], "x", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/powermenu")), desc="Launches the rofi powermenu"),
    Key([mod], "e", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/emoji")), desc="Launches the emoji picker"),
    # Key([mod], "l", lazy.spawn("betterlockscreen --time-format %H:%M -l"), desc="Locks the computer"),

    Key([mod], "Tab", lazy.screen.toggle_group(), desc="Move to the last group"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "Escape", lazy.reload_config(), desc="Reload the config"),
    # Key([mod, alt], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Media keys
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),  desc="Raises the default sink's Volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),  desc="Lowers the default sink's Volume"),
    Key([], "XF86AudioMute",        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggles the default sink's mute"),

    Key([], "XF86MonBrightnessUp",   lazy.spawn("brightnessctl set +2%"),    desc="Ups the screen's brightness by 2%"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 2%- -n"), desc="Lowers the screen's brightness by 2%"),

    # Screenshot
    Key([],      "Print", lazy.spawn(["sh", "-c", "scrot - | xclip -in -selection clipboard -target image/png"]), desc="Captures everything onto the clipboard"),
    Key([ctrl],  "Print", lazy.spawn(["sh", "-c", "scrot --select --freeze - | xclip -in -selection clipboard -target image/png"]), desc="Starts a scrot selection capture"),
    Key([alt],   "Print", lazy.spawn(["sh", "-c", "scrot --focused - | xclip -in -selection clipboard -target image/png"]), desc="Captures the focused window onto the clipboard"),
    # Key([shift], "Print", lazy.spawn(""), desc="Sceenshots the current screen"),
    Key([mod],   "Print", lazy.spawn(["sh", "-c", "scrot --select --freeze - | tesseract stdin stdout -l eng 2> /dev/null | xclip -in -selection clipboard"]))
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, shift],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

groups.extend([
    ScratchPad("scratchpad", [
        DropDown("terminal", terminal + " --title ScratchPad", x=0.5-(0.8/2), y=0.5-(0.75/2), width=0.8, height=0.75, on_focus_lost_hide=True),
        DropDown("calculator", terminal + " -T Calculator python -i -c \"from math import *\"", x=0.78, y=0.5-(0.5/2), width=0.2, height=0.5, on_focus_lost_hide=False),
        # DropDown("time", terminal + " --title Time --override font_size=100", x=0.05, y=9.95-(0.1), width=0.1, height=0.1, on_focus_lost_hide=False)
    ])
])

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=1),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="MesloLGS Nerd Font",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
            top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Battery(),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()), Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = True
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
# wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# Show/Hide bar based on layout
def _bar(qtile):
    # Get the bar 
    bar = screens[0].top
    # Check the layout and hide bar accordingly
    if(qtile.current_layout.info()['name'] == 'max'):
        bar.show(False)
    else:
        bar.show(True)

@hook.subscribe.layout_change
def layout_change(layout, group):
    _bar(qtile)

@hook.subscribe.changegroup
def group_change():
    _bar(qtile)

@hook.subscribe.client_focus
def focus_change(window):
    _bar(qtile)
