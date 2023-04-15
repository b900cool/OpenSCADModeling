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

    $outputFile = "$Project.zip"

    curl.exe -L https://github.com/$Owner/$Project/archive/$Branch.zip -o $outputFile

    $destinationPath = "C:\Program Files\OpenSCAD\libraries\$Project"

    Expand-Archive $outputFile -Force

    Get-ChildItem .\$Project\$Project-$Branch\ | ForEach-Object { Move-Item .\$Project\$Project-$Branch\$_ -Destination .\$Project }
    Remove-Item .\$Project\$Project-$Branch\

    Remove-Item $destinationPath -Force -Recurse

    Move-Item .\$Project -Destination $destinationPath -Force

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

    curl.exe -L https://github.com/$Owner/$Project/releases/latest/download/$ArtifactName -o $outputFile
    
    $destinationPath = "C:\Program Files\OpenSCAD\libraries\$Project"

    mkdir "$PWD\$Project"
    tar.exe -xf $outputFile --directory "$PWD\$Project"

    Remove-Item $destinationPath -Force -Recurse

    Move-Item .\$Project -Destination $destinationPath -Force

    Remove-Item $outputFile
}

Save-GitHubRepository Obijuan obiscad
Save-GitHubRepository revarbat BOSL
Save-GitHubReleaseTar boltsparts BOLTS_archive boltsos_0.4.1.tar.gz
