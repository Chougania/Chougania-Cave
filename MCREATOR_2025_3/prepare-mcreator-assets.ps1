[CmdletBinding()]
param(
    [string]$SourceRoot = (Join-Path $PSScriptRoot ".."),
    [string]$OutputRoot = (Join-Path $PSScriptRoot "IMPORT_MCREATOR")
)

$ErrorActionPreference = "Stop"
$SourceRoot = [System.IO.Path]::GetFullPath($SourceRoot)
$OutputRoot = [System.IO.Path]::GetFullPath($OutputRoot)

$resourceRoot = Join-Path $SourceRoot "src/main/resources"
$assetsRoot = Join-Path $resourceRoot "assets/alexscaves"
$dataRoot = Join-Path $resourceRoot "data/alexscaves"

if (-not (Test-Path $assetsRoot)) {
    throw "Dossier source introuvable : $assetsRoot. Lance le script depuis le dépôt complet."
}

if (Test-Path $OutputRoot) {
    Remove-Item $OutputRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $OutputRoot | Out-Null

$inventory = [System.Collections.Generic.List[object]]::new()

function Copy-Category {
    param(
        [string]$SourceDirectory,
        [string]$Category,
        [string]$DestinationDirectory
    )

    if (-not (Test-Path $SourceDirectory)) { return }

    Get-ChildItem -LiteralPath $SourceDirectory -File -Recurse | ForEach-Object {
        $relative = $_.FullName.Substring($SourceDirectory.Length).TrimStart('\','/')
        $destination = Join-Path $DestinationDirectory $relative
        $parent = Split-Path -Parent $destination
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $destination -Force

        $inventory.Add([pscustomobject]@{
            category = $Category
            source = $_.FullName.Substring($SourceRoot.Length).TrimStart('\','/')
            exported = $destination.Substring($OutputRoot.Length).TrimStart('\','/')
            extension = $_.Extension
            bytes = $_.Length
            import_note = "Ressource brute : associer à un mod element MCreator ou conserver comme ressource personnalisée."
        })
    }
}

# Ressources visuelles et audio. Les chemins relatifs sont conservés pour éviter les collisions.
Copy-Category (Join-Path $assetsRoot "textures") "textures" (Join-Path $OutputRoot "assets/textures")
Copy-Category (Join-Path $assetsRoot "models") "models" (Join-Path $OutputRoot "assets/models")
Copy-Category (Join-Path $assetsRoot "blockstates") "blockstates" (Join-Path $OutputRoot "assets/blockstates")
Copy-Category (Join-Path $assetsRoot "sounds") "sounds" (Join-Path $OutputRoot "assets/sounds")

# Langues, particules, shaders, modèles d'entités et autres ressources restantes.
Get-ChildItem -LiteralPath $assetsRoot -File -Recurse | Where-Object {
    $_.FullName -notmatch '[\\/](textures|models|blockstates|sounds)[\\/]'
} | ForEach-Object {
    $relative = $_.FullName.Substring($assetsRoot.Length).TrimStart('\','/')
    $destination = Join-Path (Join-Path $OutputRoot "assets/other") $relative
    New-Item -ItemType Directory -Path (Split-Path -Parent $destination) -Force | Out-Null
    Copy-Item -LiteralPath $_.FullName -Destination $destination -Force
    $inventory.Add([pscustomobject]@{
        category = "other_assets"
        source = $_.FullName.Substring($SourceRoot.Length).TrimStart('\','/')
        exported = $destination.Substring($OutputRoot.Length).TrimStart('\','/')
        extension = $_.Extension
        bytes = $_.Length
        import_note = "Vérifier le format et l'usage avant import."
    })
}

# Les données JSON sont exportées à part : elles ne sont pas automatiquement des mod elements MCreator.
Copy-Category $dataRoot "data_json" (Join-Path $OutputRoot "data")

$inventory | Sort-Object category, source | Export-Csv -LiteralPath (Join-Path $OutputRoot "inventory.csv") -NoTypeInformation -Encoding UTF8
$inventory | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $OutputRoot "inventory.json") -Encoding UTF8

@"
IMPORT MCREATOR — CHOUGANIA CAVE

Ce dossier contient les ressources extraites du dépôt source :
- assets/ : textures, modèles, blockstates, sons et autres ressources ;
- data/ : JSON de données Minecraft (recettes, tags, worldgen, etc.) ;
- inventory.csv / inventory.json : inventaire des fichiers exportés.

IMPORTANT :
Ces fichiers ne constituent PAS un workspace MCreator prêt à ouvrir.
Les JSON de Minecraft et les ressources Java ne se transforment pas automatiquement en mod elements.
Importe les ressources depuis MCreator, puis recrée les éléments et procédures en suivant
MCREATOR_2025_3/README.md et migration-manifest.json.

La conversion complète des biomes, entités animées, IA, interfaces et systèmes spéciaux
nécessite du code Java personnalisé et des tests dans le générateur NeoForge 1.21.1.
"@ | Set-Content -LiteralPath (Join-Path $OutputRoot "LISEZ-MOI.txt") -Encoding UTF8

Write-Host "Export terminé : $OutputRoot"
Write-Host "Fichiers inventoriés : $($inventory.Count)"
