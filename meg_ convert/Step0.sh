#!/bin/bash

rm -rf Temp/*
cp -R BusinessToday/ Temp/
cp -R BusinessWeekly/ Temp/
rm -rf BusinessToday
rm -rf BusinessWeekly


source_folder='./Temp/'  # 原始檔案所在的資料夾路徑
dest_root_folder='./TempOK/'  # 目的地資料夾的根目錄路徑

# 如果目的地根目錄不存在，就建立它
if [ ! -d "$dest_root_folder" ]; then
    mkdir "$dest_root_folder"
fi

# 搜尋來源資料夾內的所有子資料夾
find "$source_folder" -type d | while read dir; do
    # 組成目的地子資料夾路徑
    dest_folder="$dest_root_folder$(basename "$dir")/"
    # 如果目的地子資料夾不存在，就建立它
    if [ ! -d "$dest_folder" ]; then
        mkdir "$dest_folder"
    fi
    # 取得來源子資料夾內所有副檔名為 jpg 且檔名符合特定格式的檔案列表
    file_list="$(find "$dir" -maxdepth 1 -type f -name '*.jpg' | sort -r)"
    # 將每個子資料夾的檔案從1開始重新命名，並搬移到目的地子資料夾中
    i=1
    for old_name in $file_list; do
        new_name="$(printf '%03d.jpg' "$i")"
        mv "$old_name" "$dest_folder/$new_name"
        i=$((i+1))
    done
done



rm -rf Temp

find . -name "000_3.jpg" -type f -delete

find . -name "001.jpg" -type f -delete

find . -name "*.jpg" -exec sh -c 'sips -s format pdf "$0" --out "${0%.*}.pdf"' {} \;

find . -name "*.jpg" -type f -delete

# 遍歷每個資料夾
for dir in */ ; do
  # 去除路徑結尾的斜線以獲取資料夾名稱
  dirname=${dir%/}

  # 遍歷該資料夾中的每個子資料夾
  for subdir in "$dir"*/ ; do
    # 去除路徑結尾的斜線以獲取子資料夾名稱
    subdirname=${subdir%/*}
    subdirname=${subdirname##*/}

    # 將子資料夾中的所有 PDF 檔案合併成一個 PDF 檔案
    pdfunite "$subdir"*.pdf "$dir""$subdirname".pdf
    
    # 輸出訊息至終端機，表示合併過程已完成
    echo "已將 $subdir 中的 PDF 檔案合併至 $dir$subdirname.pdf"

    # 將合併完成的 PDF 檔案移至工作目錄
    mv "$dir""$subdirname".pdf .
    
    # 輸出訊息至終端機，表示移動過程已完成
    echo "已將 $dir$subdirname.pdf 移動至工作目錄"
  done
done

