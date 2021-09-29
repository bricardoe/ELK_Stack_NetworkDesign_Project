#!/bin/bash

myStates=('Nebraska' 'Hawaii' 'California');

nums={0..9};

for x in ${myStates[@]};
do
if [ $x = "Hawaii" ];
then
        echo "Hawaii is the best!"
else
        echo "I'm not fond of Hawaii"
fi
done;
