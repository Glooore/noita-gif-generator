#!/bin/sh

file_path=$1
file=$(basename -- "${file_path}")
file_name="${file%.*}"
directory=$(dirname "${file_path}")
png_path="${directory}/${file_name}.png"


if [ -f ${file_path} ]; then
	echo "${file_path} was found, proceeding"
else
	echo "${file_path} was not found, exiting"
	exit -1
fi

# xmllint ${file_path} --xpath "/Sprite/RectAnimation" 
# echo $(xml_grep "RectAnimation" ${file_path} --text_only)

n_anims=$(cat ${file_path} | grep "<RectAnimation" | wc -l)
name=($(cat ${file_path} | grep "[^e]name" | cut -d '"' -f 2))
pos_x=($(cat ${file_path} | grep "pos_x" | cut -d '"' -f 2))
pos_y=($(cat ${file_path} | grep "pos_y" | cut -d '"' -f 2))
width=($(cat ${file_path} | grep "frame_width" | cut -d '"' -f 2))
height=($(cat ${file_path} | grep "frame_height" | cut -d '"' -f 2))
n_frames=($(cat ${file_path} | grep "frame_count" | cut -d '"' -f 2))
frame_wait=($(cat ${file_path} | grep "frame_wait" | cut -d '"' -f 2))

echo ${name[*]}
echo "number of animations: ${n_anims}"

for ((j = 0; j < $n_anims; j++)); do
	echo "initial x: ${pos_x[$j]}"
	echo "initial y: ${pos_y[$j]}"
	echo "width: ${width[$j]}"
	echo "height: ${height[$j]}"
	echo "number of frames: ${n_frames[$j]}"
	echo "frame wait: ${frame_wait[$j]}"
	delay=($(echo "${frame_wait[$j]} * 100" | bc -l))
	echo "delay between frames [ms]: ${delay}"
	echo "path to image: ${png_path}"

	echo "generating frames"
	for ((i = 0; i < ${n_frames[$j]}; i++)); do
		cur_x=$((${pos_x[$j]} + width * i))
		magick -extract ${width[$j]}x${height[$j]}+${cur_x}+${pos_y[$j]} ${png_path} -repage +0+0 -scale 300% "noita_tmp_${i}.png"
	done

	echo "generating gif"
	magick -delay ${delay} -dispose Background -loop 0 -page +0+0 noita_tmp*.png ${file_name}_${name[$j]}.gif

	echo "removing temporary files"
	rm noita_tmp*.png
done


# echo ${pos_x}
