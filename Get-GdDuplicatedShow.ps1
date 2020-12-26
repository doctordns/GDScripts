<#
.SYNOPSIS
    Finds duplicates in the GD archive
.DESCRIPTION

.NOTES
    File Name  : Get-GdDuplicatedShow.ps1
	Author     : Thomas Lee - tfl@psp.co.uk
	Requires   : PowerShell V2 CTP3
.LINK
    http://www.pshscripts.blogspot.com
.EXAMPLE
    
#>
###
# Start of Archive
##

# Constants:
# $GDDiskRoot    - where to find shows
# $DeadShowBase  - folder at top of gd shows

$GDDiskRoot = "M:"
$DeadShowBase = $GDDiskRoot + "\gd"

# Announce Ourselves
"DuplicateCount.ps1 - v 0.0.1"
"+---------------------------------+"
"! Find Duplicate Shows :  $DeadShowBase   !"
"+---------------------------------+"
""
# Get start time
$starttime = Get-Date

# Get the Dead shows

$Dir = ls $DeadShowBase | where {$_.psiscontainer}
$DeadShows = $Dir.count
if ($DeadSHows -le 0) {"no shows found - check constants"; return}

# So here look for duplicates.

$shows =@{}

$j = 0
foreach ($show in $dir){
$j++
$showdate = $show.name.substring(0,10)

if ($shows.$showdate) {
  $shows.$showdate++ 
   }  
else {
  $shows += @{$showdate=1}
  }

}


$totaldups = 0
$totaldupshows = 0
foreach ($show in $shows.GetEnumerator()){

If ($show.value -gt 1) {
"{1} copies of: {0}" -f	$show.name, $show.value
$totaldups++	
$totaldupshows += $show.value - 1 # anything after the 1st is a dup
}
}
"{0} Total shows in library" -f $DeadShows
"{0} shows have duplicate recordings" -f $totaldups
"{0} shows are duplicates of others" -f $totaldupshows
"{0} Unique Shows in libary"  -f ($deadshows - $totaldupshows)
