STEAMAPPS="/home/ssd2/SteamLibrary/steamapps/common"

GMOD_BASE=$(STEAMAPPS)/GarrysMod/bin/win64
GMAD=$(GMOD_BASE)/gmad.exe
GMPUSBLISH=$(GMOD_BASE)/gmpublish.exe
PWD=$(shell pwd)
APPID=4000

build:
	protontricks-launch --appid $(APPID) $(GMAD) create -folder "$(PWD)/ttt-traitor-mop" -out "$(PWD)/ttt-traitor-mop.gma"

publish: build
	protontricks-launch --appid $(APPID) $(GMPUBLISH) create -addon "%~dpn1.gma" -icon "%~dpn1.jpg"
