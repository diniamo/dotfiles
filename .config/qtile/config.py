from libqtile import bar, widget
from libqtile.config import Click, Drag, Group, Key, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy

import os, re

from settings import *
from custom import toggle_layout, toggle_sticky_window, float_cycle, move_left, move_right, move_down, move_up, grow_left, grow_right, grow_up, grow_down, toggle_bar, toggle_clock_format

mod = "mod4"
shift = "shift"
ctrl = "control"
alt = "mod1"

keys = [
    # Layouts
    Key([mod], "f", toggle_layout("max"), desc="Toggles the max layout"),
    Key([mod], "s", toggle_sticky_window(), desc="Toggles whether the window is sticky"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggles whether the window is floating"),
    Key([mod], "b", toggle_bar(), desc="Toggles the bar for the current group"),
    # Key([mod], "", toggle_clock_format(), desc="Toggles the clock's format between time and date"),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    Key([alt], "Tab", lazy.group.next_window(), desc="Focuses the next window"),
    Key([alt, shift], "Tab", lazy.group.previous_window(), desc="Focuses the next window"),

    Key([mod], "period", float_cycle(True), desc="Focuses the next floating window"),
    Key([mod], "comma", float_cycle(False), desc="Focuses the previous floating window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, shift], "h", move_left(), desc="Move window to the left"),
    Key([mod, shift], "l", move_right(), desc="Move window to the right"),
    Key([mod, shift], "j", move_down(), desc="Move window down"),
    Key([mod, shift], "k", move_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, ctrl], "h", grow_left(), desc="Grow window to the left"),
    Key([mod, ctrl], "l", grow_right(), desc="Grow window to the right"),
    Key([mod, ctrl], "j", grow_down(), desc="Grow window down"),
    Key([mod, ctrl], "k", grow_up(), desc="Grow window up"),

    Key([mod, ctrl, alt], "h", grow_left(True), desc="Shrink window to the left"),
    Key([mod, ctrl, alt], "l", grow_right(True), desc="Shrink window to the right"),
    Key([mod, ctrl, alt], "j", grow_down(True), desc="Shrink window down"),
    Key([mod, ctrl, alt], "k", grow_up(True), desc="Shrink window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Launch
    Key([mod], "Space", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/launcher")), desc="Launches the rofi launcher"),
    Key([mod], "r", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/runner")), desc="Launches the rofi runner"),

    Key([mod], "w", lazy.spawn("firefox"), desc="Launches firefox"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    Key([mod], "d", lazy.group["scratchpad"].dropdown_toggle("terminal"), desc="Opens the terminal scratchpad"),
    Key([], "XF86Calculator", lazy.group["scratchpad"].dropdown_toggle("calculator"), desc="Opens the calculator scratchpad"),
    Key([mod], "c", lazy.group["scratchpad"].dropdown_toggle("calculator"), desc="Opens the calculator scratchpad"),
    # Key([mod], "XF86Calculator", lazy.group["scratchpad"].dropdown_toggle("time"), desc="Opens a small window in the bottom left corner"),
    Key([mod], "m", lazy.group["scratchpad"].dropdown_toggle("mixer"), desc="Toggles the pulsemixer scratchpad"),
    Key([mod], "e", lazy.group["scratchpad"].dropdown_toggle("fm"), desc="Toggles the file manager scratchpad"),
    Key([mod], "g", lazy.group["scratchpad"].dropdown_toggle("music"), desc="Toggles the music player"),

    # Misc
    Key([mod], "x", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/powermenu")), desc="Launches the rofi powermenu"),
    Key([mod, ctrl], "e", lazy.spawn(os.path.expanduser("~/.config/rofi/bin/emoji")), desc="Launches the emoji picker"),
    # Key([mod], "l", lazy.spawn("betterlockscreen --time-format %H:%M -l"), desc="Locks the computer"),

    Key([mod], "Tab", lazy.screen.toggle_group(), desc="Move to the last group"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "Escape", lazy.reload_config(), desc="Reload the config"),
    # Key([mod, alt], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Media keys
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Raises the default sink's Volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Lowers the default sink's Volume"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggles the default sink's mute"),

    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +2%"), desc="Ups the screen's brightness by 2%"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 2%- -n"), desc="Lowers the screen's brightness by 2%"),

    Key([mod], "iacute", lazy.spawn("playerctl previous"), desc="Goes back to the previous piece of media in the playlist of the currently playing media player"),
    Key([mod], "y", lazy.spawn("playerctl next"), desc="Skips to the next piece of media in the playlist of the currently playing media player"),
    Key([mod], "p", lazy.spawn("playerctl play-pause"), desc="Pauses/resumes the currently playing media"),
    Key([ctrl, mod], "p", lazy.spawn("playerctl play-pause --player=ncspot"), desc="Pauses/resumes the currently playing song in ncspot"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Pauses/resumes the currently playing media"),
    Key([mod, shift], "r", lazy.spawn("playerctl position 0"), desc="Restarts the currently playing media"),

    Key([mod, alt], "m", lazy.spawn(["sh", "-c", "mpv $(xclip -out -selection clipboard)"]), desc="Plays the video url on the clipboard with ffmpeg"),

    # Screenshot
    Key([], "Print", lazy.spawn(["sh", "-c", "scrot - | xclip -in -selection clipboard -target image/png"]), desc="Captures everything onto the clipboard"),
    Key([ctrl], "Print", lazy.spawn(["sh", "-c", "scrot --select --freeze - | xclip -in -selection clipboard -target image/png"]), desc="Starts a scrot selection capture"),
    Key([alt], "Print", lazy.spawn(["sh", "-c", "scrot --focused - | xclip -in -selection clipboard -target image/png"]), desc="Captures the focused window onto the clipboard"),
    # Key([shift], "Print", lazy.spawn(""), desc="Sceenshots the current screen"),
    Key([mod], "Print", lazy.spawn(["sh", "-c", "scrot --select --freeze - | tesseract stdin stdout -l eng 2> /dev/null | xclip -in -selection clipboard"])),
]

groups = [Group(i) for i in "123456789"]

groups[4 - 1].matches = [
    Match(wm_class=["firefox"], title=re.compile("^Media.*"))
]

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
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )

# if not is_laptop:
#     groups.extend([
#         Group('0', layouts=["max"], layout="max", exclusive=True, matches=[
#                 Match(wm_class=["firefox"], title=re.compile("^Discord.*"))
#             ]
#         ),
#     ])
#     keys.extend([
#         Key([mod], '0', lazy.to_screen(1)),
#         Key([mod, shift], '0', lazy.window.togroup('0', switch_group=False))
#     ])

groups.extend([
    ScratchPad("scratchpad", [
        DropDown("terminal",   terminal + " start --always-new-process", x=0.5 - (0.8 / 2), y=0.5 - (0.75 / 2), width=0.8, height=0.75, on_focus_lost_hide=True),
        DropDown("mixer",      terminal + " start --always-new-process --title Mixer -- pulsemixer", x=0.5 - (0.8 / 2), y=0.5 - (0.75 / 2), width=0.8, height=0.75, on_focus_lost_hide=True),
        DropDown("fm",         terminal + " start --always-new-process --title \"File Manager\" -- ranger", x=0.5 - (0.8 / 2), y=0.5 - (0.75 / 2), width=0.8, height=0.75, on_focus_lost_hide=True),
        DropDown("calculator", terminal + " start --always-new-process --title Calculator -- python -i -c \"from math import *\"", x=0.78, y=0.5 - (0.5 / 2), width=0.2, height=0.5, on_focus_lost_hide=False),
        DropDown("music",      terminal + " start --always-new-process --title \"Music Player\" -- ncspot", x=0.5 - (0.8 / 2), y=0.5 - (0.75 / 2), width=0.8, height=0.75, on_focus_lost_hide=True),
        # DropDown("time", terminal + " --title Time --override font_size=100", x=0.05, y=9.95-(0.1), width=0.1, height=0.1, on_focus_lost_hide=False)
    ])
])

widget_defaults = dict(
    font="Inter Nerd Font Mono",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# TODO: proper bar setup
widgets = [
    widget.CurrentLayoutIcon(),
    widget.GroupBox(
        disable_drag=True,
        # hide_unused=True,
        use_mouse_wheel=False,
        other_current_screen_border="215578",
        this_screen_border="404040",
    ),
    widget.Prompt(),
    widget.WindowName(),
    widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    widget.Systray(),
    widget.PulseVolume(
        # volume_up_command="XF86AudioRaiseVolume",
        # volume_down_command="XF86AudioLowerVolume",
        # mute_command="XF86AudioMute",
        # update_interval=0
    ),
    widget.Clock(format=clock_formats[0], mouse_callbacks={"Button1": toggle_clock_format()}),
]

if is_laptop:
    widgets.insert(-2, widget.Battery(format="{char} {percent:2.0%}"))

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            24,
            background=palette.crust.hex,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        wallpaper=os.getenv("WALLPAPER"),
        wallpaper_mode="center",
    ),
    Screen(
        # top=bar.Bar(
        #     [
        #         widget.Spacer(),
        #         widgets[6],
        #         widgets[7]
        #     ],
        #     24,
        #     background=palette.crust.hex
        # ),
        wallpaper=os.getenv("WALLPAPER"),
        wallpaper_mode="center",
    )
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()), Click([mod], "Button2", lazy.window.bring_to_front()),
]
