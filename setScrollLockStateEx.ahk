#Requires AutoHotkey v2.0.0+
;==============================================================
; setScrollLockStateEx — Sets ScrollLock state with optional current-state checks and Always modes
;
; GitHub: https://github.com/SevenKeyboard/set-scroll-lock-state-ex
; Author: SevenKeyboard Ltd. (2026)
; License: The Unlicense
;==============================================================
class VersionManager_setScrollLockStateEx
{
    static _ := this._init()
    static _init()    {
        global
        SETSCROLLLOCKSTATEEX_VERSION := "1.0.0"
    }
}
setScrollLockStateEx(onoff:="", checkCurrentState:=true)    {
    switch (onoff), false
    {
        case "":
            setScrollLockState
        case "On",true:
            if (checkCurrentState && getKeyState("ScrollLock","T"))
                return false
            setScrollLockState(true)
        case "Off",false:
            if (checkCurrentState && !getKeyState("ScrollLock","T"))
                return false
            setScrollLockState(false)
        case "Toggle",-1:
            setScrollLockState(!getKeyState("ScrollLock","T"))
        ;---------------------------------
        case "Always","A":
            setScrollLockState("Always" (getKeyState("ScrollLock","T")?"On":"Off"))
        case "AlwaysOn","1A":
            if (checkCurrentState && getKeyState("ScrollLock","T"))
                return false
            setScrollLockState("AlwaysOn")
        case "AlwaysOff","0A":
            if (checkCurrentState && !getKeyState("ScrollLock","T"))
                return false
            setScrollLockState("AlwaysOff")
        case "AlwaysToggle","-1A":
            setScrollLockState("Always" (getKeyState("ScrollLock","T")?"Off":"On"))
    }
    return true
}