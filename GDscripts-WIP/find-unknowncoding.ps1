# Finding unknown coding
# Some constants:
#   $DeadShowBase      - folder at top of gd shows
#   $JerryShowBase     - folder at top of jerry shows

$GDDiskRoot = "M:"
$JerryDiskRoot = "N:"


$DeadShowBase   = $GDDiskRoot + "\gd"
$JerryShowBase  = $JerryDiskRoot + "\Jerry Garcia"

# Announce Ourselves
"Find Unknown Coding For Dead Shows"
"---------------------------------"
"Dead Show Base  :  $DeadShowBase"
"Jerry Show Base :  $JerryShowBase"
"---------------------------------"
""
#  First get all the Dead shows
$Dir= Get-ChildItem $DeadShowBase  | where {$_.PsIsContainer}
$DeadShows=$Dir.count

# now find those with no shn/flac in title
$dir | where {!($_.name -match ".shn" -or $_.name -match ".flac")}