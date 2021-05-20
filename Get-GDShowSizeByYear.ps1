# Get-GDShowSizeByYear
<#
.SYNOPSIS
    Reports GD Archive size by year

.DESCRIPTION
    Gets the on-disk size of all the shows in the GD Archive,
    then reports those sizes by year

.INPUTS
    none

.OUTPUTS
    System.String

.NOTES
  1. This assumes all files in the archive ($GDBASE) are of the format:
          gdyy-mm-dd-...
     The regular expression in the middle of the script parses each show folder name to pull out
     the year from the show name (ie the folder name)     
  2. All folders in $GDBase are assumed to be in that format, but if the regex match fails, it means
     that for some reason, the script has found a badly named folder.      

.EXAMPLE
  Left as an exercises for the user
#>

Function Get-GDShowSizeByYear {

# Say Hello

"+---------------------------------+"
"!  Get-GDShowByYear.ps1 v 1.0.0   !"
"!   Report Show size by year      !"
"+---------------------------------+"
""

# Set and report base file location
$GDBase = 'M:\gd'
"GDBase: [$GDBase]"

# Get GD folders from base
$Shows = Get-ChildItem -Path $GDBase -Directory

# Create Hash Table of size by year
$SBYHT = @{}

# Iterate
Foreach ($Show in $Shows) {
  $ShowName = $Show.Name
  $Check = $ShowName -Match '^gd([6-9][0-9])'
  if (-Not $Check) { 
    "$($Show.Name) is broken - continuing"
    continue
  }
  $Year = $Matches[1]  # get the year from the parsed regex
  $Size = (Get-ChildItem $Show -Rec | 
    Measure-Object -Sum -Property Length).Sum
  # Update year size
  $SBYHT[$Year] += $Size
}

# Now report
"Year         GB"
$SUM = 0
$SBYHT.GetEnumerator() | 
  Sort-Object -Property Name | 
    foreach-object {
      "{0,4:N2} {1,10:N2}" -f $_.Name,([int64]$_.value/1gb)
      $sum += ([int64]$_.value/1gb)
    } 
"Total is: {0,5:N3} GB" -f $sum
} # end of function