# Fallout 76 mod creation utility (swf)

Most likely in future I'll clean this up and make a separate small utility that can be used in much easier way.

#Disclaimer

# Fo76 officially doesn't support mods
# see https://help.bethesda.net/app/answers/detail/a_id/44429/kw/Mod

But still, at your own risk you may try & mod the game.

Note, that in most cases (I say most cases, since for sure kind of cheats can be created, that will modify ...(lets stop here). And impact other users experience).

### Installation

####1. Install NPM - https://www.npmjs.com/get-npm

####2. Install npm module `flc` globally

Required in order to be able to call Adobe Flash compiler in cli mode (e.g. by running single script)

https://www.npmjs.com/package/flc

e.g. `npm install -g flc`

Verify installation by simply running `flc` in cmd or git bash or any other terminal you're using
 
####3. Checkout `build.bat` file:

1. `SET arch2Path="E:\SteamLibrary\steamapps\common\Fallout 4\Tools\Archive2\Archive2.exe"` - update this line to your FO4 with Creation Kit folder, pointing to Archive2.exe,
e.g. 
`SET arch2Path="C:\Games\Fallout 4\Tools\Archive2\Archive2.exe"`

2. `SET flashPath="D:\Program Files\Adobe\Adobe Flash CS6\Flash.exe"` - update this line to your Adobe Flash exe file (required in order to compile `.fla` files into swf)

3. `SET finalArchiveName="<yourModeName>.ba2"` - change `<yourModeName>` to your actual mod name

####4. Run `build.bat` file

Search for `.ba2` file in the `output` directory - that's your ready-to-use mod.

### Mod developing

TODO: I can't provide any specific steps at this moment, general guidelines(that may not work, lol, I'm just starting playing around and will update this section):

Basically, you may modify just visual stuff and no-one except you won't be able to see that.
This is not about modifying textures (there are plenty videos on youtube, search for fo4 also).

As an example - you may want to add a specific button in your pip-boy or modify terminal, whatever:
1. Search for Bethesda's `.ba2` files in your FO76 data folder.

Open it via BSA Browser (or any similar tools, search them on nexus).

In most cases you will need `SeventySix - Interface.ba2` file, simply find needed swf file inside (this entire project is just about swf files).

2. Extract its content via JPEXS Free Flash Decompiler (make sure you will export a `.fla` file also) into src folder of this project.

3. Make any changes you need.

4. Run `build.bat` file.

5. Install final mod via mod manager (all the links provided below).

6. Side note, if you want to be able to load your custom mod via original `swf` file, make sure you include it in the output folder, so the build script will include them altogether (will provide more details on this, once will have an example, that I could show to people).





### Resources
  
1. https://github.com/AlexxEG/BSA_Browser - extractor for BA2 and BSA files of Bethesda resources (in case you need to modify smth there and include that in your mod)

2. https://www.nexusmods.com/fallout76/mods/221 - Mod manager for super easy mods installation/removal

3. https://github.com/jindrapetrik/jpexs-decompiler - JPEXS Free Flash Decompiler

## Special thanks to `registrator2000`, author of [Better Inventory mod](https://www.nexusmods.com/fallout76/mods/32) who guided me through my very first changes in already existing mod.
