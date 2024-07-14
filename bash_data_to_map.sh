#!/bin/bash
cut -d";" -f2 data.csv > 1.txt
sed -i -e 's/^/https:\/\/youtu.be\//' 1.txt 
cut -d";" -f7 data.csv > 2.txt
paste -d ' ' *.txt > 11.txt
cut -d";" -f5 data.csv > 3.txt
cut -d";" -f6 data.csv > 4.txt
paste -d ';' 11.txt 3.txt 4.txt > map.csv
sed -i '1 i\name;lat;lon' map.csv
cat map.csv
rm 1.txt 2.txt 11.txt 3.txt 4.txt

