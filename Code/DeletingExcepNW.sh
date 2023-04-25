#!/bin/bash
Methods=('BLYP' 'BP86' 'OLYP' 'PW91' 'mPW91' 'revPBE' 'TPSS' 'M06-L' 'M11-L' 'PBE0' 'B3LYP' 'mPW1K' 'BHandHLYP' 'BHandH' 'SOGGA11-X' 'M06' 'M06-2X' 'M06-HF' 'BB1K' 'mPWB1K' 'mPW1B95' 'PW6B95' 'M11' 'CAM-B3LYP' 'LC-BLYP' 'LC-PBE' 'LC-wPBE' 'LRC-wPBEh')
echo "Lets start some calculations?"
directory=$(zenity --title="Select the directory" --file-selection --directory)
echo "$directory"
for i in ${!Methods[@]}; do
  echo "element $i is ${Methods[$i]}"
  Method=${Methods[i]}
  directory2="${directory}/${Method}"
  cd ${directory2}
  input=$(find $directory2 -type f -name '*.nw')
  inputNWCHEM=$(basename -- $input)
  outputNWCHEM=$(basename -s .nw $input)".out"
  #echo $inputNWCHEM
  echo $outputNWCHEM
  cd ${directory2}
  ls
  find . -type f ! -iname "*.nw" -delete
  ls
done