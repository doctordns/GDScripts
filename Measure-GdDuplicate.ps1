function Measure-GdDuplicate {
<#
.SYNOPSIS
    Finds duplicates in the GD archive
.DESCRIPTION
    This script looks through the GD shows and summaries any duplicates.
    I use a hash table $Shows to hold unique Events/shows/etc for which a recording could exist,.
    Each hash table entry's key is the date of the show while the value is a count of how many recordings for that event.
    The length of the hash table is thus the number of unique events, thus the rest of the shows are therefore duplicates.
    Updated: 10 Apr 2019 - rename to use a proper verb, updated the documentation and did some updates to the code.
                         - Added a count of miller transfers too.
    Updated 29 Dec 2020  - updated header and fixed example                        
    Updated 30 Aug 2021  - updated the help text, turned script into a function to be included ihn the GDScripts module.
.NOTES
    File Name  : Measure-GDDuplicate.ps1
	Author     : Thomas Lee - tfl@psp.co.uk
.LINK
    https://github.com/doctordns/GDScripts
.EXAMPLE
    Measure-GdDuplicate.ps1
    +-------------------------------------+
    !  Measure-GdDuplicate.ps1 - v 2.0.4  !
    !   Find Duplicate Shows in: M:\gd    !
    +-------------------------------------+

2812 total GD show recordings
1741 unique GD concerts
782 shows have duplicates
1071 shows are duplicates of others
5.4655384 Seconds elapsed
    
#>

###
# Start of Script
###

# Constants:
# $GDDiskRoot    - Disk where shows are stored
# $DeadShowBase  - Path to the folder containing all the GD shows

$GDDiskRoot   = "M:"
$DeadShowBase = $GDDiskRoot + '\gd'

# Display Header
"+-------------------------------------+"
"!  Measure-GdDuplicate.ps1 - v 2.0.4  !"
"!  Find Duplicate Shows in: $DeadShowBase     !"
"+-------------------------------------+"
""
# Get start time
$StartTime = Get-Date

# Get the Dead shows
$Dir       = Get-ChildItem $DeadShowBase -Directory
$DeadShows = $Dir.Count
if ($DeadSHows -le 0) { "No shows found - check the constants"; return }

# Look for duplicates
$Shows = @{ }  # Create the hash table
$j = 0         # create an initial count

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

# Finish
$FinishTime = Get-Date
$ES = ($FinishTime - $StartTime).TotalSeconds
"$ES Seconds elapsed"
} # End of Function