# フォルダ内の全ファイルを操作する
# 2020/3/8 yo16

$targetDir = '../';

$itemList = Get-ChildItem $targetDir;
foreach($item in $itemList)
{
	if($item.PSIsContainer){
		# フォルダ
		Write-Host ($item.Name + ' is folder!');
	} else {
		# ファイル
		Write-Host ($item.Name + ' is file!');
	}
}

pause;
