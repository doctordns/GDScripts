# Measure-GDShows.ps1
# Count the Grateful Dead and Jerry Shows in my archive

[CmdletBinding()]
Param (
  [Switch] $MeasureDuplicates
)

# Define Constants:
#   $DeadShowBase      - folder at top of gd shows
#   $JerryShowBase     - folder at top of jerry shows
#  
#  Dead shows are formatted:
#  gdyy-mm-dd.<tokens indicating sbd/aud,etree id, <codec> znc possily BROKEN
#  EG
#  gd71-01-21.aud.miller.131517.flac16
#  gd72-03-18.sbd.shnf.BROKEN      # a show whose MD5's do not check out.
#
#  Jerry shows are under the base but organised by year so:
#  jg_1975_project\jg75-05-21.lom.138271.sbd.buffalo.flac16

# Here are the base folders
$DeadShowBase = 'M:\GD'      
$JerryShowBase = 'N:\Jerry Garcia'

# Announce Ourselves
'Measure-GDShows.Ps1 - v 3.0.2'
'Count My Dead\Jerry Shows'
'+-----------------------------------+' 
"!Dead Show Base  :  $DeadShowBase           !"
"!Jerry Show Base :  $JerryShowBase !"
'+-----------------------------------+'
''
''
# Get start time
$StartTime = Get-Date

# Count the Dead shows

$Dir = Get-ChildItem -Path $DeadShowBase -Directory
$DeadShows = $Dir.Count
if ($DeadSHows -le 0) { "No shows found - Check Constants" }

# Create subsets based on names of the folders
$deadsbds = $dir | Where-Object name -match '.sbd'
$deadbrkn = $dir | Where-Object name -match 'broken'
$deadpart = $dir | Where-Object name -match 'partial'
$deadauds = $dir | Where-Object name -match '.aud'
$deadunkw = $dir | Where-Object name -Match '.unk'
$deadshn  = $dir | Where-Object name -Match '.shn'
$deadflac = $dir | Where-Object name -Match '.flac'
$millerShows = $dir | Where-Object name -like "*.miller.*"
$deadunknown = $dir | Where-Object { $_.name -notmatch 'flac' -and $_.name -notmatch '.shn' }

# Check folder naming for inclusion of showid
$showidok = ($dir | Where-Object { $_.name -match '\.\d{2,6}\.' }).Count
$showidbad = ($dir | Where-Object { $_.name -notmatch '\.\d{2,6}\.' }).Count

# And see how many have the md5ok's and how many 
# are speciried at ETree?
$DeadMD5Checked = 0
$DeadShowInEtree = 0
foreach ($d in $dir) { 
  # Check on MD5Check has been done
  $fn = $d.fullname + '\md5check_ok'
  $md5ok = Get-ChildItem $fn -ea silentlycontinue
  if ($md5ok) 
  { $DeadMD5Checked++ }

  # Now check on Etree
  $sn = $d.fullname + '\EtreeDBSource'
  $EtreeOK = Get-ChildItem $sn -ea silentlycontinue
  if ($EtreeOK ) 
  { $DeadShowInEtree++ }
}

# Display results

'Grateful Dead Show Summary'
'--------------------------'
"Total shows          : $deadshows"
"Soundboards          : $($deadsbds.count)"
"Auds                 : $($deadauds.count)"
"Unknown              : $($deadunkw.count)"
"Partial              : $($deadpart.count)"
"Broken               : $($deadbrkn.count)"
"Flac                 : $($deadflac.count)"
"Shn                  : $($deadshn.count)"
"Charlie Miller shows : $($millershows.count)"
# Shows not shn or flac in folder/show name
'Unknown Codec        : {0}' -f $deadunkown.count
$DeadPctChecked = ($DeadMD5checked / $DeadShows).tostring('P')
"Show ID in show name : $ShowidOK"
"Show ID missing      : $Showidbad"
"MD5's check          : $DeadMD5checked ($DeadPctChecked)"
$DeadShowsInEtreePct = ($DeadShowInEtree / $Deadshows).tostring('p')
"Shows in Etree       : $DeadShowInEtree ($DeadShowsInEtreePct)"
''

# if duplicate counting requested - run measure-gdduplicates

If ($MeasureDuplicates) {
  .\Measure-GdDuplicate.ps1
  ""
}

#
# Next count the Jerry shows
#

# Get high level set
$Shows = Get-ChildItem $JerryShowBase | Where-Object { $_.psiscontainer -and $_.name -match 'JG_' }
# now get shows in each of these
$dir = @()
Foreach ($show in $shows) {
  $dir += Get-ChildItem $show.fullname | Where-Object psiscontainer
}

$JerryShows = $dir.count

#what's what from the file names of the folders
$Jerrysbds = $dir | Where-Object { $_.name -match '.sbd' }
$Jerrybrkn = $dir | Where-Object { $_.name -match 'broken' }
$Jerrypart = $dir | Where-Object { $_.name -match 'partial' }
$Jerryauds = $dir | Where-Object { $_.name -match '.aud' }
$Jerryunkw = $dir | Where-Object { $_.name -Match '.unk' }

#and see how many have the md5ok's file?

$JerryMD5Checked = 0
$JerryInEtree = 0
foreach ($d in $dir) { 
  # Check if md5 has been checekd?
  $sn = $d.fullname + '\md5check_ok'
  $md5ok = Get-ChildItem $sn -ea silentlycontinue
  if ($md5ok ) { $JerryMD5Checked++ }

  # Check to see if it's catalogued at Etree
  $sn = $d.fullname + '\EtreeDBSource'
  $ShowOK = Get-ChildItem $sn -ea SilentlyContinue
  if ($showOK) { $JerryInEtree++ }
}

# Display Jerry results

'JERRY GARCIA SHOW SUMMARY'
'-------------------------'
"Total shows:   :  $JerryShows"
"Soundboards    :  $($Jerrysbds.count)"
"Auds           :  $($Jerryauds.count)"
"Unknown        :  $($Jerryunkw.count)"
"Partial        :  $($Jerrypart.count)"
"Broken         :  $($Jerrybrkn.count)"
$PctChecked = ($JerryMD5Checked / $jerryshows).tostring('P')
"MD5's check    :  $JerryMD5Checked ($PctChecked)"
$JerryShowsInEtreePct = ($JerryinEtree / $JerryShows).tostring('p')
"Shows in Etree :  $JerryinEtree ($JerryShowsInEtreePCT)"
''

# Display Summary
'SUMMARY'
'-------'

$totalshows = $DeadShows + $JerryShows
$checked = ($Jerrymd5checked + $DeadMD5Checked)
$pctchecked = ($Jerrymd5checked + $DeadMD5Checked) / $totalshows
$pcs = $pctchecked.tostring('P2')

$inetree = ($JerryInEtree + $DeadShowInEtree)
$inetreepcs = ($JerryInEtree + $DeadShowInEtree) / $totalshows
$etreepcs = $inetreepcs.tostring('P2')

"Total Shows : $totalshows"
"MD5s OK     : $checked ($pcs)"
"In Etree db : $inetree ($etreepcs)"
$totalsbds = $Jerrysbds.count + $deadsbds.count
"Total Sbds  : $totalsbds"
$totalauds = $Jerryauds.count + $deadauds.count
"Total Auds  : $totalauds"

# The End