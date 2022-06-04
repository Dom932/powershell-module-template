
# Load public and private functions

$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue -Recurse)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue -Recurse)

foreach ($file in @($Public + $Private)) {
    try {
        . $file.FullName
    } catch {
        Write-Error "Failed to import $($file.FullName): $_"
    }
}

# Export public functions instead of defining them in the module manifest
foreach ($file in $Public) {
    Export-ModuleMember -Function $file.BaseName
}
