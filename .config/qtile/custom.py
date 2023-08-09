from libqtile import qtile, hook
from libqtile.lazy import lazy

import os
import subprocess

from settings import layouts, no_max_bar, floating_grow_amount, floating_move_amount


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])


@hook.subscribe.client_focus
def always_on_top(window):
    if qtile.current_layout != 'floating' and not window.floating:
        for win in qtile.current_group.windows:
            if win.floating:
                win.bring_to_front()


sticky_windows = []


@lazy.function
def toggle_sticky_window(qtile, window=None):
    if window is None:
        window = qtile.current_window
    if window in sticky_windows:
        sticky_windows.remove(window)
    else:
        sticky_windows.append(window)
    return window


@hook.subscribe.setgroup
def move_sticky_windows():
    for window in sticky_windows:
        window.togroup(qtile.current_group.name)


@hook.subscribe.client_killed
def remove_sticky_windows(window):
    if window in sticky_windows:
        sticky_windows.remove(window)


@hook.subscribe.client_managed
def auto_sticky_windows(window):
    info = window.info()
    if ((info['wm_class'] == ['Toolkit', 'firefox'] and info['name'] == 'Picture-in-Picture')
            or (info['wm_class'] == ['dragon-drop', 'Dragon-drop'])):
        sticky_windows.append(window)


@lazy.function
def move_left(qtile, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (x, y) = window.get_position()
        window.set_position_floating(x - floating_move_amount, y)
    else:
        qtile.current_layout.shuffle_left()


@lazy.function
def move_right(qtile, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (x, y) = window.get_position()
        window.set_position_floating(x + floating_move_amount, y)
    else:
        qtile.current_layout.shuffle_right()


@lazy.function
def move_down(qtile, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (x, y) = window.get_position()
        window.set_position_floating(x, y + floating_move_amount)
    else:
        qtile.current_layout.shuffle_down()


@lazy.function
def move_up(qtile, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (x, y) = window.get_position()
        window.set_position_floating(x, y - floating_move_amount)
    else:
        qtile.current_layout.shuffle_up()


@lazy.function
def grow_left(qtile, shrink=False, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (w, h) = window.get_size()
        if shrink:
            window.set_size_floating(w - floating_grow_amount, h)
        else:
            (x, y) = window.get_position()
            window.set_size_floating(w + floating_grow_amount, h)
            window.set_position_floating(x - floating_grow_amount, y)
    else:
        qtile.current_layout.grow_left()


@lazy.function
def grow_right(qtile, shrink=False, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (w, h) = window.get_size()
        if shrink:
            (x, y) = window.get_position()
            window.set_size_floating(w - floating_grow_amount, h)
            window.set_position_floating(x + floating_grow_amount, y)
        else:
            window.set_size_floating(w + floating_grow_amount, h)
    else:
        qtile.current_layout.grow_right()


@lazy.function
def grow_down(qtile, shrink=False, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (w, h) = window.get_size()
        if shrink:
            (x, y) = window.get_position()
            window.set_size_floating(w, h - floating_grow_amount)
            window.set_position_floating(x, y + floating_grow_amount)
        else:
            window.set_size_floating(w, h + floating_grow_amount)
    else:
        qtile.current_layout.grow_down()


@lazy.function
def grow_up(qtile, shrink=False, window=None):
    if window is None:
        window = qtile.current_window
    if window.floating:
        (w, h) = window.get_size()
        if shrink:
            window.set_size_floating(w, h - floating_grow_amount)
        else:
            (x, y) = window.get_position()
            window.set_size_floating(w, h + floating_grow_amount)
            window.set_position_floating(x, y - floating_grow_amount)
    else:
        qtile.current_layout.grow_up()


previous_layout = layouts[0].name


@lazy.function
def toggle_layout(qtile, layout_name):
    global previous_layout

    current_layout = qtile.current_layout.name
    if current_layout != layout_name:
        qtile.current_group.setlayout(layout_name)
        previous_layout = current_layout
    else:
        qtile.current_group.setlayout(previous_layout)


def check_mpv():
    if qtile.current_layout.name == 'max' and qtile.current_window.info()['wm_class'] in no_max_bar:
        qtile.current_screen.top.show(False)
    else:
        qtile.current_screen.top.show(True)


# @hook.subscribe.layout_change
# def layout_change(*_):
#     check_mpv()


@hook.subscribe.changegroup
def group_change():
    check_mpv()


@hook.subscribe.client_focus
def focus_change(_):
    check_mpv()


floating_window_index = 0


@lazy.function
def float_cycle(qtile, forward: bool):
    global floating_window_index
    floating_windows = []
    for window in qtile.current_group.windows:
        if window.floating:
            floating_windows.append(window)
    if not floating_windows:
        return
    floating_window_index = min(floating_window_index, len(floating_windows) - 1)
    if forward:
        floating_window_index += 1
    else:
        floating_window_index += 1
    if floating_window_index >= len(floating_windows):
        floating_window_index = 0
    if floating_window_index < 0:
        floating_window_index = len(floating_windows) - 1
    win = floating_windows[floating_window_index]
    win.bring_to_front()
    win.focus()
