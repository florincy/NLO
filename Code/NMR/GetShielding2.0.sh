#!/bin/bash
Methods=('B1B95' 'PW6B95' 'CAM-B3LYP')
echo "."
#echo "Lets Collect your Data?. Works for Shielding"
directory=$(zenity --title="Select the directory" --file-selection --directory)
#echo "$directory"
for i in ${!Methods[@]}; do
  directory2="${directory}/${Methods[i]}"
  cd ${directory2}
  input=$(find $directory2 -type f -name '*.nw')
  inputNWCHEM=$(basename -- $input)
  outputNWCHEM=$(basename -s .nw $input)".out"
  #echo $inputNWCHEM
  #echo $outputNWCHEM
  grep "Wrote CPHF data to ./molecule.shieldcphf" ${outputNWCHEM} -B1 -A30 > Selected.out
done 
for i in ${!Methods[@]}; do
  directory2="${directory}/${Methods[i]}"
  cd ${directory2}
  export shielding=$(grep "isotropic"  Selected.out)
  echo ${Methods[$i]} ${shielding} >> $directory/ShieldingConstants.txt
  echo "${Methods[$i]}"
  echo ${shielding}
done
