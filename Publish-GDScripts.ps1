# Publish-GDScripts.ps1
# Run this after updating the manifest

### Define locations
# Module Name
$Name = 'GDScripts' 
# API Key

$APIKey = Get-Content C:\FOO\GDScripts-APIKey.txt

# Define where I have hidden the Module
$Path = "C:\Foo\GDScripts" 

### Publish the latest module.
Publish-module -path "C:\foo\GDScripts" -NuGetApiKey $APIKey

# to do
Should update the version number in the manifest before publishing.