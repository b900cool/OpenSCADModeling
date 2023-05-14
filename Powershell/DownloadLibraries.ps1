Import-Module -Name '.\GithubLibraries.psd1'

Save-GitHubRepository -Owner Obijuan -Project obiscad
Save-GitHubRepository -Owner revarbat -Project BOSL
Save-GitHubReleaseTar -Owner boltsparts -Project BOLTS_archive -ArtifactName boltsos_0.4.1.tar.gz
