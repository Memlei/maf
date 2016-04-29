#!/bin/bash

matlab_exec=matlab

#Remove the first two arguments
i=0
for var in "$@"
do
 args[$i]=$var
 let i=$i+1
done
unset args[0]

#Construct the Matlab function call
X="${1}("
for arg in ${args[*]} ; do
  #If the variable is not a number, enclose in quotes
  if ! [[ "$arg" =~ ^[0-9]+([.][0-9]+)?$ ]] ; then
    X="${X}'"$arg"',"
  else
    X="${X}"$arg","
  fi
done
X="${X%?}"
X="${X})"

echo The MATLAB function call is ${X}

#Call Matlab
echo "cd('`pwd`');${X}" > matlab_command.m
${matlab_exec} -nojvm -nodisplay -nosplash < matlab_command.m

#Remove the matlab function call
rm matlab_command.m