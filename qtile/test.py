list1 = [6, 5, 4]
list2 = [1, 2, 3]

list1.extend(list2)


# print(list1)


def test(*args: str, id: int) -> None:
    print(f"{args} - {id}")


# atest(*["1", "2", "3"], id=22)


def cmd(name: str, args: list[str]) -> None:
    tmp: str = ""
    for ar in args:
        tmp += " " + ar
    print(name + tmp)


cmd("test", ["--thing", "hah"])
