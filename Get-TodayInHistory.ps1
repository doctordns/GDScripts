Function Get-TodayInHistory {

#  Version 1.0 - 6 May 2021

[CmdletBinding()]
Param (
  [Switch] $OpenExplorerFolders   # opens today's shows in explorer
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


# 0. Define the base folder and constants
$NS = "No Shows From today ($(Get-Date -Format MM-dd)" # the default output
$DeadShowBase  = 'M:\GD'      
$JerryShowBase = 'N:\Jerry Garcia'


# 1. Define some internal functions
function f  {param ($d) Get-ChildItem -path gd:\* | Where-Object {$_.name -match $d}}
function fj {Param ($d)
 $JerryShowBase  = "N:\Jerry Garcia"
 # Get high level set
 $Years = Get-ChildItem -Path s $JerryShowBase | 
   Where-Object {$_.psiscontainer -and $_.name -match "JG_"}
 # now get shows in each of these
 $dir = @()
 Foreach ($Year in $Years) {
   $dir += Get-ChildItem -Path $Year.fullname | where {$_.psiscontainer}
 }
 # Now get the ones we want
$dir | where-object name -match $d
}

# 1. Announce Ourselves
'Get-TodayInHistory.Ps1 - v 1.0.1'
'Finding Today In GD/Jerry History'
'+-----------------------------------+' 
"!Dead Show Base  :  $DeadShowBase           !"
"!Jerry Show Base :  $JerryShowBase !"
'+-----------------------------------+'
''
''

# 2. Find GD in history
$Today     = Get-Date
$TM        = $today.Month
if ($TM -le 9) {$TM = "0$TM"}
$TD          = $Today.Day
if ($TD -le 9){$TD = "0$TD"}
$TodaySearch = "$TM-$TD"
$TodayGD     = F $TodaySearch
If(($TodayGD.count) -eq 0) {$TodayGD = $NS}

# 3. Find Jerry in History
$TodayJerry = FJ $TodaySearch
If(($TodayJerry.count) -eq 0) {$TodayJerry = $NS}

# 4. Results
' ****  Today in GD History'
If ($TodayGD -eq $NS) {
  $TodayGD
}
Else {
  $TodayGD  | ForEach-Object {$_.Fullname}
}
''
' *** Today in Jerry History'
if ($TodayJerrry -eq $NS) {
  $TodayJerry
}
Else {
  $TodayJerry  | ForEach-Object {$_.Fullname}
}
''

# 5. And open the explorer windows if asked
if ($OpenExplorerFolders) {
  if (-not ($TodayGD -eq $ns)) {
      $TodayGD | 
        ForEach-Object {explorer $_.FullName}
  }
  if (-not ($TodayJerry -eq $NS)){ 
    ForEach-Object {explorer $_.FullName}
  }
}

} # End of the function