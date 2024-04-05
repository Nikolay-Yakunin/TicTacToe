@echo off

setlocal enabledelayedexpansion

set "count=0"

for /L %%n in (0,1,8) do (
    set "ARRAY[%%n]=%%n"
)

set "turn=X"

:game_loop
cls
echo   !ARRAY[0]! ^| !ARRAY[1]! ^| !ARRAY[2]!
echo  ---+---+---
echo   !ARRAY[3]! ^| !ARRAY[4]! ^| !ARRAY[5]!
echo  ---+---+---
echo   !ARRAY[6]! ^| !ARRAY[7]! ^| !ARRAY[8]!
echo

echo It's %turn%'s turn.
echo Enter the number of the cell.

set /p cell=

if "!cell!" GTR "8" (
    echo Invalid cell number. Try again.
    timeout /t 2 >NUL
    goto game_loop
)

if "!cell!" LSS "0" (
    echo Invalid cell number. Try again.
    timeout /t 2 >NUL
    goto game_loop
)

if "!ARRAY[%cell%]!"=="X" (
    echo This cell is already occupied. Try again.
    timeout /t 2 >NUL
    goto game_loop
)

if "!ARRAY[%cell%]!"=="O" (
    echo This cell is already occupied. Try again.
    timeout /t 2 >NUL
    goto game_loop
)

set "ARRAY[%cell%]=%turn%"
set /a count+=1

if "%turn%"=="X" (
    set "turn=O"
) else (
    set "turn=X"
)

for %%x in (012 345 678 036 147 258 048 246) do (
    set "check=%%x"

    set /A "pos1=!check:~0,1!"
    set /A "pos2=!check:~1,1!"
    set /A "pos3=!check:~2,1!"

    call set "line=%%ARRAY[!pos1!]%%%%ARRAY[!pos2!]%%%%ARRAY[!pos3!]%%"
    if "!line!"=="XXX" (
        echo Player X wins!
        pause >NUL
        exit /b
    )
    if "!line!"=="OOO" (
        echo Player O wins!
        pause >NUL
        exit /b
    )
)

if !count! EQU 9 (
    echo The game is a draw.
    pause >nul
    exit /b
)


goto game_loop