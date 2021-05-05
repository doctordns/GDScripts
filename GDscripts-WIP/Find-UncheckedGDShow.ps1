#
# Find un-checked folder in GD collection
# Run it once at a time to find and open the next folder
# 
#

'Looking for next folder missing checksum cheked'
# Constancts
$DeadShowBase   = 'M:\GD'
$ckfilename     = 'md5check_ok'
    

$Dir= Get-ChildItem $DeadShowBase  | Where-Object Psiscontainer
$DeadShows=$Dir.count
$N=0 
Foreach ($show in $dir) {
$N++
If ($show.name -notmatch 'broken') {
    $sdir     = Join-Path $DeadShowBase $show.Name  # full source dir of this show
    $ckokfil  = Join-path $sdir $ckfilename         # The md5checkup_ok file in this folder
#
    if (ls $ckokfil -ea 0) 
      { }  # "Checksum exists in $sdir" which gets verbose after a while...
    else
      {
       "(AFTER $N,Let's look at $sdir"
       # let's get exciting       
       Explorer $sdir
       break
      }
}

} # Iterate through every show till we find one!