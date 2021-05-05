# Find-BadDateValue.ps1
# Version 1.0
# Author Thomas Lee - DoctorDNS@Gmail.Com

Write-Host 'Find-BadDateValue.ps1'
Write-Host 'Version 1.0'

# Finds badly encoded dates at the start of the file names
#
# Format should be: gdYY-MM-DD 
Set-Location M:\gd
$Badshows = Get-ChildItem | 
              Where-Object name -notmatch '^(gd\d{2}-(\d{2}|xx)-\d{2})' 
Write-Host "[$($BadShows.count)] Shows with badly formatted starts"
$BadShows