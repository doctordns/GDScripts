Function Get-DeadShowEncoding {
<#
.Synopsis
   Gets the encoding extension from all Dead Shows and displays them
.DESCRIPTION
   The script gets the directories, and using a Hash Table gets a count
   of the use of each extension in all the folders. This script helps
   me to ensure that the final extension in every GD show meets my
   current naming convention.

.NOTES
   Function Name    : Get-DeadShowEncoding
.LINK
   None yet
.EXAMPLE
   Psh> .Get-DeadShowEncoding
   Name                           Value                                                                              
   ----                           -----                                                                              
   shnf                           1021                                                                               
   flacf                          53                                                                                 
   shnf_shn                       56                                                                                 
   ...
#>

# Define are the base folders
$DeadShowBase = 'M:\GD'
$JerryShowBase = 'N:\Jerry Garcia'

# Announce Ourselves
'Measure-GDShows.Ps1 - v 3.03'
'+-------------------------------------+'
"! Counting the GD folder extensions   !"
"! Dead Show Base  :  $DeadShowBase            !"
"! Jerry Show Base :  $JerryShowBase  !"
'+-------------------------------------+'

# Get the folders
$Dirs = Get-ChildItem -path $DeadShowBase -Directory

# Create a hash table of extensions
$Ext = @{}

# now iterate through each directory
Foreach ($Dir in $Dirs) {
  $X = $Dir.FullName.split('.')[-1]
  $Ext.$X++
}

# Display results
$ext.GetEnumerator() | Sort-Object -Property Value -Descending
'{0} different encodings' -f $ext.count

} # end of function