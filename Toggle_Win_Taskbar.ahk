#Requires AutoHotkey v2 64-bit
; Toggle Taskbar Visibility (Windows 10/11)
; Hotkey: Ctrl+Alt+T

; Toggle taskbar auto-hide instead of hard hide
toggle := false

^!t::
{
    global toggle
    toggle := !toggle
    HideShowTaskbar(toggle)

    ToolTip(toggle ? "Taskbar auto-hide ON" : "Taskbar auto-hide OFF")
    Sleep(800)
    ToolTip()
}

HideShowTaskbar(hide) {
    static ABM_SETSTATE    := 0xA
         , ABS_AUTOHIDE    := 0x1
         , ABS_ALWAYSONTOP := 0x2
         , ShellTray       := "ahk_class Shell_TrayWnd"
         , SecondaryTray   := "ahk_class Shell_SecondaryTrayWnd"

    size := 2 * A_PtrSize + 2 * 4 + 16 + A_PtrSize
    APPBARDATA := Buffer(size, 0)

    NumPut("UInt", size, APPBARDATA, 0)
    NumPut("Ptr", WinExist(ShellTray), APPBARDATA, A_PtrSize)

    state := hide ? ABS_AUTOHIDE : ABS_ALWAYSONTOP
    NumPut("UInt", state, APPBARDATA, size - A_PtrSize)

    dllPath := A_WinDir "\System32\Shell32.dll\SHAppBarMessage"
    DllCall(dllPath, "UInt", ABM_SETSTATE, "Ptr", APPBARDATA)

    ; Make taskbar windows fully transparent when hidden,
    ; restore normal opacity when shown.
    if hide {
        if WinExist(ShellTray)
            WinSetTransparent 0, ShellTray
        if WinExist(SecondaryTray)
            WinSetTransparent 0, SecondaryTray
    } else {
        if WinExist(ShellTray)
            WinSetTransparent "Off", ShellTray
        if WinExist(SecondaryTray)
            WinSetTransparent "Off", SecondaryTray
    }
}
