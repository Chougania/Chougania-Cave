# Démarrer le workspace MCreator 2025.3

Ce guide concerne le portage du dépôt vers **Minecraft 1.21.1 / NeoForge**. Ne pas sélectionner la cible 1.21.8 du JAR séparé.

## Création du workspace de base

1. Ouvrir MCreator 2025.3.
2. Créer un workspace **Minecraft mod / NeoForge 1.21.1**.
3. Nom : `Chougania Cave`.
4. Mod ID : `chougania_cave`.
5. Package Java : `net.mcreator.chouganiacave` (confirmé par les classes du JAR fourni).
6. Langage : Java 21.
7. Enregistrer puis fermer MCreator.

## Ressources à importer

Depuis le dépôt cloné, exécuter dans PowerShell :

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\MCREATOR_2025_3\prepare-mcreator-assets.ps1
```

Le dossier `MCREATOR_2025_3/IMPORT_MCREATOR` contient les ressources regroupées et leur inventaire. Importer les textures, sons et modèles par les gestionnaires de ressources de MCreator. Conserver les JSON de worldgen comme références de conversion : ils ne sont pas des mod elements MCreator prêts à l'emploi.

## Fichiers de référence

- `migration-manifest.json` : configuration de migration.
- `registry-migration-inventory.csv` : liste des blocs, items, entités, fluides et biomes détectés.
- `MIGRATION_PLAN.md` : ordre de conversion et limites techniques.
- `README.md` : vue d'ensemble du portage.

## Important : format workspace

Le format de workspace partageable est généré par MCreator lui-même. Ce dépôt ne doit pas prétendre qu'un fichier ZIP fabriqué à la main est un workspace validé. Une fois le workspace de base créé, utiliser **Fichier → Exporter le workspace vers un fichier ZIP partageable** et conserver cette archive avec le projet. Ce ZIP permettra de reprendre la conversion des mod elements sans risquer de fabriquer un fichier workspace invalide.
