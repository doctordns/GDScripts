# Get-GDFolderExtensions

#  This script gets the extensions for each folder in the GD shows Folder.
#  Some folders are gadly named and need updating

$GDFolder = 'm:\GD'
$files = gci $GDFolder -Directory
$fht = @{}

foreach ($file in $files) {
    $fn = $file.fullname.split('.')[-1]
    $FHT.$fn++
}

# Display
"Folder extensions in $GDFolder"
$fht.GetEnumerator() | sort value