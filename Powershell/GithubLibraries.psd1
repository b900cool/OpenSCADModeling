@{
    RootModule        = 'GithubLibraryDownloader.psm1'
    ModuleVersion     = '1.0'
    GUID              = 'a5c8d2d4-2e89-44e9-89e0-6a2c9f7ec5c3'
    Author            = 'Bobby Belter'
    CompanyName       = 'Bobby Belter Co.'
    Description       = 'A module that contains functions for downloading GitHub repositories and releases.'
    FunctionsToExport = @('Save-GitHubRepository', 'Save-GitHubReleaseTar')
}
