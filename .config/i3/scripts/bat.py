#!/usr/bin/env python3

from __future__ import annotations

import re
from dataclasses import dataclass
from enum import Enum
import sys


Regex = re.compile("Battery (\d): ([\w\s]+), (\d+)%")
State = Enum("State", ["Crit", "Low", "Mid", "High", "Charging"])
Colors = {
    State.Crit: (10, "#c4a7e7"),
    State.Low: (20, "#eb6f92"),
    State.Mid: (50, "#f6c177"),
    State.High: (100, "#6e6a86"),
    State.Charging: (0, "#9ccfd8"),
}
Symbols = [
    (0, "", " "),
    (10, "", " "),
    (20, "", " "),
    (30, "", " "),
    (40, "", " "),
    (50, "", " "),
    (60, "", " "),
    (70, "", " "),
    (80, "", " "),
    (90, "", " "),
    (100, "", " "),
]


@dataclass
class Battery:
    index: int
    Status = Enum("Status", ["Full", "Discharging", "Not charging", "Charging"])
    status: Status
    percentage: int

    @classmethod
    def from_str(cls, text: str) -> Battery | None:
        if not (match := Regex.match(text)) or len(groups := match.groups()) != 3:
            return None
        index, status, percentage = groups
        return cls(int(index), cls.Status[status], int(percentage))

    def __repr__(self) -> str:
        symbol = next(s for s in Symbols if self.percentage <= s[0])
        return symbol[1] if self.status != Battery.Status.Charging else symbol[2]


if __name__ == "__main__":
    batteries = [Battery.from_str(line) for line in sys.stdin]
    percentage = round(sum(b.percentage for b in batteries) / len(batteries))
    color = (
        Colors[State.Charging][1]
        if any(b.status == Battery.Status.Charging for b in batteries)
        else next(color[1] for s in State if (color := Colors[s])[0] > percentage)
    )
    print(
        f"<span color='{color}' font='FontAwesome'>"
        f"{' '.join(map(str, batteries))} {percentage}%"
        "</span>"
    )
