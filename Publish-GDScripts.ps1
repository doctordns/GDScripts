# Publish-GDScripts.ps1
# Run this after updating the manifest

### Define locations
# Module Name
$Name = 'GDScripts' 
# API Key

$APIKey = Get-Content C:\FOO\GDScripts-APIKey.txt

# Define where I have hidden the Module
$Path = "C:\Foo\GDScripts" 

# Release Notes
$RelNotes = C:\foo\GDScripts\ReleaseNotes.MD

# License uri
$License = 'https://github.com/doctordns/GDScripts/blob/main/LICENSE'

### Publish the latest module.
$PublishHT = @{
  Path         = 'C:\foo\GDScripts' 
  NuGetApiKey  = $APIKey 
  ReleaseNotes = $RelNotes 
  LicenseUri   = $License
}
Publish-Module @PublishHT
# to do
# Should update the version number in the manifest before publishing.