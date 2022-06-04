$Module = Get-ChildItem -Path $PSScriptRoot -Filter '*.psd1'

if (! $Module) {
    throw "Path $PSScriptRoot doesn't contain PSD1 file."
}

# Load and get module information
$ModuleInformation = Import-Module $Module.FullName -Force -PassThru

# Determine required modules (including testing modules) and install if required
$RequiredModules = @('Pester') + $ModuleInformation.RequiredModules

foreach ($m in $RequiredModules) {
    if( ! (Get-Module -ListAvailable -Name $M) ){
        Write-Verbose "'$m' Not installed, downloading and installing $m from PSGallery."
        Install-Module -Name $m.ModuleName -Force -Repository PSGallery
        Write-Verbose "'$m' installed."
    }
}

# Run tests
Invoke-Pester -Output Detailed $PSScriptRoot\Tests
