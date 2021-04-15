currentDir=$(pwd)
# YOU SHOULD MODIFY THIS VALUES
modName="InventOmaticPipboy"
flashPath="D://Program Files//AdobeAnimateCC//Adobe Animate CC 2019//Animate.exe"
archiveRootFolder="Interface"

finalArchiveName="$modName.ba2"
finalSwfName="$modName.swf"
pathToModSources="$currentDir/src/$modName"
mainAsFile="$pathToModSources/mod/$modName.as"
outputDir="output"
# END USER MOD SETTINGS
arch2Path="$currentDir/tools/ba2Cli.exe"
outputModDir="mod"

# DEBUG/COMPILATION SECTION
COMPILE_FLA=true
CLEAR_ALL=true
DEBUG_DISABLED=true
# END DEBUG/COMPILATION SECTION

if $CLEAR_ALL;
then
  rm -rf $currentDir/$outputDir
  mkdir "$outputDir"/"$archiveRootFolder" -p
fi

if $COMPILE_FLA;
then
  flc --input-directory "$pathToModSources/mod" --output-directory "$currentDir/$outputDir/$archiveRootFolder" --interactive-compiler "$flashPath" --include-pattern "*.fla"
  if $DEBUG_DISABLED;
  then
    cd "$currentDir/$outputDir/$archiveRootFolder"
    rm commands.txt
    rm error.txt
    rm info.txt
    cd "$currentDir"
  fi
else
  echo "FLA file compilation skipped"
fi

find "$pathToModSources" -name \*.swf -exec cp {} "$currentDir/$outputDir/$archiveRootFolder" \;
$arch2Path -i "$currentDir/$outputDir/$archiveRootFolder" -o "$currentDir/$outputDir/$outputModDir/$finalArchiveName"