"C:\Users\manso\AppData\Local\FlashDevelop\Apps\flexairsdk\4.6.0+32.0.0\bin\mxmlc" -load-config+="D:\workspace\fo76\src\ModManager\mod\obj\ModManagerConfig.xml" -incremental=true -swf-version=36 -o "D:\workspace\fo76\output\Interface\ModManager.swf"
cp "D:\workspace\fo76\src\ModManager\securetrade.swf" "D:\workspace\fo76\output\Interface"


currentDir=$(pwd)
# YOU SHOULD MODIFY THIS VALUES
modName="ModManagerSecureTrade"
archiveRootFolder="Interface"

finalArchiveName="$modName.ba2"
outputDir="output"
arch2Path="$currentDir/tools/ba2Cli.exe"
outputModDir="mod"

rm -rf "$currentDir/$outputDir/$archiveRootFolder/ModManager.swf.cache"
$arch2Path -i "$currentDir/$outputDir/$archiveRootFolder" -o "$currentDir/$outputDir/$outputModDir/$finalArchiveName"
cp "$currentDir/$outputDir/$outputModDir/$finalArchiveName" "C:\Program Files (x86)\Steam\steamapps\common\Fallout76\Data"
cp "D:\workspace\fo76\src\ModManager\mod\modManagerConfig.json" "C:\Program Files (x86)\Steam\steamapps\common\Fallout76\Data"