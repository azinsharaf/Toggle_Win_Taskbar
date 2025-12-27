# Toggle Win Taskbar (AutoHotkey)

A tiny AutoHotkey script to quickly hide/show the Windows taskbar on Windows 10/11.

I wrote this because I always wanted to completely remove/hide the Windows taskbar and tried multiple apps (including Buttery Taskbar 2). They were buggy: right-click stopped working, they crashed randomly, or just stopped working after a while. So I ended up writing my own solution in AutoHotkey.

This script doesn’t try to hack the shell too aggressively. Instead, it toggles the taskbar’s auto-hide state and makes it fully transparent when hidden, so it feels like the taskbar is gone, but without breaking basic functionality.

---

## Features

- Toggles taskbar auto-hide on/off with a hotkey
- Makes the taskbar fully transparent while hidden
- Works on primary and secondary taskbars (multi-monitor)
- Lightweight: just a single .ahk file
- Shows a small tooltip so you know whether it’s ON or OFF

---

## Requirements

- Windows 10 or Windows 11
- [AutoHotkey v2 (64-bit)](https://www.autohotkey.com/)
  This script uses v2 syntax and won’t run on v1.

---

## Installation

1. Install AutoHotkey v2 (64-bit) from the official website.
2. Download or clone this repository:
   - Download: click **Code → Download ZIP**, then extract.
   - Or with Git: `git clone https://github.com/azinsharaf/Toggle_Win_Taskbar.git`
3. Make sure the file Toggle_Win_Taskbar.ahk is on your system.

---

## Usage

1. Double-click Toggle_Win_Taskbar.ahk to run it.
2. The script will sit in your tray (AutoHotkey icon).
3. Use the hotkey to toggle the taskbar:
   - **Hotkey:** Ctrl + Alt + T

4. Behavior:
   - When you press Ctrl + Alt + T:
     - The script flips an internal toggle.
     - It calls the Windows shell (SHAppBarMessage) to change the taskbar state.
     - If hiding:
       - Taskbar is set to auto-hide.
       - Taskbar windows are set to fully transparent.
       - You’ll see a tooltip: Taskbar auto-hide ON.
     - If showing:
       - Taskbar is set to always-on-top (no auto-hide).
       - Taskbar transparency is turned back to normal.
       - You’ll see a tooltip: Taskbar auto-hide OFF.

---

## How it works technically

The core logic lives in the HideShowTaskbar(hide) function inside Toggle_Win_Taskbar.ahk.

- It prepares an APPBARDATA structure in memory and calls the SHAppBarMessage function from Shell32.dll with the ABM_SETSTATE message.
- When hide is rue, it sets the taskbar state to ABS_AUTOHIDE. When hide is alse, it sets it to ABS_ALWAYSONTOP.
- The script finds the taskbar windows using their window classes:
  - Primary taskbar: Shell_TrayWnd
  - Secondary taskbars (multi-monitor): Shell_SecondaryTrayWnd
- For each of these windows, it uses AutoHotkey’s WinSetTransparent to control opacity:
  - When hiding, transparency is set to On (fully transparent).
  - When showing, transparency is set to Off (normal/opaque again).

This approach keeps the taskbar logic inside Windows itself (auto-hide vs always-on-top), while using transparency to make the taskbar effectively invisible when hidden. That means far fewer crashes or weird side effects compared to heavier third-party hacks.

---

## Run at Startup (Optional)

If you like it and want it always available:

- Press Win + R, type shell:startup, and press Enter.
- Place a shortcut to Toggle_Win_Taskbar.ahk (or a compiled .exe if you make one) in that folder.

Windows will then start the script automatically when you log in.

