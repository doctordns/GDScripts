Function Get-TodayInHistory {
<#
.Synopsis
   Gets Grateful Dead and JBG shows from today's day in history
.DESCRIPTION
   Searches my GD and JGB archives for any shows that took place on today's date.
   Optionally, the function can open Explorer windows to all of the shows for you to click and play,
.EXAMPLE
PSH [C:\Foo]: Get-TodayInHistory

    Get-TodayInHistory.Ps1 - v 1.0.2
+-------------------------------------+
!  Dead Show Base  : M:\GD            !
!  Jerry Show Base : N:\Jerry Garcia  !
+-------------------------------------+

 ****  Today in GD History
M:\gd\gd72-08-25.sbd.miller.92840.sbeok.flac16
M:\gd\gd72-08-25.sbd.partial.deibert.12751.sbefail.shnf
M:\gd\gd93-08-25.sbd.wiley.11812.sbeok.shnf

 *** Today in Jerry History
N:\Jerry Garcia\jg_1991_project\jg1991-08-25.jgdg.aud.darroch.87244.sbeok.flac16
N:\Jerry Garcia\jg_1991_project\jg1991-08-25.jgdg.matrix-reutelhuber.26573.sbeok.flac16
N:\Jerry Garcia\jg_1991_project\jg1991-08-25.jgdg.sbd.unknown.28843.sbeok.flac16
N:\Jerry Garcia\jg_1991_project\jg1991-08-25.jgdg.sbd.walker.4370.sbeok.shnf
.NOTES
   Like all the functions in this module, this function expects a specific folder strucure and coding structure for each show.
   JGB and GD shows are stored in different locations and have a slightly different format:

   Dead shows are formatted:
   gdyy-mm-dd.<tokens indicating sbd/aud,etree id, <codec> znc possily BROKEN
   gd71-01-21.131517.aud.miller.flac16     # an audience recording mastered by Charlie Miller
   gd72-03-18.sbd.shnf.BROKEN              # a show whose MD5's do not check out.

Jerry shows are under the base but organised by year so:
   \jg_1975_project\jg75-05-21.lom.138271.sbd.buffalo.flac16
#>
 
[CmdletBinding()]
Param (
  [Switch] $OpenExplorerFolders   # opens today's shows in explorer
)

#  

# 0. Define the base folder and constants
#   $DeadShowBase      - folder at top of gd shows
#   $JerryShowBase     - folder at top of jerry shows
$DeadShowBase  = 'M:\GD'      
$JerryShowBase = 'N:\Jerry Garcia'
# the default output
$NS = "No Shows From today ($(Get-Date -Format MM-dd)" 
# define the function version
$VER = [version]::new(1,0,2) 
# 1. Define some internal functions
function f  {param ($d) Get-ChildItem -path gd:\* | Where-Object {$_.name -match $d}}
function fj {Param ($d)
 $JerryShowBase  = "N:\Jerry Garcia"
 # Get high level set
 $Years = Get-ChildItem -Path $JerryShowBase | 
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
"    Get-TodayInHistory.Ps1 - v $($Ver.ToString())"
'+-------------------------------------+' 
"!  Dead Show Base  : $DeadShowBase            !"
"!  Jerry Show Base : $JerryShowBase  !"
'+-------------------------------------+'
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