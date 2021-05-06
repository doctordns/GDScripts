# Get-TodayInHostory

#  Version 1.0 - 6 May 2021

[CmdletBinding()]
Param (
  [Switch] $OpenExplorerFolders
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
# # Here are the base folders
$DeadShowBase = 'M:\GD'      
$JerryShowBase = 'N:\Jerry Garcia'

# 1. Announce Ourselves
'Get-TodayInHistory.Ps1 - v 1.0.0'
'Finding Today In GD/Jerry History'
'+-----------------------------------+' 
"!Dead Show Base  :  $DeadShowBase           !"
"!Jerry Show Base :  $JerryShowBase !"
'+-----------------------------------+'
''
''

# 2. Find GD in history
$Today = Get-Date
$TM = $today.Month
if ($TM -le 9){$TM = "0$TM"}
$TD = $Today.Day
if ($TD -le 9){$TD = "0$TD"}
$TodaySearch = "$TM-$TD"
$TodayGD = F $TodaySearch
If(($TodayGD.count) -eq 0) {$TodayGD = "NO SHOWS FROM THIS DATE"}


# 3. Find Jerry in History
$TodayJerry = FJ $TodaySearch
If(($TodayJerry.count) -eq 0) {$TodayJerry = "NO SHOWS FROM THIS DATE"}


# 4. Results
' ****  Today in GD history'
If ($TodayGD -match '^NO SHOWS') {
  $TodayGD
}
Else {
  $TodayGD  | ForEach-Object {$_.Fullname}
}
''
' *** Today in Jerry History'
$TodayJerry


if ($TodayJerrry -match '^NO SHOWS') {
  $TodayJerry
}
Else {
  $TodayJerry  | ForEach-Object {$_.Fullname}
}
''

# 5. And open the explorer windows if asked
if ($OpenExplorerFolders) {
    $todayGD | ForEach-Object {explorer $_.fullname}
    $todayJerry | ForEach-Object {explorer $_.fullname}
}