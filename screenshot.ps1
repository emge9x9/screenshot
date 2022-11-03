###########################################################################
#                            Editierbereich - Anfang     
##########################################################################
#Bildschirmbereich in Pixel?                       
$size = [System.Drawing.Rectangle]::FromLTRB(0, 0, 1920, 1200)

#Speicherpfad?
$imgPath = "C:\Users\$env:USERNAME\Desktop\screenshots\"

#Dateiname?
$imgName = "Screenshot_{0:dd}{0:MM}_{0:HH}_{0:mm}_{0:ss}.bmp" -f (Get-Date)

# Soll die Bitmap angezeigt werden? - true/false
$open=$true

###########################################################################
#                       Editierbereich - Ende      
##########################################################################

cls
Add-Type -Assembly System.Drawing

function Get-Screenshot
{    
 param([System.Drawing.Rectangle]$Bereich,[Switch]$Show=$open)
  
 $img = New-Object System.Drawing.Bitmap $size.Width, $size.Height
 $graphics = [System.Drawing.graphics]::FromImage($img)

 $graphics.CopyFromScreen($size.Location, [System.Drawing.Point]::Empty,$size.Size)
 $img.Save($imgPath+$imgName)
 $graphics.Dispose()
 $img.Dispose()
 if ($Show)
 { Invoke-Item -Path ($imgPath+$imgName) }
}

Get-Screenshot -size $size
gci $imgPath