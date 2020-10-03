currentDir=$(pwd)
# YOU SHOULD MODIFY THIS VALUES
#finalArchiveName="LoggerMod.ba2"
modName="ItemExtractorMod"
finalArchiveName="$modName.ba2"
finalSwfName="$modName.swf"
pathToModSources="$currentDir/src/itemExtractorMod"
mainAsFile="$pathToModSources/mod/$modName.as"
#flashPath="D://Program Files//Adobe Flash CS6//Flash.exe"
outputDir="output"
archiveRootFolder="Interface"
# END USER MOD SETTINGS
arch2Path="$currentDir/tools/ba2Cli.exe"
outputModDir="mod"

# DEBUG/COMPILATION SECTION
DEBUG=true
COMPILE_FLA=true
#CLEAR_ALL=true
# END DEBUG/COMPILATION SECTION
#
#if $CLEAR_ALL;
#then
#  rm -rf "$currentDir"/"$outputDir"
#  # Create new output dir and copy original files
#  mkdir "$outputDir"
#  cd "$outputDir"
#  mkdir "$archiveRootFolder"
#  for file in "${originalModFiles[@]}"
#  do
#    cp "$currentDir/$originalModDir/$file" "$currentDir/$outputDir/$archiveRootFolder"
#  done
#  # end create new output dir
#fi
#exit 0

if $COMPILE_FLA;
then
#  flc --input-directory "$currentDir/src/orig" --output-directory "$currentDir/$outputDir/$archiveRootFolder" --interactive-compiler "$flashPath" --include-pattern "*.fla"
#  flc --input-directory "$pathToModSources/mod" --output-directory "$currentDir/$outputDir/$archiveRootFolder" --interactive-compiler "$flashPath" --include-pattern "*.fla"
sh /d/SDK/air/bin/mxmlc "$mainAsFile" -warnings=false -output $outputDir/$archiveRootFolder/$finalSwfName -swf-version 10 -target-player 11.1
#  echo "Nothing to compile"
else
  echo "FLA file compilation skipped"
fi

#if $DEBUG;
#then
#  cd "$currentDir/$outputDir/$archiveRootFolder"
#  rm commands.txt
#  rm error.txt
#  rm info.txt
#  cd "$currentDir"
#else
#  echo "Debug is off"
#fi
find "$pathToModSources" -name \*.swf -exec cp {} "$currentDir/$outputDir/$archiveRootFolder" \;
$arch2Path -i "$currentDir/$outputDir/$archiveRootFolder" -o "$currentDir/$outputDir/$outputModDir/$finalArchiveName"