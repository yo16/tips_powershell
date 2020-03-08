# 指定したフォルダ内のファイル群の、更新日時を全部変える
# yo16

# ---- 設定 ----
# フォルダ
$targetFolder = 'test'

# サブフォルダも含める
$subFolder = $TRUE;

# 加える時間
$addHours = 24;


# ---- 処理 ----
# 指定したフォルダの更新日時に時間を加える
function addHour($p_folderPath, $p_processSubFolder, $p_addHour){
	$itemList = Get-ChildItem $p_folderPath;
	foreach($item in $itemList){
		$itemPath = $p_folderPath + '\' + $item.Name;
		if($item.PSIsContainer){
			# フォルダ
			if($p_ProcessSubFolder){
				addHour $itemPath $p_processSubFolder $p_addHour
			}
			
		} else {
			# ファイル
			
			# 現在の作成日時を取得
			$curCreateTime = $item.CreationTime;
			# 時間を加算
			$addedTime = $curCreateTime.AddHours($p_addHour);
			# ファイルの作成日時を変更
			Set-ItemProperty $itemPath -Name CreationTime -Value $addedTime;
			# ファイルの更新日時を変更
			Set-ItemProperty $itemPath -Name LastWriteTime -Value $addedTime;
			
			Write-Host $item.Name $addedTime;
		}
	}
}

addHour $targetFolder $subFolder $addHours

pause
