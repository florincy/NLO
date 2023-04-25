#!/bin/bash
Methods=('B1B95' 'PW6B95' 'CAM-B3LYP')
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
  mpirun -np 2 /scr/programas/nwchem-7.0.2/bin/LINUX64/nwchem ${inputNWCHEM} >${outputNWCHEM} &
  wait
done
echo "Os seus calculos foram concluidos!" | mail -s "*Done*" simoneflorency@gmail.com