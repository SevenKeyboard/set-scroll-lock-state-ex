#Requires AutoHotkey v1.1.31+
;==============================================================
; setScrollLockStateEx — Sets ScrollLock state with optional current-state checks and Always modes
;
; GitHub: https://github.com/SevenKeyboard/set-scroll-lock-state-ex
; Author: SevenKeyboard Ltd. (2026)
; License: The Unlicense
;==============================================================
class VersionManager_setScrollLockStateEx
{
    static _ := VersionManager_setScrollLockStateEx._init()
    _init()    {
        global
        SETSCROLLLOCKSTATEEX_VERSION := "1.1.0"
    }
}
setScrollLockStateEx(onOff := "", checkCurrentState := false)    {
    static isScrollLockAlways := false
    bRet := false
    prevSCS := A_StringCaseSense
    stringCaseSense Off
    switch (onOff)
    {
        case "":
            isScrollLockAlways := false
            setScrollLockState
        case "On", true:
            if (checkCurrentState && !isScrollLockAlways && getKeyState("ScrollLock", "T"))
                goto Cleanup_F39D2FDF
            isScrollLockAlways := false
            setScrollLockState On
        case "Off", false:
            if (checkCurrentState && !isScrollLockAlways && !getKeyState("ScrollLock", "T"))
                goto Cleanup_F39D2FDF
            isScrollLockAlways := false
            setScrollLockState Off
        case "Toggle", -1:
            isScrollLockAlways := false
            setScrollLockState % (!getKeyState("ScrollLock", "T"))
        ;---------------------------------
        case "Always", "A":
            isScrollLockAlways := true
            setScrollLockState % "Always" (getKeyState("ScrollLock", "T") ? "On" : "Off")
        case "AlwaysOn", "1A":
            if (checkCurrentState && isScrollLockAlways && getKeyState("ScrollLock", "T"))
                goto Cleanup_F39D2FDF
            isScrollLockAlways := true
            setScrollLockState AlwaysOn
        case "AlwaysOff", "0A":
            if (checkCurrentState && isScrollLockAlways && !getKeyState("ScrollLock", "T"))
                goto Cleanup_F39D2FDF
            isScrollLockAlways := true
            setScrollLockState AlwaysOff
        case "AlwaysToggle", "-1A":
            isScrollLockAlways := true
            setScrollLockState % "Always" (getKeyState("ScrollLock", "T") ? "Off" : "On")
        ;---------------------------------
        case "IsAlways":
            bRet := isScrollLockAlways
            goto Cleanup_F39D2FDF
    }
    bRet := true
Cleanup_F39D2FDF:
    stringCaseSense % prevSCS
    return bRet
}