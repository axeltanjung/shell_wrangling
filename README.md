# tugas4_shell
Repository ini berisikan hasil Tugas 4 Shell Pacmann

**1. Tujuan Pengerjaan Proyek** 

Tujuan dari proyek ini adalah melakukan data wrangling pada file data traffic ecommerce untuk mendapatkan fitur fitur yang relevan guna melakukan analisis produk yang terjual

**2. Detail / Deskripsi Task**

Terdapat data traffic ecommerce dengan 2 buah file csv yaitu 2019-Oct-sample.csv dan 2019-Nov-sample.csv. Data wrangling dilakukan dengan menggunakan Bash, Csvkit, dan Git untuk Version Control System.

Berdasarkan soal, terdapat 4 tahapan utama yang perlu dilakukan:

**a. Soal 1. Menggabungkan file November 2019 dan October 2019**

```csvstack 2019-Oct-sample.csv 2019-Nov-sample.csv > 2019-Oct-Nov-sample.csv```

Syntax tersebut melakukan penggabungan secara bertumpuk untuk file October 2019 dan November 2019

**b. Soal 2. Menyeleksi kolom yang relevan untuk analisis product**

```csvcut -c 2,3,4,5,7,8,6 2019-Oct-Nov-sample.csv > 2019-Oct-Nov-Sample-Selected.csv```

Syntax tersebut menyeleksi kolom "event_time", "event_type", "product_id", "category_id", "brand", "price", dan "category_code"

**c. Soal 3. Melakukan filtering untuk mendapatkan aktivitas pembelian saja**

```csvgrep -c "event_type" -m "purchase" 2019-Oct-Nov-Sample-Selected.csv > 2019-Oct-Nov-Sample-Selected-purchase.csv```

Syntax tersebut melakukan filter pada kolom "event__type" dengan data "purchase"

**d. Soal 4. Melakukan splitting data kategori produk dan nama product pada category code**

Terdapat beberapa step yaitu,

- Membuat kolom baru yaitu kolom category menggunakan seleksi coloumn csvcut

```csvjoin 2019-Oct-Nov-Sample-Selected-purchase.csv category.csv > join_category.csv```

- Melakukan filtering terhadap category yang berada pada kolom category code, yaitu kata pertama sebelum titik dengan menggunkan awk

```cat category_code.csv | awk -F "." '{print $1}' > category.csv```

- Melakukan penggabungan kolom dengan file utama menggunakan csvjoin

```csvjoin 2019-Oct-Nov-Sample-Selected-purchase.csv category.csv > join_category.csv```

- Melakukan filtering terhadap product_name yang berada pada kolom category code, yaitu kata terakhir setelah titik dengan menggunkan awk

```cat category_code.csv | awk -F "." '{print $NF}' > product_name.csv```

- Melakukan penggabungan kolom dengan file utama menggunakan csvjoin

```csvjoin join_category.csv product_name.csv > data_joint.csv```

- Menyeleksi kolom terakhir untuk take out kololom category code

```csvcut -c 1,2,3,4,5,6,8,9 data_joint.csv > data_show.csv```

- Melakukan rename terhadap nama kolom

```sed -e '1s/category_code2/category/' -e '1s/category_code2_2/product_name/' data_show.csv > data_clean.csv```

- Melakukan pengecekan terhadap baris (cek kesesuaian)

```cat data_clean.csv | wc > check_baris.txt```

- Melakukan pengecekan terhadap agregasi category

```cat data_clean.csv | grep electronics | grep smartphone| awk -F ',' '{print $5}'| sort | uniq -c | sort -nr > check_category.txt```

- Cetak output sesuai dengan soal dengan ```cat data_clean.csv | head -10 | csvlook```

- Memasukkan syntax syntax tersebut kedalam vim execute.sh didalam bash scripting

**3. Cara Running / Penggunaan Program**

Cara penggunaan program adalah sebagai berikut:

a. Pastikan file execute.sh berada didalam 1 folder dengan 2019-Oct-sample.csv dan 2019-Nov-sample.csv

b. Pastikan 2019-Oct-sample.csv dan 2019-Nov-sample.csv sudah terdownload

c. Ubah otoritasi User agar dapat melakukan eksekusi execute.sh

```chmod u+x execute.sh```

d. Jalankan file execute.sh dengan bash

```bash execute.sh```

e. Akan muncul file-file csv, file yang sesuai dengan output terakhir adalah data_clean.csv

f. Pengecekan terhadap word counting dan agregasi kategori item dapat dilihat pada file check_baris.txt dan check_category.txt

**4. Saran Perbaikan**

Saran perbaikan untuk program ini adalah penghapusan terhadap file file pendukung yang bersifat transitory dan hanya menyisakan file data_clean.csv dan check_baris.txt dan check_category.txt

**Note Tambahan**

Dilakukan gitignore pada seluruh file csv kecuali file data_clean.csv, check_baris.txt, dan check_category.txt dikarenakan keterbatasan pada GitHub untuk memasukkan file yang sangat besar

```2019-Nov-sample.csv
2019-Oct-Nov-Sample-Selected-purchase.csv
2019-Oct-Nov-Sample-Selected.csv
2019-Oct-Nov-sample.csv
2019-Oct-sample.csv
category.csv
category_code.csv
check_category.txt
data_joint.csv
data_show.csv
join_category.csv
product_name.csv```
