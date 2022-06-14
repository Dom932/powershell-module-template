# PSScriptAnalyzer - Suppress Messages
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "", Justification="Test File")]
param ()

BeforeAll {
    $module = Get-ChildItem -Path (Split-Path -Path $PSScriptRoot -Parent) -Filter '*.psd1'
    $ps1Files = Get-ChildItem -Path "$($module.Directoryname)\Public\*.ps1"
    $moduleInformation = Get-Module -Name $module.BaseName
    # If test has been run directory then module will need to be imported
    if (! $moduleInformation) {
        $moduleInformation = $moduleInformation = Import-Module $module.FullName -Force -PassThru
    }
}

Describe "$($module.BaseName) Module - Testing Manifest File (.psd1)" {

    Context "Manifest" {

        It "Module should contain RootModule" {
            $moduleInformation.RootModule | Should -Not -BeNullOrEmpty
        }

        It "Module should contain ModuleVersion" {
            $moduleInformation.Version | Should -Not -BeNullOrEmpty
        }

        It "Module should contain GUID" {
            $moduleInformation.Guid | Should -Not -BeNullOrEmpty
        }

        It "Module should contain Author" {
            $moduleInformation.Author | Should -Not -BeNullOrEmpty
        }

        It "Module should contain Description" {
            $moduleInformation.Description | Should -Not -BeNullOrEmpty
        }

        It "Check count of Function Exported and the public PS1 files" {
            $status = $moduleInformation.ExportedFunctions.Values.Name.Count -eq $ps1Files.Count
            $status | Should -Be $true
        }
    }
}
