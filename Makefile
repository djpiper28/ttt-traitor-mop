STEAMAPPS="/home/ssd2/SteamLibrary/steamapps/common"

GMOD_BASE=$(STEAMAPPS)/GarrysMod/bin/win64
GMOD_ADDONS=$(STEAMAPPS)/GarrysMod/garrysmod/addons
GMAD=$(GMOD_BASE)/gmad.exe
GMPUBLISH=$(GMOD_BASE)/gmpublish.exe
PWD=$(shell pwd)
APPID=4000
BUILD_OUTPUT=ttt-traitor-mop.gma

build:
	protontricks-launch --appid $(APPID) $(GMAD) create -folder "$(PWD)/ttt-traitor-mop" -out "$(PWD)/$(BUILD_OUTPUT)"

publish: build
	protontricks-launch --appid $(APPID) $(GMPUBLISH) create -addon "$(BUILD_OUTPUT)" -icon "steam-mop.jpeg"

install:
	rm -rf "$(GMOD_ADDONS)/ttt-traitor-mop"
	cp -r ttt-traitor-mop/ "$(GMOD_ADDONS)/"
