# Chougania Cave — préparation MCreator 2025.3

> Dossier de migration vers un workspace MCreator. Cible : Minecraft Java 1.21.1 / NeoForge.

## État honnête de la conversion

Le dépôt source est un portage Java complet d'Alex's Caves, pas un workspace MCreator. Les 8 355 entrées recensées incluent des milliers de classes Java, modèles, animations, sons et données de worldgen. Renommer le projet Gradle ou copier les JSON de ressources dans un workspace ne convertit pas ces systèmes en mod elements MCreator.

Ce dossier fournit l'inventaire de migration et les règles de conversion. Il ne prétend pas être un ZIP workspace MCreator importable : celui-ci doit être construit et validé par MCreator 2025.3, car les fichiers `.mcreator` et `.mod.json` doivent respecter exactement les définitions de mod elements de cette version.

## Cible technique

- MCreator : **2025.3**
- Minecraft : **1.21.1**
- Générateur : **NeoForge**
- Java : **21**
- NeoForge fourni par le générateur MCreator 2025.3 : **21.1.190**
- Namespace de ressources source : `alexscaves`
- Package Java source : `com.github.alexmodguy.alexscaves`
- Dépendance de contenu : **Citadel** (le code source dépend de Citadel)
- JEI est une dépendance de développement facultative dans le build source.

Le build source actuel utilise NeoForge 21.1.219. Il faudra vérifier les API utilisées avant de porter les classes Java vers la version 21.1.190 du générateur MCreator.

## Biomes souterrains identifiés

1. `primordial_caves` — grottes primordiales
2. `abyssal_chasm` — gouffre abyssal
3. `forlorn_hollows` — cavités désolées
4. `toxic_caves` — grottes toxiques
5. `magnetic_caves` — grottes magnétiques
6. `candy_cavity` — cavité sucrée

Le fichier `migration-manifest.json` contient les catégories et chemins de ressources repérés.

## Stratégie de conversion

### Importables / recréables dans l'éditeur MCreator
- blocs et variantes simples ;
- items, outils, armures et matériaux ;
- recettes, tables de butin, tags, advancements ;
- sons et traductions ;
- particules et effets simples ;
- certaines plantes et entités simples.

### À reconstruire avec procédures et code Java personnalisé
- génération des six biomes et leurs règles de placement ;
- structures et features complexes ;
- entités avec IA, animations et comportements spécifiques ;
- dimensions / portails et systèmes de progression ;
- interfaces spécialisées, machines et systèmes de rendu ;
- intégrations Citadel et hooks NeoForge.

### Ressources
Les fichiers JSON de `assets/alexscaves` et `data/alexscaves` ne sont pas tous des fichiers directement importables comme mod elements. Les blockstates, modèles, textures, sons et données de worldgen doivent être associés à des éléments MCreator ou conservés comme ressources personnalisées selon leur usage.

## Ordre de portage conseillé

1. Créer le workspace MCreator 2025.3 NeoForge 1.21.1 avec le mod ID `chouganiacave`.
2. Importer les textures, modèles, sons et traductions en préservant les noms source utiles.
3. Recréer les blocs et items de base, puis recettes, loot tables et tags.
4. Porter les features et structures en lots testables.
5. Porter les biomes et leur génération.
6. Porter les entités et leurs comportements/animations.
7. Réintégrer les classes Java complexes et Citadel, en les adaptant à NeoForge 21.1.190.
8. Compiler et tester chaque lot avant d'ajouter le suivant.

## Licence et attribution

Le code source est sous GPL-3.0. Conserver le fichier LICENSE et les crédits des auteurs originaux, notamment AlexModGuy. Une adaptation ou un portage doit être clairement distingué de l'œuvre originale ; ne pas présenter Alex's Caves comme une création originale de Chougan2.

## Références
- [MCreator 2025.3 — notes de version](https://mcreator.net/news/120031/mcreator-20253-new-features-and-new-minecraft-version)
- [Importer / exporter un workspace partageable](https://mcreator.net/wiki/how-export-and-import-shareable-workspaces)
- [Configuration d'un nouveau workspace](https://mcreator.net/wiki/create-new-workspace-window)
