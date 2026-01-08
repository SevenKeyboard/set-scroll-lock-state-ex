#Requires AutoHotkey v2.0.0+
;==============================================================
; setScrollLockStateEx — Sets ScrollLock state with optional current-state checks and Always modes
;
; GitHub: https://github.com/SevenKeyboard/set-scroll-lock-state-ex
; Author: SevenKeyboard Ltd. (2026)
; License: The Unlicense
;
; Documentation / References:
;   Re: [V2] Overwrite ahk functions???
;     https://www.autohotkey.com/boards/viewtopic.php?t=123630#p549610
;==============================================================
class VersionManager_setScrollLockStateEx
{
    static _ := this._init()
    static _init()    {
        global
        SETSCROLLLOCKSTATEEX_VERSION := "1.1.0"
    }
}
setScrollLockStateEx(onOff := "", checkCurrentState := false)    {
    isScrollLockAlways := SetScrollLockStateHook_42ECCAEC.IsScrollLockAlways
    switch (onOff), false
    {
        case "":
            setScrollLockState()
        case "On", true:
            if (checkCurrentState && !isScrollLockAlways && getKeyState("ScrollLock", "T"))
                return false
            setScrollLockState(true)
        case "Off", false:
            if (checkCurrentState && !isScrollLockAlways && !getKeyState("ScrollLock", "T"))
                return false
            setScrollLockState(false)
        case "Toggle", -1:
            setScrollLockState(!getKeyState("ScrollLock", "T"))
        ;---------------------------------
        case "Always", "A":
            setScrollLockState("Always" (getKeyState("ScrollLock", "T") ? "On" : "Off"))
        case "AlwaysOn", "1A":
            if (checkCurrentState && isScrollLockAlways && getKeyState("ScrollLock", "T"))
                return false
            setScrollLockState("AlwaysOn")
        case "AlwaysOff", "0A":
            if (checkCurrentState && isScrollLockAlways && !getKeyState("ScrollLock", "T"))
                return false
            setScrollLockState("AlwaysOff")
        case "AlwaysToggle", "-1A":
            setScrollLockState("Always" (getKeyState("ScrollLock", "T") ? "Off" : "On"))
        ;---------------------------------
        case "IsAlways":
            return isScrollLockAlways
    }
    return true
}
class SetScrollLockStateHook_42ECCAEC
{
    static _ := this._init()
    static _init()    {
        this._isScrollLockAlways := false
        setScrollLockState.defineProp("call", {call:this._setScrollLockState})
    }
    static _setScrollLockState(state?)    {
        if !(this is func)
            return
        fn := this ;  setScrollLockState
        this := SetScrollLockStateHook_42ECCAEC
        if (!isSet(state))    {
            this._isScrollLockAlways := false
        }  else  {
            if (state == true || state == false || state ~= "iD)^(|On|Off)$")
                this._isScrollLockAlways := false
            else if (state ~= "iD)^Always(On|Off)$")
                this._isScrollLockAlways := true
        }
        return (func.Prototype.call)(fn, state?)
    }
    static IsScrollLockAlways    {
        get => this._isScrollLockAlways
    }
}