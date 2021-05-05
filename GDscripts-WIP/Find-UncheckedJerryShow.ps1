#
# Find un-checked folder in GD collection
# Run it once at a time to find and open the next folder
# 
#

'Looking for next folder missing checksum cheked'
# Constancts
$DeadShowBase   = 'M:\GD'
$JerryShowBase  = 'N:\Jerry Garcia'
$ckfilename     = 'md5check_ok'
    


$JerryShows= ls $JerryShowBase | where {$_.psiscontainer -and $_.name -match 'JG_'}
# now get shows in each of these
$Dir = @()
Foreach ($show in $Jerryshows) {
$Dir += ls $show.fullname | where psiscontainer
}



$N=0 
Foreach ($show in $dir) {
If ($show.fullname -notmatch 'broken') {
    $sdir     = $show.fullName  # full source dir of this show
    $ckokfil  = Join-path $sdir $ckfilename         # The md5checkup_ok file in this folder
#
    if (ls $ckokfil -ea 0) 
      {
        # "Checksum exists in $sdir"   # gets verbose after a while...
       $N++
      } 
    
    else
      {
       "(AFTER $N,Let's look at $sdir"
       Explorer $sdir
       Break

      }
}

} # Iterate through every show till we find one!