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

Save-GitHubRepository Obijuan obiscad
Save-GitHubRepository revarbat BOSL
Save-GitHubReleaseTar boltsparts BOLTS_archive boltsos_0.4.1.tar.gz
