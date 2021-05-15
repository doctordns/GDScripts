function Measure-GdDuplicate {
<#
.SYNOPSIS
    Finds duplicates in the GD archive
.DESCRIPTION
    This script looks through the GD shows and summarise any duplicates.
    I use a hash table $Shows to hold unique Events/shows/etc for which a recording could exist
    The hashtable key is the date of the show.
    The hashtable value is a count of how many recordings for that event
    The length of the hash table is thus the number of unique events, thus the rest of the shows are therefore duplicates.
    Updated: 10 Apr 2019 - rename to use a proper verb, updated the documentation and did some updates to the code.
                         - Added a count of miller transfers too.
    Updated 29 Dec 2020  - updated header and fixed example                        

.NOTES
    File Name  : Measure-GDDuplicate.ps1
	Author     : Thomas Lee - tfl@psp.co.uk
.LINK
    http://www.pshscripts.blogspot.com
.EXAMPLE
    Measure-GdDuplicate.ps1
    +-------------------------------------+
    !  Measure-GdDuplicate.ps1 - v 2.0.3  !
    ! Find Duplicate Shows in: M:\gd      !
    +-------------------------------------+

2812 total GD show recordings
1741 unique GD concerts
782 shows have duplicates
1071 shows are duplicates of others
    
#>

###
# Start of Script
##

# Constants:
# $GDDiskRoot    - Disk where shows are stored
# $DeadShowBase  - Path to the folder containing all the GD shows

$GDDiskRoot   = "M:"
$DeadShowBase = $GDDiskRoot + '\gd'

# Display Header
"+-------------------------------------+"
"!  Measure-GdDuplicate.ps1 - v 2.0.3  !"
"!  Find Duplicate Shows in: $DeadShowBase     !"
"+-------------------------------------+"
""
# Get start time
$StartTime = Get-Date

# Get the Dead shows
$Dir       = Get-ChildItem $DeadShowBase | Where-Object { $_.psiscontainer }
$DeadShows = $Dir.count
if ($DeadSHows -le 0) { "No shows found - check the constants"; return }

# Look for duplicates
$Shows = @{ }  # Create the hash table
$j = 0         # create an intital count

# Loop through each show
foreach ($Show in $Dir) {
    $j++                                    # found another show
    $ShowDate = $Show.Name.Substring(2, 8)  # Gets the date out of the folder name

    if ($Shows.$ShowDate) {
        $Shows.$ShowDate++         # show exists, this one a dup
    }  
    else {
        $Shows += @{$ShowDate = 1 }   # new show, of which we have just 1 (so far!)
    }	

}

# Basic count done. now work out many shows are duplicates and how many total duplicates there are.
$Shows = $Shows.GetEnumerator() | 
  Sort-Object -Property Name                  # Ensure chronological order
$TotalDups     = 0
$TotalDupShows = 0

# Now loop through each show and calculate the duplicates
foreach ($Show in $Shows) {
    if ($Show.Value -gt 1) {
        # If > 1, we have multiple copies
        # "{1} copies of: {0}" -f	$show.name, $show.value  # don't print them just now!
        $TotalDups++	
        $TotalDupShows += $Show.Value - 1                   # anything after the 1st is a dup
    }
}

# Display summary
"{0} total GD show recordings" -f $Deadshows
"{0} unique GD concerts" -f $Shows.count
"{0} shows have duplicates" -f $Totaldups
"{0} shows are duplicates of others" -f $TotalDupShows
}