# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import (
    Click,
    Drag,
    Key,
    Match,
    Screen,
)
from libqtile.lazy import lazy

from group import App, AppList, GroupList, MyGroups
from kanagawa import dragon

mod = "mod4"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key(
        [mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"
    ),  # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "left",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "right",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    #   Key([mod], "Return", lazy.spawn("ghostty"), desc="Launch terminal"),
    #    Key([mod], "f3", lazy.spawn("ghostty -e yazi"), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control", "shift"], "r", lazy.reload(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]
# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
# for vt in range(1, 8):
#     keys.append(
#         Key(
#             ["control", "mod1"],
#             f"f{vt}",
#             lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
#             desc=f"Switch to VT{vt}",
#         )
#     )


apps = AppList(
    [
        App(name="alacritty", key="M-<Return>", opts=[]),
        App(
            name="rofi",
            key="M-d",
            opts=[
                "-config",
                "~/.config/rofi/launchers/type-5/style-4.rasi",
                "-show",
                "drun",
            ],
        ),
        App(name="qutebrowser", key="M-<F2>", opts=[]),
    ]
)
keys.extend(apps.export())

grp = GroupList(
    [
        MyGroups(
            id="1",
            icon="󰣇 - main tab",
            app=[],
        ),
        MyGroups(
            id="2",
            icon=" - browser",
            app=[],
        ),
        MyGroups(
            id="3",
            icon=" - code",
            app=[],
        ),
        MyGroups(
            id="4",
            icon=" - Files",
            app=[App(name="ghostty", key="M-<F3>", opts=["-e", "yazi"])],
        ),
        MyGroups(
            id="5",
            icon=" - Art",
            app=[],
        ),
        MyGroups(
            id="6",
            icon="  - Etc",
            app=[],
        ),
    ]
)
groups = grp.export()
keys.extend(grp.keys())


# groups = [ Group("Main",""),Group("Internet",""),Group("Files",""),Group("Etc",""),Group("Etc",""),Group("Etc","")]
# icons = ["󰣇", "", "", "", "", ""]
# title = ["main", "browser", "file", "code", "gimp", "rng"]
# id = "123456"
# groups = [Group(name=i) for i in "123456"]  # "123456"]
# groups = []
# for gr in range(5):
#     groups.append(Group(name=str(gr + 1), label=icons[gr] + f" - {title[gr]}"))
#######

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            # Key(
            #     [mod],
            #     i.name,
            #     lazy.group[i.name].toscreen(),
            #     desc=f"Switch to group {i.name}",
            # ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

# groups.append(ScratchPad("ScratchPad", [DropDown("term", "ghostty", opacity=0.8)]))
# keys.append(Key([], "F5", lazy.group["ScratchPad"].dropdown_toggle("term")))

layout_defaults = {
    "border_focus": dragon["red"],
    "border_normal": dragon["yellow"],
    "margin": 4,
}

layouts = [
    layout.Plasma(**layout_defaults),
    layout.Matrix(columns=2, **layout_defaults),
    layout.RatioTile(**layout_defaults),
    layout.Max(**layout_defaults),
]


default = {
    "font": "JetBrainsMono Nerd Font",
    "fontsize": 14,
    "foreground": dragon["white-bright"],
}
extension_defaults = default.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [  # con(bg="color4", text=' ')
                widget.CurrentLayoutIcon(),
                widget.CurrentLayout(),
                widget.Sep(padding=5),
                widget.GroupBox(
                    highlight_method="block",
                    spacing=5,
                    highlight_color="#FF00FF",
                    disable_drag=True,
                    # active=dragon["yellow"],
                    # inactive=dragon["yellow"],
                    this_current_screen_border=dragon["yellow"],  # "#727169",
                    **default,
                    # other_current_screen_border="#C8C093",
                    # other_screen_border="#C8C093",
                ),
                # widget.Prompt(),
                widget.WindowName(padding=5, **default),
                widget.CheckUpdates(
                    # background=colors["color4"],
                    colour_have_updates=dragon["red"],
                    colour_no_updates=dragon["white-bright"],
                    no_update_string="Up tp Date!",
                    display_format="{updates}",
                    update_interval=1800,
                    # custom_command="checkupdates",
                    **default,
                ),
                widget.CPU(**default),
                widget.Memory(**default),
                # widget.Chord(
                #     chords_colors={
                #         "launch": ("#ff0000", "#ffffff"),
                #     },
                #     name_transform=lambda name: name.upper(),
                # ),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(padding=5),
                widget.Clock(format="%B %d %a %I:%M %p", **default),
                # widget.QuickExit(), "   ", "   ", "   ", "   ", "  ", "   ", "   ", "   ", "   ",
            ],
            32,
            background=dragon["bg"],
            foreground=dragon["fg"],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
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
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/start.sh")
    subprocess.run([home])
