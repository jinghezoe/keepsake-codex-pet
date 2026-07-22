[CmdletBinding()]
param(
    [string]$CodexHome,
    [switch]$PetOnly,
    [switch]$SkillOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ($PetOnly -and $SkillOnly) {
    throw "Choose either -PetOnly or -SkillOnly, not both. Omit both switches to verify both."
}

if ([string]::IsNullOrWhiteSpace($CodexHome)) {
    if (-not [string]::IsNullOrWhiteSpace($env:CODEX_HOME)) {
        $CodexHome = $env:CODEX_HOME
    }
    else {
        $CodexHome = Join-Path $HOME ".codex"
    }
}

$CodexHome = [System.IO.Path]::GetFullPath($CodexHome)
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$VerifyPet = -not $SkillOnly
$VerifySkill = -not $PetOnly

function Assert-File {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Required installed file is missing: $Path"
    }
}

function Assert-MatchingHash {
    param(
        [string]$Source,
        [string]$Destination
    )

    $SourceHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Source).Hash
    $DestinationHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Destination).Hash
    if ($SourceHash -ne $DestinationHash) {
        throw "Installed file does not match the repository package: $Destination"
    }
}

if ($VerifyPet) {
    $SourcePet = Join-Path $RepoRoot "examples\dragon-hood-girl\package"
    $PetDirectory = Join-Path $CodexHome "pets\dragon-hood-girl"
    $SourceManifest = Join-Path $SourcePet "pet.json"
    $SourceSpritesheet = Join-Path $SourcePet "spritesheet.webp"
    $InstalledManifest = Join-Path $PetDirectory "pet.json"
    $InstalledSpritesheet = Join-Path $PetDirectory "spritesheet.webp"
    Assert-File $InstalledManifest
    Assert-File $InstalledSpritesheet

    $Manifest = Get-Content -LiteralPath $InstalledManifest -Raw | ConvertFrom-Json
    if ($Manifest.id -ne "dragon-hood-girl" -or $Manifest.spriteVersionNumber -ne 2) {
        throw "The installed pet manifest is not the expected v2 Dragon Hood Girl package."
    }
    if ($Manifest.spritesheetPath -ne "spritesheet.webp") {
        throw "The installed manifest does not use a portable relative spritesheetPath."
    }
    Assert-MatchingHash $SourceManifest $InstalledManifest
    Assert-MatchingHash $SourceSpritesheet $InstalledSpritesheet
    Write-Host "PASS pet: $PetDirectory"
}

if ($VerifySkill) {
    $SourceSkillManifest = Join-Path $RepoRoot "skill\make-keepsake-pet\SKILL.md"
    $InstalledSkillManifest = Join-Path $CodexHome "skills\make-keepsake-pet\SKILL.md"
    Assert-File $InstalledSkillManifest
    Assert-MatchingHash $SourceSkillManifest $InstalledSkillManifest
    Write-Host "PASS skill: $(Split-Path -Parent $InstalledSkillManifest)"
}

Write-Host "Windows compatibility verification passed."
