# 写真のExif情報(撮影日)を編集する
# 2020/3/8 yo16

$photoPath = 'DSC00672.JPG';
$p_addHour = 24;

$curDirPath = Convert-Path .;
$photoPath = $curDirPath + '\' + $photoPath;
#echo $photoPath

Add-Type -AssemblyName System.Drawing
$img = New-Object Drawing.Bitmap($photoPath);
#for($i=0; $i -lt $img.PropertyItems.Length; $i++ ){
	#$prop = $img.PropertyItems[$i];
foreach($prop in $img.PropertyItems){
	if($prop.Id -eq 36867){	# 撮影日時
		# 文字列がバイトで入ってるので変換
		$byteArray = $prop.Value;
		#echo $byteArray;
		$strDt = [System.Text.Encoding]::ASCII.GetString($prop.Value);
		$strDt = $strDt.Substring(0,19)
		Write-Host( "["+$strDt+"]");
		
		# 日付型へ変換
		$dtOld = [DateTime]::ParseExact($strDt, "yyyy:MM:dd HH:mm:ss", $null);
		#Write-host($dtOld);
		
		# 時間を足し算
		$dtNew = $dtOld.AddHours($p_addHour);
		Write-host($dtNew);
		
		# 文字列に変換
		$strDtNew = $dtNew.ToString("yyyy:MM:dd HH:mm:ss");
		Write-host($strDtNew);
		# バイト列に変換
		$byteDtNew = [system.text.encoding]::ASCII.GetBytes($strDtNew)
		
		# プロパティを変更
		$prop.Value = $byteDtNew;
		$img.SetPropertyItem($prop);
	}
}

# 保存
$tmpPath = $photoPath + ".tmp.jpg"
$img.Save($tmpPath, [System.Drawing.Imaging.ImageFormat]::Jpeg);
$img.Dispose();
$img = $null;

# オリジナルとテンポラリファイルを入れ替え
del $photoPath
ren $tmpPath $photoPath
