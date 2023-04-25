#!/bin/bash
Methods=('B3LYP' 'CAM-B3LYP')
echo "."
#echo "Lets Collect your Data?. Works for Shielding"
directory=$(zenity --title="Select the directory" --file-selection --directory)
#echo "$directory"
ResultsPath=$directory/Results.txt
echo $ResultsPath
for i in ${!Methods[@]}; do
  directory2="${directory}/${Methods[i]}"
  cd ${directory2}
  input=$(find $directory2 -type f -name '*.com')
  inputGAUSSIAN=$(basename -- $input)
  outputGAUSSIAN=$(basename -s .com $input)".log"
  #echo $inputGAUSSIAN
  #echo $outputGAUSSIAN
  NlinesEnergy="$(grep -n "Electric dipole moment (input orientation):" ${outputGAUSSIAN} | cut -d : -f 1)"
  NlinesDipoleMoment="$(grep -n "Electric dipole moment (dipole orientation):" ${outputGAUSSIAN} | cut -d : -f 1)"
  N=$(($NlinesDipoleMoment-$NlinesEnergy))
  grep "Electric dipole moment (input orientation):" ${outputGAUSSIAN} -B1 -A$N > EnergyReference.txt
  grep "Electric dipole moment (dipole orientation):" ${outputGAUSSIAN} -B1 -A$N > DipoleMomentReference.txt
  echo "${Methods[$i]}:" >> $directory/Results.txt
  grep -q "Beta(-w;w,0)" EnergyReference.txt 
  if [ $? -eq 0 ]; then
    echo "Beta(-w,w,0):" >> $directory/Results.txt
    grep -l "Beta(-w;w,0)" -A7 * | xargs grep -w "x " EnergyReference.txt | head -n 1 >> $directory/Results.txt
    grep -l "Beta(-w;w,0)" -A7 * | xargs grep -w "y " EnergyReference.txt | head -n 1 >> $directory/Results.txt
    grep -l "Beta(-w;w,0)" -A7 * | xargs grep -w "z " EnergyReference.txt | head -n 1 >> $directory/Results.txt
  else
    #echo "Erro: Campo não requisitado no input" 
    :
  fi
  grep -q "Beta(-2w;w,w)" EnergyReference.txt
  if [ $? -eq 0 ]; then
    echo "Beta(-2w,w,w):" >> $directory/Results.txt
    grep -l "Beta(-2w;w,w)" -A7 * | xargs grep -w "x " DipoleMomentReference.txt | head -n 1 >> $directory/Results.txt
    grep -l "Beta(-2w;w,w)" -A7 * | xargs grep -w "y " DipoleMomentReference.txt | head -n 1 >> $directory/Results.txt
    grep -l "Beta(-2w;w,w)" -A7 * | xargs grep -w "z " DipoleMomentReference.txt | head -n 1 >> $directory/Results.txt
  else
    #echo "Erro: Campo não requisitado no input"
    :
  fi
done 
