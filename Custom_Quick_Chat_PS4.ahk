1.0
version := 1.0

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;====================================================================
; 
; Custom Quick Chat Rocket League
;
; Programmer: SpArX 
;
;====================================================================

URLDownloadToFile, https://raw.githubusercontent.com/SpArX0110/Custom-Quick-Chat-RL/main/Custom_Quick_Chat_PS4.ahk, update.txt
FileReadLine, update, update.txt, 1

if (update <= version ) {
  FileDelete, update.txt
  goto program
ExitApp
  return
} else {
	FileDelete, update.txt
 Gui, Add, Text, vtext, NEW UPDATE FOUND!`nDo you want to update?
 Gui, Add, Button, h21 w60 gYes, YES    
 Gui, Add, Button, xp+65 h21 w60 gNo, No
gui, show
return
}

Yes:
{
gui, destroy
file_exists := 0
FileDelete, version.txt
FileDelete, update.txt
FileDelete, Custom_Quick_Chat_PS4.exe
FileAppend,
(
taskkill Custom_Quick_Chat_PS4.exe
del Custom_Quick_Chat_PS4.exe
curl -LJO https://github.com/SpArX0110/RL_CQC/releases/download/CQC_PS4/Custom_Quick_Chat_PS4.exe
start Custom_Quick_Chat_PS4.exe
EXIT /B
), update.bat
run update
ExitApp
return
}

No:
Gui destroy
goto program
return

GuiClose:
ExitApp

program:
RegExMatch(A_ScriptName, "^(.*?)\.", basename)    ; dont use splitpath to get basename because it cant handle DeltaRush.1.3.exe
WINTITLE := basename1 "_" "Version" "_" VERSION

#SingleInstance force  
#NoENV              ; Avoids checking empty variables to see if they are environment variables (recommended for all new scripts and increases performance).
SetTitleMatchMode, 3
SetBatchLines -1    ; have the script run at maximum speed and never sleep
ListLines Off       ; a debugging option


delay = 50
menue_x := A_ScreenWidth/80
menue_y := A_ScreenHeight*2/5
number_buttons := 8
overlay_time = 1850
textcolor := "FFFFFF"
windowcolor := "000000"
barcolor := "404040"
Barwidth :=635
toggle := 0
FileDelete, update.bat
;============================================================

;============================================================

RegExMatch(A_ScriptName, "^(.*?)\.", basename)    ; dont use splitpath 

if Not InStr(FileExist(A_AppData "\" basename1), "D")    ; create appdata folder if doesnt exist
    FileCreateDir , % A_AppData "\" basename1
    

;============================================================
; Build gui:
;============================================================ 

Gui +AlwaysOnTop +LastFound +ToolWindow -Caption
Gui, Color, %windowcolor%
Gui, Font, c%textcolor%
Gui, Add, Progress, % "x0 y0 w" (Barwidth ) " h31 Background404040 Disabled hwndHPROG"
Gui, Add, Text,% "x0 y0 w" Barwidth " h30 BackgroundTrans Center 0x200 gGuiMove vCaption", %basename1%_Version%VERSION%

Gui, Add, Text, xm section, Preset
Gui, Add, ComboBox, x+5 vfrmSAVEDPRESET gPresetChange

Gui, Add, Button, h21 w60 gSavePreset, Save    
Gui, Add, Button, x+5 h21 w60 gDeletePreset vDELETEBUTTON, Delete 
    
Gui, Add, Text,xm c%textcolor% vQuickchat, Button to open Quick Chat Menue
Dropdownlist0 := ["⎕","X","◯","△","L1","R1","L2","R2","Share","Options","L3","R3","PS","🠉","🠊","🠋","🠈","Touch"]
Loop, % Dropdownlist0.MaxIndex()
	DDLString0 .= Dropdownlist0[A_Index]"|"
Gui, Add, DropDownList,xm+15 gcheck_choices vMyDLL0 choose18,%DDLString0%
Gui, Add, Text,xm+13 c%textcolor% vQuickchat6, (Touchpad recommended)

Gui, Add, Text, vQuickchat4, Press F3 to open and close GUI
Gui, Add, Text, vQuickchat3, Press F9 to reload scirpt`n
Gui, Add, Checkbox, vMyBox0, Instant Leave Button (Num 0)

;Add Textfields
Gui, Add, Text,ys, Selct Quick Chat Text
i = 1
while i <= number_buttons
{
Gui, Add, Edit, cBlack vMyEdit%i% r1
i++
}

;Add Checkboxes
Gui, Add, Text,ys , Exclamation Mark ;ALWAYs Exclamation for testing
Gui, Add, Checkbox,xp+35 y+10  vMyBox1
Gui, Add, Checkbox,y+15  vMyBox2
Gui, Add, Checkbox,y+13  vMyBox3
Gui, Add, Checkbox,y+12 vMyBox4
Gui, Add, Checkbox,y+12 vMyBox5
Gui, Add, Checkbox,y+15  vMyBox6
Gui, Add, Checkbox,y+15  vMyBox7
Gui, Add, Checkbox,y+15 vMyBox8


;Add Dropdownlists Chatbuttons
Gui, Add, Text,ys , Quick Chat Button
Dropdownlist := ["","⎕","X","◯","△","L1","R1","L2","R2","Share","Options","L3","R3","PS","🠉","🠊","🠋","🠈","Touch"]

Loop, % Dropdownlist.MaxIndex()
	DDLString .= Dropdownlist[A_Index]"|"
i = 1
while i <= number_buttons
{
Gui, Add, DropDownList,w80 vMyDLL%i% hwndDDL_ID%i%, %DDLString% ;⎕|X|◯|△|L1|R1|L2|R2|Share|Options|L3|R3|PS|🠉|🠊|🠋|🠈
i++
}

;Add Dropdownlists Chatmode
Gui, Add, Text,ys , Quick Chat Mode
i = 1
while i <= number_buttons
{
Gui, Add, DropDownList,choose1 vMyDLL2%i%, To All|Team Only
i++
}

Gui, Add, Button, xm+10 ym+240 h21 w60 gApply, Apply  ; Add Apply Button
Gui, Add, Button, xp+70 ym+240 h21 w60 gExit, Exit  ; Add Exit Button
Gui, Add, Text, xm+10 vQuickchat5, Copyright © 2021 by SpArX
Gui, Add, Button, xp+200 ym+270 h21 w60 gReset_Text, Reset  ; Add Reset Button
Gui, Add, Button,xp+115 gcheck_all_boxes , Set/Reset
Gui, Add, Button, xp+94 h21 w60 gReset_Buttons, Reset  ; Add Reset Button
Gui, Add, Button, xp+115 h21 w60 gToggle_Mode, Toggle All  ; Add Reset Button
Gui, Add, Button, xm+630 ym gGui_Close, X  ; Add Gui_Close
WinSet, Transparent, 215

Gui, Add, StatusBar, vMyStatusbar
-Theme Background%barcolor%

GetXY(winx, winy)
;breite := Barwidth+30
;hoehe := winy-78

;WinSet, Region, 0-0 w%breite% h%hoehe% r10-10

Gui, Show,x%winx% y%winy%,%WINTITLE%
goto check_choices
go_on:
WinGetActiveTitle, Title
wait:
GoSub, UpdatePresetList  ; update drop down to show all preset section names in ini file

f9::Reload

f3::
IfWinExist, %Title%
  Gui, Cancel
else
   gui, show
Return

Gui_Close:
Gui, Cancel
return

Apply:
Gui, Submit, NoHide  ; Save each control's contents to its associated variable.

;Quickchatmode button mapping
{
If(MyDLL0 = "⎕")
	Button0 = Joy1
Else If(MyDLL0 = "X")
	Button0 = Joy2
Else If(MyDLL0 = "◯")
	Button0 = Joy3
Else If(MyDLL0 = "△")
    Button0 = Joy4
Else If(MyDLL0 = "L1")
	Button0 = Joy5
Else If(MyDLL0 = "R1")
	Button0 = Joy6
Else If(MyDLL0 = "L2")
	Button0 = Joy7
Else If(MyDLL0 = "R2")
	Button0 = Joy8
Else If(MyDLL0 = "Share")
	Button0 = Joy9
Else If(MyDLL0 = "Options")
	Button0 = Joy10
Else If(MyDLL0 = "L3")
	Button0 = Joy11
Else If(MyDLL0 = "R3")
	Button0 = Joy12
Else If(MyDLL0 = "PS")
	Button0 = Joy13
Else If(MyDLL0 = "Touch")
	Button0 = Joy14
Else If(MyDLL0 = "🠉")
	Button0 = 0
Else If(MyDLL0 = "🠊")
	Button0 = 9000
Else If(MyDLL0 = "🠋")
	Button0 = 18000
Else If(MyDLL0 = "🠈")
	Button0 = 27000
}


;Quickchat button mapping
{
i = 1
while i <= number_buttons
{
If(MyDLL%i% = "⎕")
	Button%i% = Joy1
Else If(MyDLL%i% = "X")
	Button%i% = Joy2
Else If(MyDLL%i% = "◯")
	Button%i% = Joy3
Else If(MyDLL%i% = "△")
	Button%i% = Joy4
Else If(MyDLL%i% = "L1")
	Button%i% = Joy5
Else If(MyDLL%i% = "R1")
	Button%i% = Joy6
Else If(MyDLL%i% = "L2")
	Button%i% = Joy7
Else If(MyDLL%i% = "R2")
	Button%i% = Joy8
Else If(MyDLL%i% = "Share")
	Button%i% = Joy9
Else If(MyDLL%i% = "Options")
	Button%i% = Joy10
Else If(MyDLL%i% = "L3")
	Button%i% = Joy11
Else If(MyDLL%i% = "R3")
	Button%i% = Joy12
Else If(MyDLL%i% = "PS")
	Button%i% = Joy13
Else If(MyDLL%i% = "Touch")
	Button%i% = Joy14
Else If(MyDLL%i% = "🠉")
	Button%i% = 0
Else If(MyDLL%i% = "🠊")
	Button%i% = 9000
Else If(MyDLL%i% = "🠋")
	Button%i% = 18000
Else If(MyDLL%i% = "🠈")
	Button%i% = 27000
Else If(MyDLL%i% = "")
	Button%i% = 27000
i++
}
}

;Exclamation mark mapping
{
i = 1
while i <= number_buttons
{
If(MyBox%i% = 1)
	punctuation%i% = {!}
Else If(MyBox%i% = 0)
	punctuation%i% = 
i++
}
i = 1
while i <= number_buttons
{
If(MyBox%i% = 1)
	exclamation%i% = !
Else If(MyBox%i% = 0)
	exclamation%i% = 
i++
}
}

;Chatmode mapping
{
i = 1
while i <= number_buttons
{
If(MyDLL2%i% = "To All")
	chatmode%i% = t
Else If(MyDLL2%i% = "Team Only")
	chatmode%i% = y
i++
}
}

Status_Time = 0
SB_SetText("Settings applied")
SetTimer, Close_Status, 2000


Hotkey, %Button0%, Quickchat_Menue

;~ MsgBox %Button0%`n%Button1%`n%Button2%`n%Button3%`n%Button4%
;~ MsgBox %punctuation1%`n%punctuation2%`n%punctuation3%`n%punctuation4%

return

;============================================================
; do a guirestore for newly selected preset
;============================================================

PresetChange:

    gui, submit, nohide
    
    ; if drop down text is blank then error message and return
    if (frmSAVEDPRESET = "") 
        return
    
    ; save gui values after combobox1 to ini file under given section
    guirestore("CQC_Variables.ini",frmSAVEDPRESET)
    
Return

;============================================================
; save preset to CQC_Variables.ini
;============================================================

SavePreset:

    gui, submit, nohide
    
    ; if drop down text is blank then error message and return
    if (frmSAVEDPRESET = "") {
        SB_SetText("Preset name required")
	Status_Time = 0
	SetTimer, Close_Status, 2000
        return
    }
    
    guisave("CQC_Variables.ini", frmSAVEDPRESET, "DELETEBUTTON")
    
    GoSub, UpdatePresetList  ; update drop down to show all preset section names in ini file
    
    GuiControl, Text, frmSAVEDPRESET, % frmSAVEDPRESET  ; update the control
    
    SB_SetText(frmSAVEDPRESET " preset saved") 
    
Return

;============================================================
; delete selected preset section from CQC_Variables.ini
;============================================================

DeletePreset:

    gui, submit, nohide
    
    RegExMatch(A_ScriptName, "^(.*?)\.", basename) 
    
    ; if drop down text is blank then error message and return
    if (frmSAVEDPRESET = "") {
        SB_SetText("Preset name required")
        return
    }
    
    ; delete entire section from ini file
    IniDelete, %A_AppData%\%basename1%\CQC_Variables.ini, %frmSAVEDPRESET%

    SB_SetText(frmSAVEDPRESET " preset deleted" ) 
    
    GoSub, UpdatePresetList  ; update drop down to show all preset section names in ini file
    
Return

;============================================================
; update drop down to show all preset section names in ini file, except section1
;============================================================

UpdatePresetList:

    gui, submit, nohide
    
    RegExMatch(A_ScriptName, "^(.*?)\.", basename) 
    
    ; get all section names in ini file
    IniRead, sectionNames, %A_AppData%\%basename1%\CQC_Variables.ini 
    sectionNames := RegExReplace(sectionNames , "\n", "|")         ; change newline to pipe
    sectionNames := RegExReplace(sectionNames , "section1[\|]?", "")    ; exclude section1
    sectionNames := "|" sectionNames
    
    ; update drop down to show all preset section names in ini file
    GuiControl, , frmSAVEDPRESET, % sectionNames  ; update the control
    
Return
    
;============================================================
; when you click close button
;============================================================ 

Exit:

    Gui, Submit, NoHide      ; update control variables
    
    ; use script's basename to define ini file panel position and CQC_Variables.ini
    RegExMatch(A_ScriptName, "^(.*?)\.", basename)    ; dont use splitpath to get basename because it cant handle DeltaRush.1.3.exe

    ; get window state
    WinGet, winstate, MinMax, %WINTITLE%
    ; do not save window position if minimized, winx and winy would be something like -32000
    if (winstate != -1) {      
        ; save window dimensions, location, and column widths!    
        WinGetPos , x, y, Width, Height, %WINTITLE%
        IniWrite, %x%, %A_AppData%\%basename1%\%basename1%.ini, Window Position, winx
        IniWrite, %y%, %A_AppData%\%basename1%\%basename1%.ini, Window Position, winy
    }
        
ExitApp

return

Quickchat_Menue:
{
;ingame GUI
{
CustomColor := "000000"  ; Can be any RGB color (it will be made transparent below).
TextColor := "27B6F3"
Gui Gui2:+AlwaysOnTop +LastFound -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Gui2:Color, %CustomColor%
Gui, Gui2:Font, s15. Arial Black  ; Set a large font size (32-point).
Gui, Gui2:Add, Text, vText c%TextColor%,QUICK CHAT
Gui, Gui2:Font, s20. Arial Black  ; Set a large font size (32-point).
Gui, Gui2:Add, Text, y+1 cWhite, INFORMATIONAL
Gui, Gui2:Font, s15. Arial Black  ; Set a large font size (32-point).
i = 1
while i <= number_buttons
{
count_Edit := MyEdit%i%
count_exclamation := exclamation%i%
Gui, Gui2:Add, Text, cBlack, %count_Edit%%count_exclamation%
i++
}
If (MyBox0 = 1)
Gui, GUI2:Add, Text, x-1 c%TextColor%, Press 0 on numpad to leave match
WinSet, Transparent, 185 ; Make all pixels of this color transparent and make the text itself translucent (255)
Gui, Gui2:Show, x%menue_x% y%menue_y% NoActivate  ; NoActivate avoids deactivating the currently active window.

Gui Gui3:+AlwaysOnTop +LastFound -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Gui3:Color, cWhite
Gui, Gui3:Font, s15. Arial Black  ; Set a large font size (32-point).
Gui, Gui3:Add, Text, cwhite, `n
i = 1
while i <= number_buttons
{
count_DLL := MyDLL%i%
Gui, Gui3:Add, Text, c%TextColor%,%count_DLL%
i++
}
Gui, Gui3:Add, Text, ys cwhite,`n
i = 1
while i <= number_buttons
{
count_Edit := MyEdit%i%
count_exclamation := exclamation%i%
Gui, Gui3:Add, Text, c%TextColor%, %count_Edit%%count_exclamation%
i++
}
WinSet, TransColor, cwhite 185 ; Make all pixels of this color transparent and make the text itself translucent (255)
Gui, Gui3:Show, x%menue_x% y%menue_y% NoActivate  ; NoActivate avoids deactivating the currently active window.
}


done = 0
SetTimer, Close, %overlay_time%
while(!done)
{	
	i = 1
	while i <= number_buttons
	{
	count_Edit := MyEdit%i%
	count_punctuation := punctuation%i%
	count_chatmode := chatmode%i%
	StringLen, stringlength, MyEdit%i%
	
	
	;Digipad
	If(GetKeyState("joyPov","p") = Button%i%)
	{
	Gui, Gui2:destroy
	Gui, Gui3:destroy
	sendinput %count_chatmode%
	Sleep %delay%
		if (stringlength > 29)
{
	SetKeyDelay, 1, -1
	sendevent %count_Edit%%count_punctuation%
	sendinput {Enter}
}
		else
{
	sendinput %count_Edit%%count_punctuation%
	sendinput {Enter}
}		
	return
	}
	

	;Button
	Else If(GetKeyState(Button%i%, "P"))
	{
	Gui, Gui2:destroy
	Gui, Gui3:destroy
	sendinput %count_chatmode%
	Sleep %delay%
	if (stringlength > 29)
{
	SetKeyDelay, 1, -1
	sendevent %count_Edit%%count_punctuation%
	sendinput {Enter}
}
	else
{
	sendinput %count_Edit%%count_punctuation%
	sendinput {Enter}
}	
	return
	}
	i++
	}
}	
}
Close:
Gui, Gui2:destroy
Gui, Gui3:destroy
done = 1
return


Numpad0::
If (MyBox0 = 1)
{
delay = 50
send {Esc}
Sleep %delay%
send {Down}
Sleep %delay%
send {Down}
Sleep %delay%
send {Down}
Sleep %delay%
send {Down}
Sleep %delay%
send {Enter}
Sleep %delay%
send {Left}
Sleep %delay%
send {Enter}
return
}
else return

Close_Status:
Status_Time = 1
if(Status_Time = 1)
 SB_SetText("")
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;============================================================
; Return window x and y position from ini file.
;============================================================

GetXY(byref winx, byref winy)   
{

    RegExMatch(A_ScriptName, "^(.*?)\.", basename)    ; dont use splitpath to get basename because it cant handle DeltaRush.1.3.exe

    ;============================================================
    ; position gui based on values from ini file
    ;============================================================
    
    IniRead, winx, %A_AppData%\%basename1%\%basename1%.ini, Window Position, winx, 0
    IniRead, winy, %A_AppData%\%basename1%\%basename1%.ini, Window Position, winy, 0
    
    ; get the width and height of the entire desktop (even if it spans multiple monitors)
    SysGet, VirtualWidth, 78
    SysGet, VirtualHeight, 79

    ; prevent display of gui off-screen (somehow this was still happening to jess, so I added this logic)
    if (winx < 0) OR (winx > VirtualWidth) 
        winx := 0

    if (winy < 0) OR (winy > VirtualHeight)     
        winy := 0    
    
    Return
    
}

;============================================================
; save all gui control values for active gui to ini file
;============================================================

GuiSave(inifile,section,begin="",end="")   
{
    SplitPath, inifile, file, path, ext, base, drive     ; splitpath expects paths with \
    
    if (path = "") {   ; if no path given then use default path
        RegExMatch(A_ScriptName, "^(.*?)\.", basename)    ; dont use splitpath to get basename because it cant handle DeltaRush.1.3.exe
        inifile := A_AppData "\" basename1 "\" inifile
    }
    
    WinGet, List_controls, ControlList, A    ; get list of all controls active gui

    if (begin = "")
        flag := 0
    else 
        flag := 1
        
    Loop, Parse, List_controls, `n
    { 
        ;ControlGet, cid, hWnd,, %A_LoopField%         ; get the id of current control
        GuiControlGet, textvalue,,%A_Loopfield%,Text  ; get associated text
        GuiControlGet, vname, Name, %A_Loopfield%     ; get controls vname
    
        If (vname = "")   ; only save controls which have a vname 
            continue

        if (begin = vname) {
            flag := 0
            continue
        }
            
        if (flag) 
            continue
            
        if (end = vname) 
            break
            
        GuiControlGet, value ,, %A_Loopfield%         ; get controls value
        value := RegExReplace(value, "`n", "|")       ; convert newlines to pipes (for multiline edit fields, because newlines are not valid for ini file)
        
        ; todo: truncate edit values to not exceed ini fieldsize limit (1024?)  OR blank (all or nothing)
        
        IniWrite, % value, %inifile%, %section%, %vname%
        
    }
   
   return
}

;============================================================
; Update gui controls with values from ini file.
;============================================================

GuiRestore(inifile,section)   
{

    SplitPath, inifile, file, path, ext, base, drive     ; splitpath expects paths with \
    
    if (path = "") {   ; if no path given then use default path
        RegExMatch(A_ScriptName, "^(.*?)\.", basename)    ; dont use splitpath to get basename because it cant handle DeltaRush.1.3.exe
        inifile := A_AppData "\" basename1 "\" inifile
    }

    ;============================================================
    ; update gui controls with values from ini file
    ;============================================================    

    WinGet, List_controls, ControlList, A   ; get list of all controls for active gui
    
    Loop, Parse, List_controls, `n
    { 
    
        ;ControlGet, cid, hWnd,, %A_LoopField%         ; get the id of current control
        ;GuiControlGet, textvalue,,%A_Loopfield%,Text  ; get controls associated text
        GuiControlGet, vname, Name, %A_Loopfield%     ; get controls vname
        GuiControlGet, value ,, %A_Loopfield%         ; get controls value
        
        If (vname = "")   ; only process controls which have a vname 
            continue
        
        IniRead, value, %inifile%, %section%, %vname%, ERROR
        
        if (value != "ERROR") {
            
            value := RegExReplace(value, "\|", "`n")       ; convert pipes to newlines (for multiline edit fields, because newlines are not valid for ini file)
            
            RegExMatch( A_Loopfield, "(.*?)\d+", name)   ; extract the control name without numbers
            if (name1 = "ComboBox") {
                GuiControl, ChooseString, %A_Loopfield%, %value%   ; select item in dropdownlist
            } else {
                GuiControl,  ,%A_Loopfield%, %value%    ; update the control
            }
        }
        
    }
    
    return
   
}

GuiMove:
   PostMessage, 0xA1, 2
return

Reset_Text:
{
i = 0
while i <= number_buttons
{ 
i++
GuiControl,,Edit%i%,
}	
return
}

Reset_Buttons:
{
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID1%
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID2%
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID3%
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID4%
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID5%
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID6%
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID7%
SendMessage, 0x014E, -1, 0,, ahk_id %DDL_ID8%
return
}

check_all_boxes:
{
all_boxes_clear = 0
i = 1
while i <= number_buttons
{ 
all_boxes_clear += MyBox%i%
i++
}

if(all_boxes_clear = 0)
{
i = 1
while i <= number_buttons
{ 
GuiControl,, MyBox%i%, 1
MyBox%i% := 1
i++
}
}

else
{
i = 1
while i <= number_buttons
{ 
GuiControl,, MyBox%i%, 0
MyBox%i% := 0
i++
}
}
return
}

Toggle_Mode:
{
if (toggle = 0)
{
i = 1
while i <= number_buttons
{ 
GuiControl, 1:ChooseString, MyDLL2%i%, % "To All"
i++
}
toggle++
}

else
{
i = 1
while i <= number_buttons
{ 
GuiControl, 1:ChooseString, MyDLL2%i%, % "Team Only"
i++
}
toggle := 0
}	
return
}

check_choices:
{
Gui, Submit, NoHide
Dropdownlist := ["","⎕","X","◯","△","L1","R1","L2","R2","Share","Options","L3","R3","PS","🠉","🠊","🠋","🠈","Touch"]
DDLString1 := ""


if (MyDLL0 = Dropdownlist0[1]) ;Delete square
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString0%
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "⎕" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[2]) ;Delete X
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "X" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[3]) ;Delete circle
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "◯" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[4]) ;Delete triangle
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "△" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}	

else if (MyDLL0 = Dropdownlist0[5]) ;Delete L1
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "L1" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[6]) ;Delete R1
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "R1" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[7]) ;Delete L2
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "L2" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[8]) ;Delete R2
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "R2" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[9]) ;Delete Share
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "Share" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[10]) ;Delete Options
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "Options" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[11]) ;Delete L3
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "L3" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[12]) ;Delete R3
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "R3" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[13]) ;Delete PS
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "PS" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[14]) ;Delete 🠉
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "🠉" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[15]) ;Delete 🠊
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "🠊" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[16]) ;Delete 🠋
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "🠋" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[17]) ;Delete 🠈
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "🠈" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

else if (MyDLL0 = Dropdownlist0[18]) ;Delete Touch
{
i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString%  
	i++
}
a := 1 
while a <= Dropdownlist.MaxIndex()	
{
   Dropdownlist[a] = "Touch" ? Dropdownlist.RemoveAt(a) : ++a
   DDLString1 .= "|"Dropdownlist[A_Index]

i = 1
while i <= number_buttons
{
	GuiControl,, MyDLL%i%, %DDLString1%  
	i++
}
}
}

goto go_on
}

