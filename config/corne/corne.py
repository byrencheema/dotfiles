# /// script
# dependencies = ["hidapi"]
# ///
"""Dump or restore the Corne v4 keymap over Vial's raw HID interface.

uv run corne.py dump      save the board's keymap to keymap.json
uv run corne.py restore   write keymap.json back to the board
"""

import json
import sys
from pathlib import Path

import hid

VID, PID = 0x4653, 0x0004
LAYERS, ROWS, COLS = 6, 8, 7
KEYMAP = Path(__file__).with_name("keymap.json")


def open_board():
    for d in hid.enumerate(VID, PID):
        if d["usage_page"] == 0xFF60 and d["usage"] == 0x61:
            dev = hid.device()
            dev.open_path(d["path"])
            return dev
    sys.exit("Corne v4 not found. Is it plugged in, and is Vial closed?")


def send(dev, *payload):
    dev.write(bytes([0, *payload] + [0] * (32 - len(payload))))
    return dev.read(32, 1000)


def get_key(dev, layer, row, col):
    r = send(dev, 0x04, layer, row, col)
    return (r[4] << 8) | r[5]


def dump(dev):
    keymap = [[[get_key(dev, l, r, c) for c in range(COLS)] for r in range(ROWS)] for l in range(LAYERS)]
    KEYMAP.write_text(json.dumps(keymap) + "\n")
    print(f"saved {KEYMAP}")


def restore(dev):
    keymap = json.loads(KEYMAP.read_text())
    failed = 0
    for l, layer in enumerate(keymap):
        for r, row in enumerate(layer):
            for c, kc in enumerate(row):
                send(dev, 0x05, l, r, c, kc >> 8, kc & 0xFF)
                failed += get_key(dev, l, r, c) != kc
    print("restored" if not failed else f"{failed} keys failed to write")


if __name__ == "__main__":
    action = sys.argv[1] if len(sys.argv) > 1 else ""
    if action not in ("dump", "restore"):
        sys.exit(__doc__)
    {"dump": dump, "restore": restore}[action](open_board())
