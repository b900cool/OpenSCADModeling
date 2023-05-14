<#
.SYNOPSIS
Downloads a GitHub repository and saves it to a specified location on the local machine.

.DESCRIPTION
The Save-GitHubRepository script takes three parameters: Owner, Project, and Branch. The Owner and Project parameters are mandatory and specify the owner and name of the GitHub repository to download. The Branch parameter is optional and specifies the branch of the repository to download. If not specified, it defaults to the master branch.

The script first defines the destination path for the downloaded repository and the name of the output zip file. It then uses curl.exe to download the specified branch of the repository from GitHub as a zip file. The script then unzips the downloaded file and moves its contents to the specified destination path. Finally, it performs some cleanup by removing the temporary files created during the process.

.PARAMETER Owner
Specifies the owner of the GitHub repository to download.

.PARAMETER Project
Specifies the name of the GitHub repository to download.

.PARAMETER Branch
Specifies the branch of the GitHub repository to download. Defaults to 'master' if not specified.

.EXAMPLE
Save-GitHubRepository -Owner 'octocat' -Project 'Hello-World'

Downloads the master branch of the 'Hello-World' repository owned by 'octocat' and saves it to the local machine.

.EXAMPLE
Save-GitHubRepository -Owner 'octocat' -Project 'Hello-World' -Branch 'develop'

Downloads the develop branch of the 'Hello-World' repository owned by 'octocat' and saves it to the local machine.
#>
function Save-GitHubRepository
{
    param(
        [Parameter(Mandatory)]
        [string]$Owner,

        [Parameter(Mandatory)]
        [string]$Project,

        [Parameter()]
        [string]$Branch = 'master'
    )

    $destinationPath = "C:\Program Files\OpenSCAD\libraries\$Project"
    $outputFile = "$Project.zip"

    # Download Library Source
    curl.exe -L https://github.com/$Owner/$Project/archive/$Branch.zip -o $outputFile

    # Unzip and reshuffle files
    Expand-Archive $outputFile -Force
    Get-ChildItem .\$Project\$Project-$Branch\ | ForEach-Object { Move-Item .\$Project\$Project-$Branch\$_ -Destination .\$Project }

    # Cleanup before moving
    Remove-Item .\$Project\$Project-$Branch\
    Remove-Item $destinationPath -Force -Recurse

    Move-Item .\$Project -Destination $destinationPath -Force

    # Cleanup Zip
    Remove-Item $outputFile
}

<#
.SYNOPSIS
Downloads a tarball release from a GitHub repository and saves it to a specified location on the local machine.

.DESCRIPTION
The Save-GitHubReleaseTar script takes three parameters: Owner, Project, and ArtifactName. All three parameters are mandatory. The Owner and Project parameters specify the owner and name of the GitHub repository to download the release from. The ArtifactName parameter specifies the name of the release artifact to download.

The script first defines the destination path for the downloaded release and the name of the output tarball file. It then uses curl.exe to download the specified release artifact from GitHub as a tarball file. The script then extracts the contents of the tarball to a temporary directory and moves its contents to the specified destination path. Finally, it performs some cleanup by removing the temporary files created during the process.

.PARAMETER Owner
Specifies the owner of the GitHub repository to download the release from.

.PARAMETER Project
Specifies the name of the GitHub repository to download the release from.

.PARAMETER ArtifactName
Specifies the name of the release artifact to download.

.EXAMPLE
Save-GitHubReleaseTar -Owner 'octocat' -Project 'Hello-World' -ArtifactName 'hello-world.tar.gz'

Downloads the 'hello-world.tar.gz' release artifact from the 'Hello-World' repository owned by 'octocat' and saves it to the local machine.
#>

function Save-GitHubReleaseTar
{
    param(
        [Parameter(Mandatory)]
        [string]$Owner,

        [Parameter(Mandatory)]
        [string]$Project,

        [Parameter(Mandatory)]
        [string]$ArtifactName
    )
    $outputFile = "$Project.tar.gz"
    $destinationPath = "C:\Program Files\OpenSCAD\libraries\$Project"

    # Download Github Release File
    curl.exe -L https://github.com/$Owner/$Project/releases/latest/download/$ArtifactName -o $outputFile

    # Extract tarball
    mkdir "$PWD\$Project"
    tar.exe -xf $outputFile --directory "$PWD\$Project"

    # Cleanup Destination
    Remove-Item $destinationPath -Force -Recurse

    Move-Item .\$Project -Destination $destinationPath -Force

    # Cleanup Tarball
    Remove-Item $outputFile
}

Save-GitHubRepository -Owner Obijuan -Project obiscad
Save-GitHubRepository -Owner revarbat -Project BOSL
Save-GitHubReleaseTar -Owner boltsparts -Project BOLTS_archive -ArtifactName boltsos_0.4.1.tar.gz
