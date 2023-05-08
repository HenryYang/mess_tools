import os

source_folder = './Temp/'  # 原始檔案所在的資料夾路徑
dest_root_folder = './TempOK/'  # 目的地資料夾的根目錄路徑

# 如果目的地根目錄不存在，就建立它
if not os.path.exists(dest_root_folder):
    os.mkdir(dest_root_folder)

# 搜尋來源資料夾內的所有子資料夾
for root, dirs, files in os.walk(source_folder):
    for dir in dirs:
        # 組成目的地子資料夾路徑
        dest_folder = os.path.join(dest_root_folder, dir)
        # 如果目的地子資料夾不存在，就建立它
        if not os.path.exists(dest_folder):
            os.mkdir(dest_folder)
        # 取得來源子資料夾內所有副檔名為 jpg 且檔名符合特定格式的檔案列表
        file_list = sorted([f for f in os.listdir(os.path.join(root, dir)) if f.endswith('.jpg')], reverse=True)
        # 將每個子資料夾的檔案從1開始重新命名，並搬移到目的地子資料夾中
        for i, old_name in enumerate(file_list):
            new_name = '{:03d}.jpg'.format(i+1)
            os.rename(os.path.join(root, dir, old_name), os.path.join(dest_folder, new_name))

