@echo off
rem call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x64

set CommonCompilerFlags=/MT /nologo /Gm- /GR- /EHa /Od /Oi /WX /W4 /wd4201 /wd4100 /wd4189 /wd4505 /DHANDMADE_INTERNAL=1 /DHANDMADE_SLOW=1 /Z7 
set CommonLinkerFlags= -incremental:no -opt:ref  user32.lib gdi32.lib winmm.lib

IF NOT EXIST build mkdir build
pushd build

REM compilar pra winXP
rem cl %CommonCompilerFlags% ../handmade/win32_handmade.cpp /link -subsystem:windows,5.1 %CommonLinkerFlags%

rem compilar normal x64
del *.pdb >NUL 2> NUL
cl /D_USRDLL /D_WINDLL %CommonCompilerFlags% ../handmade/handmade.cpp /Fmhandmade.map /LD /link /PDB:handmade_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%.pdb /EXPORT:GameUpdateAndRender /EXPORT:GameGetSoundSamples -incremental:no
cl %CommonCompilerFlags% ../handmade/win32_handmade.cpp /Fmwin32_handmade.map /link %CommonLinkerFlags%

popd
