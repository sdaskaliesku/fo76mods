@echo off
SET arch2Path="E:\SteamLibrary\steamapps\common\Fallout 4\Tools\Archive2\Archive2.exe"
SET flashPath="D:\Program Files\Adobe\Adobe Flash CS6\Flash.exe"
SET outputDir="./output/Interface"
SET finalArchiveName="BetterInventory.ba2"
SET finalArchivePath=%outputDir%/%finalArchiveName%
SET DEBUG=True
SET COMPILE_FLA=True
SET BA2_SUBFOLDER=Interface
rem actual compilation
if %COMPILE_FLA% equ True (
  call flc --input-directory "./src/" --output-directory %outputDir% --include-pattern "*.fla" --interactive-compiler %flashPath%
) else (
  echo FLA file compilation skipped
)

rem remove fla compilation files, comment out next line if you need to debug
IF %DEBUG% equ True (
    cd %outputDir%
    del commands.txt
    del error.txt
    del info.txt
) else (
  echo Debug is off
)
rem for /f "delims=" %%a in ('powershell -Command "[System.IO.Path]::GetFullPath( '%outputDir%' )"') do @set resolvedPath=%%a
rem echo %resolvedPath%/%BA2_SUBFOLDER% > %outputDir%/source.txt
rem creating ba2 archive
rem cd %outputDir%
rem %arch2Path% -?
rem %arch2Path% -create=%finalArchiveName% -sourceFile=../source.txt
