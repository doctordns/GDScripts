<#
.SYNOPSIS
    Counts the Grateful Dead shows in my archives and displays
	details of the collection.
.DESCRIPTION
    This script looks at my GD archive, and uses folder names to
    determine show type (aud, sbd, etc), and checks to see what
    shows have checked MD5s. 
	
    This is an update to an earlier script that adds separate 
    counts for FLAC and SHN shows.
.NOTES
    File Name  : Measure-GDShows.ps1
	Author     : Thomas Lee - tfl@psp.co.uk
	Requires   : PowerShell V2
.EXAMPLE
    PS C:\foo> Measure-gdshows.ps1
    Count.ps1 - v 2.0.6
    +---------------------------+
    ! Dead Show Base  :  M:\gd  !
    +---------------------------+

    Grateful Dead Show Summary
    --------------------------
    Total shows:   1146
    Soundboards:   800
    Auds       :   70
    Unknown    :   29
    Partial    :   9
    SHN        :   962
    FLAC       :   137
    No coding  :   47
    Broken     :   4
    MD5's check:   489 (42.67 %)
    
#>
###
# Start of Archive
##

# Constants:
# $GDDiskRoot    - where to find shows
# $DeadShowBase  - folder at top of gd shows

$GDDiskRoot = "M:"
$DeadShowBase   = $GDDiskRoot + "\gd"

# Announce Ourselves
"Count.ps1 - v 2.0.6"
"+---------------------------+"
"! Dead Show Base  :  $DeadShowBase  !"
"+---------------------------+"
""
# Get start time
$starttime = Get-Date

# Count the Dead shows
# Get the list, but persist in global scope
If ($global:gddir) {"Using cached show directories";$dir = $global:gddir}
else {
   "Getting shows"
   $Dir= ls $DeadShowBase  | where {$_.psiscontainer}
   $global:gddir = $dir
}


$DeadShows=$Dir.count
if ($DeadSHows -le 0) {"no shows found - check constants"}

# Create subsets based on names of the folders
$deadsbds    = $dir | where {$_.name -match ".sbd" }
$deadbrkn    = $dir | where {$_.name -match "broken" }
$deadpart    = $dir | where {$_.name -match "partial" }
$deadauds    = $dir | where {$_.name -match ".aud" }
$deadunknown = $dir | where {$_.name -match ".unk"}
$deadprefm   = $dir | where {$_.name -match ".prefm"}
$deadCOM     = $dir | where {$_.name -match ".COMMERCIAL"}

# Persist broken stuff in global
$global:DeadBrkn  = $deadbrkn
$global:DeadPart  = $deadpart
$global:Unknown   = $deadunknown

# workout recording type
$deadshn    = $dir | where {$_.name -match ".shn"}
$deadflac   = $dir | where {$_.name -match ".flac"}
$global:deadnocoding = $dir | where {$_.name -notmatch ".shn" -and $_.name -notmatch ".flac"}

# and see how many have the md5ok's file?
$DeadMD5Checked=0
$nomd5 = @()

foreach ($d in $dir)
{ 
  $sn=$d.fullname + "\md5check_ok"
  $md5ok= ls $sn -ea silentlycontinue
  if   ($md5ok ) 
       {$DeadMD5Checked++}
  else {$nomd5 += $d}    
}


# Display results

"Grateful Dead Show Summary"
"--------------------------"
"Total shows:   $deadshows"
$DeadPctCOM  = ($deadCOM.count/$dir.count).tostring("P")
"Commerical :   $($DeadCOM.count) ($DeadPctCom)" 
$DeadPctSBds = ($deadsbds.count/$dir.count).tostring("P")
"Soundboards:   $($deadsbds.count) ($DeadPctSbds)"
$DeadPctAuds = ($deadauds.count/$dir.count).tostring("P")
"Auds       :   $($deadauds.count)  ( $deadPctAuds)"
$DeadPctPrefm=  ($deadprefm.count/$dir.count).ToString("P")
"PreFM      :   $($deadprefm.count)   ($deadpctprefm)" 
"Unknown    :   $($deadunknown.count)"
"Partial    :   $($deadpart.count)"
$DeadPctShns = $($deadshn.count/$dir.count).tostring("P")
"SHN        :   $($deadshn.count) ($DeadPctShns)"
$DeadPctFlac = $($deadflac.count/$dir.count).tostring("P")
"FLAC       :   $($deadflac.count)  ($DeadPctFlac)"
"No coding  :   $($deadnocoding.count)"
"Broken     :   $($deadbrkn.count)"
$DeadPctChecked=($DeadMD5checked/$DeadShows).tostring("P")
"MD5's check:   $DeadMD5checked  ($DeadPctChecked)"


# md5's missing - display first 10
"";"First 10 Missing MD5s"
$nomd5 | where {$_.name -notmatch "broken"}| select -first 10| foreach {$_.fullname} 

# Now get duplicates
& 'C:\foo\gd scripts\count-gdduplicate.ps1'

# Get finishtime and calc elapsed
$finishtime=Get-Date
$executiontime = $finishtime - $starttime
$min = $executiontime.minutes
$sec = $executiontime.seconds
"";
"It took {0} minutes, {1} second(s)" -f $min,$sec
""