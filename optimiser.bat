@echo off
rem Web image optimiser
rem Marty Childs, 2015
rem copy %1 %~n1"_"%~x1

:initialise
	IF %1.==. GOTO Skip
	set input=%1
	set output=%1
	set quality=-quality 70
	set resize=

	IF %1==-h ( 
		GOTO Usage
	)
	IF %1==--help (
		GOTO Usage
	)
	Shift
GOTO Loop

:Loop
	IF %1.==. GOTO EndParam

	IF %1==-o (
	set "output=%2"
	)
	IF %1==--output (
	set "output=%2"
	)

	IF %1==-q ( 
	set "quality=-quality %2"
	)
	IF %1==--quality (
	set "quality=-quality %2"
	)

	IF %1==-r ( 
	set first=%2
	set resize=-resize %first%x%2

	)
	IF %1==--resize (
	set first=%2
	set resize=-resize %first%x%2
	)

	IF %1==-h ( 
		GOTO Usage
	)
	IF %1==--help (
		GOTO Usage
	)

	Shift
GOTO Loop

:EndParam
	echo Optimising %input% as %output% %resize% %quality%
	img_convert %input% %quality% %resize% %output% 
	exiftool -all= %output% -overwrite_original -q
GOTO:EOF

:Skip
	echo Please specify an image file, for help type "optimiser.bat --help"
GOTO:EOF

:Usage
	echo Web image optimiser
	echo Marty Childs. 2015
	echo "usage: input_file [[[-o output_file ] [-q quality] [-r resize]] | [-h]]"
GOTO:EOF
