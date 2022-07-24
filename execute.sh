#!bin/bash

# Soal 1 # Gabung file November 2019 dan October 2019
csvstack 2019-Oct-sample.csv 2019-Nov-sample.csv > 2019-Oct-Nov-sample.csv
# Soal 2 # Ambil beberapa kolom yang dibutuhkan saja
csvcut -c 2,3,4,5,7,8,6 2019-Oct-Nov-sample.csv > 2019-Oct-Nov-Sample-Selected.csv
# Soal 3 # Ambil yang event type == purchase saja
csvgrep -c "event_type" -m "purchase" 2019-Oct-Nov-Sample-Selected.csv > 2019-Oct-Nov-Sample-Selected-purchase.csv
# Soal 4
# Buat kolom baru yaitu category
csvcut -c 7 2019-Oct-Nov-Sample-Selected-purchase.csv > category_code.csv
cat category_code.csv | awk -F "." '{print $1}' > category.csv
# Join kolom category
csvjoin 2019-Oct-Nov-Sample-Selected-purchase.csv category.csv > join_category.csv
# Buat kolom baru yaitu product_name
cat category_code.csv | awk -F "." '{print $NF}' > product_name.csv
# Join kolom product_name
csvjoin join_category.csv product_name.csv > data_joint.csv
# Ambil kolom yang dibutuhkan saja
csvcut -c 1,2,3,4,5,6,8,9 data_joint.csv > data_show.csv
#Rename nama kolom
sed -e '1s/category_code2/category/' -e '1s/category_code2_2/product_name/' data_show.csv > data_clean.csv

#Cek terhadap baris
cat data_clean.csv | wc > check_baris.txt

#Cek terhadap category
cat data_clean.csv | grep electronics | grep smartphone| awk -F ',' '{print $5}'| sort | uniq -c | sort -nr > check_category.txt

#Output sesuai dengan soal
cat data_clean.csv | head -10 | csvlook
