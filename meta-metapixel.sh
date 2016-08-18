#!/bin/bash

fps=$(ffmpeg -i "$1" 2>&1 | sed -n "s/.*, \(.*\) tbr.*/\1/p")
res="$(ffmpeg -i "$1" 2>&1 | grep Stream | grep -m 1 -oP ', \K[0-9]+x[0-9]+')"
x="$(echo ${res} | awk -Fx '{print $1}')"
y="$(echo ${res} | awk -Fx '{print $2}')"

echo "processing file $1 with fps: $fps , width: $x , and heigth: $y";

work_dir="workfiles_$(basename $1)"
mkdir $work_dir
mkdir $work_dir/inp
mkdir $work_dir/tiles
mkdir $work_dir/out

mplayer -vo jpeg:outdir="$work_dir/inp" -ao pcm:file=$work_dir/audiodump.wav "$1"

metapixel-prepare --width=$(($x/12)) --height=$(($y/12)) $work_dir/inp $work_dir/tiles

for i in $work_dir/inp/*.jpg
do
	metapixel -s 3 -d 3 --width=$(($x/12)) --height=$(($y/12)) --library=$work_dir/tiles/ --cheat=20 --metapixel "$i" $work_dir/out/$(basename $i)
done

if [ -f "./metapixeled_$1" ];
then
   echo "Metapixeled file already exists."
else
   mencoder mf://$work_dir/out/*.jpg -mf fps=$fps  -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=8192 -oac mp3lame -audiofile $work_dir/audiodump.wav -o "./metapixeled_$1"
fi
