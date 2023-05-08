#!/bin/bash

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
