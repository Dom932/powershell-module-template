# PowerShell Module Template

This repository contains an example PowerShell module

## Usage

1. Clone the repository

    ```powershell
    git clone --depth=1 https://github.com/Dom932/powershell-module-template.git <ModuleName>
    Remove-Item <ModuleName>/.git
    ```

2. Rename `ModuleName.psm1` and `ModuleName.Tests.ps1` to the the desired module name.

3. Generate a module manifest. For Example:

    ```powershell
    New-ModuleManifest -RootModule "<ModuleName>" -Path "<ModuleName>.psd1" -Author "<Author>" -Description "<Description>" -PowershellVersion "7.0" 
    ```

4. Update `README.md` file
