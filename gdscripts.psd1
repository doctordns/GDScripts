#
# Module manifest for module 'gdscripts'
# 
# This is the manifest for Thomas Lee's Grateful Dead module.
#
#  The module provides numerous functions to help you to manage a Grateful Dead / Jerry Garcia live show archive.

# Version 1.0.4
# Aug 30 2021 - minor tidy up of scripts.

# Version 1.0.3
# Aug 28 2021 updated funciton names, cleanup code as a result.

# Version 1.0.2
# Aug 25 2021 
# Created initial manifest for this module

# Version 1.1.0
# April 20, 2022
# Updated module to use .PSMI and Dot Source all the functions


# Define this module
@{

# Script module or binary module file associated with this manifest.
RootModule = 'gdscripts.psm1'

# Version number of this module.
ModuleVersion = '1.1.0'

# ID used to uniquely identify this module
GUID = 'ed153420-cadc-4630-b14a-693af2b00942'

# Author of this module
Author = 'Thomas Lee, DoctorDNS@Gmail.Com'

# Company or vendor of this module
CompanyName = 'PS Partnership'

# Copyright statement for this module
Copyright = '(c) PSP 2021. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Contains functions to assist with curation of a GratefulDead/Jerry Garcia live show archive'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = '*'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

}

