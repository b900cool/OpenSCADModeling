$modulePath = Join-Path$PSScriptRoot '\GithubLibraries.psd1'
Import-Module -Name $modulePath

Save-GitHubRepository -Owner rcolyer -Project threads-scad
Save-GitHubRepository -Owner Obijuan -Project obiscad
Save-GitHubRepository -Owner revarbat -Project BOSL
Save-GitHubReleaseTar -Owner boltsparts -Project BOLTS_archive -ArtifactName boltsos_0.4.1.tar.gz
