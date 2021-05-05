<#
.SYNOPSIS
    Plays a show/tune in Winamp
.DESCRIPTION
    Function is passed a $path saying what to play:
    [string]   - use LS and get the results and play them.
    [dirinfo]  - get name and call as string
    [fileinfo] - add file
.NOTES
    File Name  : Start-ShowInWinamp.ps1
    Author     : Thomas Lee - tfl@psp.co.uk
    Requires   : PowerShell Version 2.0
.LINK
    This script posted to:
        http://www.pshscripts.blogspot.com
.EXAMPLE
    Psh>        

#>


function Start-ShowInWinamp {
param(
$path = "M:\gd\gd71-08-14.21268.sbd.ladner.sbeok.t-flac16"
)

# Define where Winamp is located
$winamp = 'C:\Program Files (x86)\Winamp\winamp.exe'

# If string passed, parse it to file/folder
# Add the files found and add to winamp
If ($path -is [string]) {

# does $path exist?
  If (! (Test-Path $path)) {
  "*** path ($path) does not exist"
  return
  } 

  $files = LS $path | where {$_.extension -match "flac" -or $_.extension -match "shn" }
  "{0} files to play" -f $files.count
  $files | Sort name |  foreach {
     "adding $($_.name)"
     & $winamp /add $_.fullname
     start-sleep -Milliseconds 250
     return
  } 
  # end of foreach

} # endif $path is a string

# If io.fileinfo object is, parse it to file/folder
# Add the files found and add to winamp

If ($path -is [System.IO.FileInfo]) {
     & $winamp /add $Path.fullname
 }  # endif $path is fileinfo object

If ($path -is [System.IO.DirectoryInfo]) {
     & $winamp /add $Path.fullname
 }  # endif $path is fileinfo object


} # end of function

# Start-ShowInWinamp
Set-ALias SS start-ShowInWinamp