# Get-GDFolderExtension.ps1

#  This function gets the extensions for each folder in the GD shows Folder.
#  Some folders are badly named and need updating

function Get-GDFolderExtension {
    
[CmdletBinding()]
Param ()

# Define the base folders
$GDFolder = 'M:\GD'

# Get all the GD shows (one per folder below $GDFolder)
$Files    = Get-ChildItem -Path $GDFolder -Directory

# Create an empty hash table to hold show dates
$FHT      = @{}

# Iterate the snows, get the show date, then increment
# the count of shows for that date
foreach ($File in $Files) {
  $Fn = $File.Fullname.split('.')[-1]
  $FHT.$Fn++
}

# Display the results
"   Folder extensions in [$GDFolder]"
"   Total shows          [$($Files.Count)]"
$FHT.GetEnumerator() | 
  Sort-Object -Property Value -Descending

} # End of the function