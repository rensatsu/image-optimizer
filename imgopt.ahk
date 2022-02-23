#NoTrayIcon
#NoEnv

Title := "Image Optimizer"

if A_Args.Length() < 1 {
    MsgBox, 0x30, %Title%, There are no files to optimize.`nPlease, pass files to optimize as command line arguments.
    ExitApp, 1
}

ArgsLength := A_Args.Length()

Gui, New, -MaximizeBox -MinimizeBox, %Title%
Gui, Add, Text, w250 vFName, File: -
Gui, Add, Progress, w250 h20 vFProgress Range0-%ArgsLength%, 0
Gui, Show

for n, param in A_Args {
    if not FileExist(param) {
        MsgBox, 0x30, %Title%, File doesn't exist: %param%!
        Continue
    }

    if InStr(FileExist(param), "D") {
        Continue
    }

    SplitPath, param, , fileDir, , fileName
    outPath := fileDir . "\optimized"
    outImgPath := outPath . "\" . fileName . ".jpg"
    GuiControl,, FName, %fileName% (%n% of %ArgsLength%)
    RunWait, %ComSpec% /c "mkdir %outPath%", , Hide
    RunWait, %ComSpec% /c "magick.exe convert %param% -quality 85`% %outImgPath%", , Hide
    procProgress := ((100 * %n%) // %ArgsLength%)
    GuiControl,, FProgress, %n%
}

MsgBox, 0x40, %Title%, All images has been processed.

GuiClose:
ExitApp

Gui, Cancel
Gui, Hide
Gui, Destroy
