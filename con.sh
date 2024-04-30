#!/bin/bash
# python3 ../yt-dlp  --write-description   --skip-download -v https://www.youtube.com/@DE-85307-Hohenbuch-Mitte 

mkdir $1
cd $1
python3 ../yt-dlp  --write-description   --skip-download -v https://www.youtube.com/$1 
echo "done yt-dlp"
sleep 4
mapfile -t < <(ls -d -- www.h-o-h.net*)
#printf "%s" "${MAPFILE[1]}"

for i in "${!MAPFILE[@]}"; do  
    pard_id=${MAPFILE[$i]%]*}
    v_id=${pard_id: -11}
    echo $1";"$v_id";"`sed -n '1p' "${MAPFILE[$i]}"`";"`sed -n '2p' "${MAPFILE[$i]}"`";"`sed -n '3p' "${MAPFILE[$i]}"`";"`sed -n '4,$p' "${MAPFILE[$i]}"` | tee -a ../data2.csv
    sleep 2
done
