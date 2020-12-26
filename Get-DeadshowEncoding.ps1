<#
.Synopsis
   Gets the encoding extension from all Dead Shows and displays them
.DESCRIPTION
   The script gets the directories, and using a Hash Table gets a count
   of the use of each extension in all the folders. This script helps
   me to ensure that the final extension in every GD show meets my
   current naming convention.

.NOTES
   File Name    : Get-DeadShowEncoding.ps1
.LINK
   This script posted to: http://pshscripts.blogspot.com
.EXAMPLE
   Psh> .\Get0DeadShowEncoding.ps1
   Name                           Value                                                                              
   ----                           -----                                                                              
   shnf                           1021                                                                               
   flacf                          53                                                                                 
   shnf_shn                       56                                                                                 
#>

Set-Location M:\gd
$Dirs=Get-ChildItem -Directory

$ext = @{}

Foreach ($dir in $dirs) {
$x = $dir.FullName.split('.')[-1]
$ext.$x++
}

# Display results
$ext.GetEnumerator() | sort value -desc
'{0} different encodings' -f $ext.count