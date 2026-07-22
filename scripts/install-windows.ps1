[CmdletBinding()]
param(
    [string]$CodexHome,
    [switch]$PetOnly,
    [switch]$SkillOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ($PetOnly -and $SkillOnly) {
    throw "Choose either -PetOnly or -SkillOnly, not both. Omit both switches to install both."
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
$InstallPet = -not $SkillOnly
$InstallSkill = -not $PetOnly

New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null

function Assert-SourceFile {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Required source file is missing: $Path"
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
        throw "SHA-256 verification failed for $Destination"
    }
}

if ($InstallPet) {
    $SourcePet = Join-Path $RepoRoot "examples\dragon-hood-girl\package"
    $SourceManifest = Join-Path $SourcePet "pet.json"
    $SourceSpritesheet = Join-Path $SourcePet "spritesheet.webp"
    Assert-SourceFile $SourceManifest
    Assert-SourceFile $SourceSpritesheet

    $PetDirectory = Join-Path $CodexHome "pets\dragon-hood-girl"
    New-Item -ItemType Directory -Force -Path $PetDirectory | Out-Null
    $InstalledManifest = Join-Path $PetDirectory "pet.json"
    $InstalledSpritesheet = Join-Path $PetDirectory "spritesheet.webp"
    Copy-Item -LiteralPath $SourceManifest -Destination $InstalledManifest -Force
    Copy-Item -LiteralPath $SourceSpritesheet -Destination $InstalledSpritesheet -Force

    $Manifest = Get-Content -LiteralPath $InstalledManifest -Raw | ConvertFrom-Json
    if ($Manifest.id -ne "dragon-hood-girl") {
        throw "Installed pet.json has an unexpected id: $($Manifest.id)"
    }
    if ($Manifest.spriteVersionNumber -ne 2) {
        throw "Installed pet.json must declare spriteVersionNumber 2."
    }
    if ($Manifest.spritesheetPath -ne "spritesheet.webp") {
        throw "Installed pet.json must use the relative spritesheetPath spritesheet.webp."
    }
    Assert-MatchingHash $SourceManifest $InstalledManifest
    Assert-MatchingHash $SourceSpritesheet $InstalledSpritesheet
    Write-Host "Installed Dragon Hood Girl to $PetDirectory"
}

if ($InstallSkill) {
    $SourceSkill = Join-Path $RepoRoot "skill\make-keepsake-pet"
    $SourceSkillManifest = Join-Path $SourceSkill "SKILL.md"
    Assert-SourceFile $SourceSkillManifest

    $SkillDirectory = Join-Path $CodexHome "skills\make-keepsake-pet"
    New-Item -ItemType Directory -Force -Path $SkillDirectory | Out-Null
    Copy-Item -Path (Join-Path $SourceSkill "*") -Destination $SkillDirectory -Recurse -Force

    $InstalledSkillManifest = Join-Path $SkillDirectory "SKILL.md"
    Assert-SourceFile $InstalledSkillManifest
    Assert-MatchingHash $SourceSkillManifest $InstalledSkillManifest
    Write-Host "Installed make-keepsake-pet to $SkillDirectory"
}

Write-Host "Installation verified. Restart or reload the ChatGPT desktop app before selecting the pet or invoking the skill."
