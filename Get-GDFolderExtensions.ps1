# Get-GDFolderExtensions

#  This script gets the extensions for each folder in the GD shows Folder.
#  Some folders are badly named and need updating

function Get-GDFolderExtensions {
    
[CmdletBinding()]
Param ()

# define the base folders
$GDFolder = 'M:\GD'
$Files    = Get-ChildItem -Path $GDFolder -Directory
$FHT      = @{}

# Count the duplicates
foreach ($File in $Files) {
  $Fn = $File.Fullname.split('.')[-1]
  $FHT.$Fn++
}

# Display the results
"Folder extensions in $GDFolder"
$FHT.GetEnumerator() | 
  Sort-Object -Property Value

} # End of the function