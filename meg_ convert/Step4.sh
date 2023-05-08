#!/bin/bash

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

