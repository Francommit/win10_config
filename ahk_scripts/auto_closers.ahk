; Shift + Alt + Left --> becomes Shift + Home
!+Left::
Send, {Shift down}{Home}{Shift up}
return

; Shift + Alt + Right --> becomes Shift + End
!+Right::
Send, {Shift down}{End}{Shift up}
return

; Google Search select text - Ctrl + Shift + C
 ^+c::
 {
  Send, ^c
  Sleep 50
  Run, http://www.google.com/search?q=%clipboard%
  Return
 }
return
