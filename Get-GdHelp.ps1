Function Get-GDHelp {

[CmdletBinding()]
Param()

# Create the help text block.

# For now, at least, I update this file manually when things change.
# Each change involves a bump in the version of the function and the module.


# Define the Help text
$HelpText = @'

+------------------------------------------------------------+
!                                                            !
!            Thomas's Grateful Dead Module                   !
!                   Version: 1.0.1                           !
!                  Date: 20 May 2021                         !
!                                                            !
+------------------------------------------------------------+

The module contains the following functions:
* Get-GDHelp  - Gets this help text
* Get-GDFolderExtensions - gets all the extensions for shows in GD archive
* Get-GDShowSizeByYear   - creates a summary of total shows by year
* Get-TodayInHistory     - gets all the shows from today in GD/Jerry history, optionally opening them in Windows Explorer 
* Measure-GdDuplicate    - works out how many shows have duplcate recordings
* Measure-GDShows        - creates a useful summary of what is in the GD/JG archive
'@

# Display the help text
$HelpText

}