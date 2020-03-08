# 作成日時を変更
# 2020/3/8 yo16

$FileName = "sample.xlsx"
Set-ItemProperty $FileName -Name CreationTime -Value "1999/9/9 09:09:09"

# 更新日時を変更
Set-ItemProperty $FileName -Name LastWriteTime -Value "2001/2/3 04:05:06"

pause
