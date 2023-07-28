from libqtile import layout
from libqtile.config import Match

import os

mod = "mod4"
shift = "shift"
ctrl = "control"
alt = "mod1"

terminal = os.getenv("TERMINAL")

floating_move_amount = 50
floating_grow_amount = 50

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=1),
    layout.Max(),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.Floating(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.TreeTab(),
]

from catppuccin import Flavour
palette = Flavour.mocha()

# Get these with xprop:
no_max_bar = [
    ['gl', 'mpv']
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = True
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_fullscreen = True
auto_minimize = True
wmname = "qtile"
