!define VERSION "12.4"

!include "LogicLib.nsh"
!include "MUI2.nsh"
!include "nsDialogs.nsh"

!insertmacro MUI_LANGUAGE "English"
!define MUI_PAGE_HEADER_TEXT "Fallout 2 Tweaks Installer"
!define MUI_PAGE_HEADER_SUBTEXT "$VERSION"


Var Dialog
!include "advanced_configuration.nsh"

Name "Fallout 2 Tweaks - $VERSION"
OutFile "FO2tweaks-$VERSION.exe"

Var advanced
Var bundledSfall
var installedSfallVersion
Var installSfall
Var instPath
Var sfall
Var systemDisk

Function .onInit
  strCpy $bundledSfall "$%sfall_version%"
  ReadEnvStr $systemDisk "SYSTEMDRIVE"
  strcpy $INSTDIR "$systemDisk\GOG Games\Fallout 2\"
  strcpy $instPath $INSTDIR
  strcpy $advanced "1"
  strcpy $max_knockback_state = "-1"
  strcpy $min_light_level_state "0"
  strcpy $townmap_key_state "Y"
  strcpy $worldmap_key_state "W"
  strcpy $installedSfallVersion "0"
FunctionEnd

!define MUI_WELCOMEPAGE_TITLE "Welcome to the Fallout 2 Tweaks $VERSION Installer"
!define MUI_WELCOMEPAGE_TEXT "Click next to begin your installation."

!define MUI_PAGE_WELCOME
!define MUI_PAGE_LICENSE "${NSISDIR}\Docs\License.txt"
Page custom installDirPage installDirLeave
Page custom installSfallPage InstallSfallLeave
Page custom basicOrAdvancedPage basicOrAdvancedLeave
Page custom inventoryPageConfig InventoryPageLeave
Page custom partyPageConfig partypageleave
Page custom speedPageConfig speedPageLeave
Page custom combatPageConfig combatPageLeave
Page custom utilityPageConfig utilityPageLeave
Page custom miscPageConfig miscPageLeave
Page custom confirmPageConfig confirmPageLeave
!define MUI_PAGE_INSTFILES
!define MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_DIRECTORY
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

Function installDir

  !insertmacro MUI_HEADER_TEXT "Install Location" "Provide the path to your Fallout 2 installation."

  nsDialogs::Create 1018
  Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  EnableWindow $NextButton 0

  ${NSD_CreateGroupBox} 5%  90% 34u "Fallout 2 Install Path"
  Pop $0

    ${NSD_CreateDirRequest} 15% 100u 49% 12u "$INSTDIR"
    Pop $instPath

    ${NSD_OnChange} $instPath checkInstallPath

    ${NSD_CreateBrowseButton} 65% 100u 20% 12u "Browse..."
    Pop $0
    ${NSD_OnClick} $0 OnDirBrowse

    nsDialogs::Show

FunctionEnd

Function "installDirLeave"

  ${NSD_GetText} $instPath $INSTDIR

FunctionEnd

Function "checkInstallPath"
  IfFileExists "$instPath\fallout2.exe" 0 +2
  EnableWindow $NextButton 1

FunctionEnd

Function OnDirBrowse
    ${NSD_GetText} $instPath $0
    nsDialogs::SelectFolderDialog "Select Fallout 2 Directory" "$0"
    Pop $0
    ${If} $0 != error
        ${NSD_SetText} $instPath "$0"
    ${EndIf}
FunctionEnd

Function "sfallStatus"

  IfFileExists $InstPath\sfall.dll 0 +11
    GetDllVersion "$InstPath\sfall.dll" $R0 $R1
    IntOp $R2 $R0 \ 0x00010000
    IntOp $R3 $R0 & 0x0000FFFF
    IntOp $R4 $R1 \ 0x00010000
    IntOp $R5 $R1 & 0x0000FFFF
    StrCpy $0 "$R2.$R3.$R4.$R5"
    ${VersionCompare} $bundledSfall $0 $sfall
    StrCpy $0 $installedSfallVersion
    Return
  Goto +2
    StrCpy $sfall 0
    Return

FunctionEnd

Function "installSfallPage"

  !insertmacro MUI_HEADER_TEXT "Sfall Installation" "Sfall is not installed or is older than the bundled version."

  nsDialogs::Create 1018
  Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  Call sfallStatus

  # 1 = Bundled Version > Installed
  # 2 = installedVersion > Bundled
  # 3 = Not Installed
  ${IF} $sfall == 2
    Abort
  ${Else}
    StrCpy $installSfall 1
  ${EndIf}



  ${NSD_CreateLabel} 20% 26u 20% 10u "Sfall $bundledSfall will be installed."
  Pop $0

  ${If} $installedSfallVersion != 0
    ${NSD_CreateLabel} 20% 40u 20% 10u "Currently installed Sfall version: $installedSfallVersion"
    Pop $0
  ${EndIf}

  nsDialogs::Show

FunctionEnd

Function "RadioClick"
	Pop $hwnd
	${NSD_GetUserData} $hwnd $0
	${If} $0 == "Basic"
    strcpy $advanced 0
	${ElseIf} $0 == "Advanced"
    strcpy $advanced 1
	${EndIf}
FunctionEnd


Function "basicOrAdvancedPage"
  !insertmacro MUI_HEADER_TEXT "Installation Type" "Please select your installation type."

  nsDialogs::Create 1018
  Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

		Pop $dialog
	${NSD_CreateRadioButton} 0 0 40% 6% "Advanced installation"
		Pop $hwnd
		${NSD_AddStyle} $hwnd ${WS_GROUP}
		${NSD_SetUserData} $hwnd "Advanced"
		${NSD_OnClick} $hwnd RadioClick
	${NSD_CreateRadioButton} 0 12% 40% 6% "Basic installation"
		Pop $hwnd
		${NSD_SetUserData} $hwnd "Basic"
		${NSD_OnClick} $hwnd RadioClick

  nsDialogs::Show

FunctionEnd

Function "basicOrAdvancedLeave"

  ${NSD_GetText} $showAdvancedPages $advanced

FunctionEnd

Function "confirmPageConfig"

  nsDialogs::Create 1018
  Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

  ${If} $installedSfallVersion != 0
    ${NSD_CreateLabel} 20% 26u 50%% 10u "Currently installed Sfall version ($installedSfallVersion) will be used."
    Pop $0
  ${EndIf}
  ${NSD_CreateLabel} 20% 26u 50%% 10u "Sfall $bundledSfall will be installed."
  Pop $0

  ${If} $advanced == 1
    ${NSD_CreateLabel} 20% 40u 50% 10u "Advanced configuration was selected."
    Pop $0
  ${Else}
    ${NSD_CreateLabel} 20% 40u 50% 10u "Basic configuration was selected."
    Pop $0
  ${EndIf}

  nsDialogs::Show

FunctionEnd

Function confirmPageLeave

  SetOutPath $InstPath

  ${If} $InstallSfall == 1
    File ".\sfall\ddraw.dll"
  ${EndIf}

  SetOutPath $INSTDIR
  IfFileExists "$instPath\ddraw.ini" +2 0
    File ".\sfall\ddraw.ini"
  File ".\sfall\ddraw.dll"

  SetOutPath "$InstPath\mods"

  File "mods\fo2tweaks.dat"

  ${If} $advanced == 1
    Call writeKeys
    File "$TEMP\fo2tweaks.ini"
  ${Else}
    File "mods\fo2tweaks.ini"
  ${EndIf}

FunctionEnd
