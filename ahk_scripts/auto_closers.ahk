#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
DetectHiddenWindows Off
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


Macro1:
Loop
{
    WinActivate, This is an unregistered copy
    Sleep, 333
    WinKill, This is an unregistered copy
    Sleep, 333
}
Return

