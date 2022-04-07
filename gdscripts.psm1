# GD Scripts Module

# Say Hello
Write-Verbose "Loadng GDScripts Module"

# Dot source the files

. $PSScriptRoot\Get-GDShowEncoding.ps1
. $PSScriptRoot\Get-GDFolderExtension.ps1
. $PSScriptRoot\Get-GDHelp.ps1
. $PSScriptRoot\Get-GDShowSizeByYear.ps1
. $PSScriptRoot\Get-GDTodayInHistory.ps1
. $PSScriptRoot\Measure-GDDuplicate.ps1
. $PSScriptRoot\Measure-GDShows.ps1

Write-Verbose "Loaded 7 functiosn for the GDScripts Module"

# all done