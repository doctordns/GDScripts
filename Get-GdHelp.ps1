Function Get-GDHelp {

[CmdletBinding()]
Param()


# Define Version number of this function

$Version = [version]::new(1,0,2)

# Create the help text block.

# Define the Help text
$HelpText = @"

+------------------------------------------------------------+
!                                                            !
!            GDScripts - A Grateful Dead Module              !
!                   Version: $($Version.ToString())                           !
!                                                            !
+------------------------------------------------------------+

The module contains the following functions:
* Get-GDHelp  - Gets this help text
* Get-GDFolderExtension  - gets all the extensions for shows in GD archive
* Get-GDShowSizeByYear   - creates a summary of total shows by year
* Get-GDTodayInHistory   - gets all the shows from today in GD/Jerry history, optionally opening them in Windows Explorer 
* Measure-GDDuplicate    - works out how many shows have duplcate recordings
* Measure-GDShows        - creates a useful summary of what is in the GD/JG archive
"@

# Display the help text
$HelpText

}