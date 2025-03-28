from libqtile.config import EzKey, Key, Group
from libqtile.lazy import lazy


class App:
    def __init__(self, name: str, key: str, opts: list[str]) -> None:
        self.name = name
        self.key = key
        self.opts = opts

    def make_cmd(self) -> str:
        tmp: str = ""
        for st in self.opts:
            tmp += " " + st
        return self.name + tmp

    def key_group(self) -> Key:
        return EzKey(self.key, lazy.spawn(self.make_cmd()))


class MyGroups:
    MAIN = 1
    CODE = 2
    BROWSER = 3
    FILES = 4

    def __init__(self, id: str, icon: str, app: list[App]) -> None:
        """Group wrapper with apps that are locked to group"""
        self.id = id
        self.icon = icon
        self.app = app
        self.key = f"M-{self.id}"

    def group(self) -> Group:
        """create parent group of MyGroups"""
        return Group(name=self.id, label=self.icon)

    def group_keys(self) -> list[Key]:
        keys: list[Key] = []
        keys.append(EzKey(f"M-{self.id}", lazy.group[self.id].toscreen(), desc=""))
        return keys

    # returning a list with every key for this group
    def app_keys(self) -> list[Key]:
        """returns Groups locked apps Ezkey"""
        tmp: list[Key] = []
        # tmp.append(EzKey(self.key, lazy.groups[self.id].toscreen()))
        for group_apps in self.app:
            tmp.append(
                EzKey(
                    group_apps.key,
                    lazy.spawn(group_apps.make_cmd()),
                    lazy.group[self.id].toscreen(),
                )
            )
        return tmp


class GroupList:
    def __init__(self, groups: list[MyGroups]) -> None:
        self.groups = groups

    def export(self) -> list[Group]:
        out: list[Group] = []
        for gr in self.groups:
            out.append(gr.group())
        return out

    def keys(self) -> list[Key]:
        key: list[Key] = []
        for ky in self.groups:
            key.extend(ky.app_keys())
            key.extend(ky.group_keys())
        return key


class AppList:
    def __init__(self, apps: list[App]) -> None:
        self.apps = apps

    def export(self) -> list[Key]:
        out: list[Key] = []
        for gr in self.apps:
            out.append(gr.key_group())
        return out
