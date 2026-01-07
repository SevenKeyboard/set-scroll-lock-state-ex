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
        SETSCROLLLOCKSTATEEX_VERSION := "1.0.0"
    }
}
setScrollLockStateEx(onoff:="", checkCurrentState:=true)    {
    bRet:=false
    prevSCS:=A_StringCaseSense
    stringCaseSense Off
    switch (onoff)
    {
        case "":
            setCapsLockState
        case "On",true:
            if (checkCurrentState && getKeyState("ScrollLock","T"))
                goto Cleanup_F39D2FDF
            setScrollLockState On
        case "Off",false:
            if (checkCurrentState && !getKeyState("ScrollLock","T"))
                goto Cleanup_F39D2FDF
            setScrollLockState Off
        case "Toggle",-1:
            setScrollLockState % (!getKeyState("ScrollLock","T"))
        ;---------------------------------
        case "Always","A":
            setScrollLockState % "Always" (getKeyState("ScrollLock","T")?"On":"Off")
        case "AlwaysOn","1A":
            if (checkCurrentState && getKeyState("ScrollLock","T"))
                goto Cleanup_F39D2FDF
            setScrollLockState AlwaysOn
        case "AlwaysOff","0A":
            if (checkCurrentState && !getKeyState("ScrollLock","T"))
                goto Cleanup_F39D2FDF
            setScrollLockState AlwaysOff
        case "AlwaysToggle","-1A":
            setScrollLockState % "Always" (getKeyState("ScrollLock","T")?"Off":"On")
    }
    bRet:=true
Cleanup_F39D2FDF:
    stringCaseSense % prevSCS
    return bRet
}