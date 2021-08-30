Function Get-GDShowEncoding {
<#
.Synopsis
   Gets the encoding extension from all Dead Shows and displays them
.DESCRIPTION
   The script gets the directories, and using a Hash Table gets a count
   of the use of each extension in all the folders. This script helps
   me to ensure that the final extension in every GD show meets my
   current naming convention.

.NOTES
   Function Name    : Get-GDShowEncoding
.LINK
   None yet
.EXAMPLE
   Psh> .Get-GDShowEncoding
   Name                           Value                                                                              
   ----                           -----                                                                              
   shnf                           1021                                                                               
   flacf                          53                                                                                 
   shnf_shn                       56                                                                                 
   ...
#>

# Define the base folder
$DeadShowBase = 'M:\GD'
# $JerryShowBase = 'N:\Jerry Garcia'

# Announce Ourselves
'Get-GDShowEncoding.Ps1 - v 4.0'
'+-------------------------------------+'
"! Counting the GD folder extensions   !"
"! Dead Show Base  :  $DeadShowBase            !"
#"! Jerry Show Base :  $JerryShowBase  !"
'+-------------------------------------+'

# Get the folders
$Dirs = Get-ChildItem -path $DeadShowBase -Directory

# Create a hash table of extensions
$Ext = @{}

# Now iterate through each directory, get the extension, 
# then get the final token which should be the encoding.
Foreach ($Dir in $Dirs) {
  $X = $Dir.FullName.split('.')[-1]
  $Ext.$X++
}

# Display results
$ext.GetEnumerator() | Sort-Object -Property Value -Descending
'{0} different encodings' -f $ext.count

} # end of function

# to do:
# Add JGB shows to this set