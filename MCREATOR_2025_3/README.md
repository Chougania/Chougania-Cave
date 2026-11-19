# Chougania Cave — kit de migration MCreator 2025.3

Ce dossier prépare les ressources du portage d'Alex's Caves pour leur réutilisation dans MCreator. Il ne convertit pas les milliers de classes Java en mod elements automatiquement : cette conversion exige une reconstruction et des tests dans MCreator.

## Cible de travail

- MCreator 2025.3
- Minecraft Java 1.21.1
- Générateur NeoForge
- Java 21
- Mod ID conseillé : `chouganiacave`
- Dépendance à prévoir pour le portage complet : Citadel

Le dépôt source est un projet Java/NeoForge 1.21.1 (NeoForge 21.1.219), pas un workspace MCreator. Le JAR fourni séparément cible Minecraft 1.21.8 : il ne faut pas mélanger ses dépendances avec cette branche 1.21.1.

## Avancement de la migration

- Inventaire extrait des registres Java : 352 blocs, 189 items, 83 entités, 4 fluides et 6 biomes.
- Voir `registry-migration-inventory.csv` et `registry-migration-inventory.json` pour le détail.
- Voir `MIGRATION_PLAN.md` pour l'ordre de reconstruction et `WORKSPACE_SETUP.md` pour créer le workspace de base.
- Le ZIP partageable final doit être exporté par MCreator après création du workspace ; aucun ZIP MCreator non testé n'est fourni dans cette branche.

## Préparer les ressources

1. Télécharge ou clone la branche `mcreator-2025.3-workspace`.
2. Ouvre PowerShell dans le dossier `MCREATOR_2025_3`.
3. Exécute :

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\prepare-mcreator-assets.ps1
```

Le script crée `IMPORT_MCREATOR/` avec :
- `assets/textures` : textures ;
- `assets/models` : modèles JSON ;
- `assets/blockstates` : états de blocs ;
- `assets/sounds` : sons ;
- `assets/other` : langues, particules et autres ressources ;
- `data/` : données JSON de Minecraft ;
- `inventory.csv` et `inventory.json` : inventaire des fichiers copiés.

Les chemins source sont conservés autant que possible. Les fichiers sont préparés pour inspection/import ; ils ne sont pas tous directement importables dans MCreator.

## Démarrer le workspace

Dans MCreator 2025.3, crée un workspace NeoForge pour Minecraft 1.21.1 avec le mod ID `chouganiacave`. Importe les textures, modèles et sons via les gestionnaires de ressources, puis recrée les mod elements (blocs, items, recettes, entités, biomes, etc.) à partir du manifeste.

## Limites connues

Les éléments suivants demandent une reconstruction spécifique, des procédures ou du code Java personnalisé :
- génération des six biomes souterrains ;
- features, structures et placements complexes ;
- IA et animations d'entités ;
- rendus et interfaces personnalisés ;
- intégration Citadel et événements NeoForge.

Les six biomes repérés sont `primordial_caves`, `abyssal_chasm`, `forlorn_hollows`, `toxic_caves`, `magnetic_caves` et `candy_cavity`.

## Licence et attribution

Conserver la licence GPL-3.0 et les crédits des auteurs originaux, notamment AlexModGuy. Présenter ce travail comme une adaptation/portage, pas comme une création originale de Chougan2.
