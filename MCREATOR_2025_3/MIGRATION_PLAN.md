# Plan de migration MCreator — Chougania Cave

## Cible conservée

- MCreator : **2025.3**
- Minecraft : **1.21.1**
- Générateur : **NeoForge 1.21.1**
- Version du générateur MCreator : **21.1.190**
- Mod ID de destination : `chouganiacave`
- Namespace du code source : `alexscaves`
- Java : **21**

Le dépôt source reste inchangé sur `main`. Le travail de migration est isolé dans `mcreator-2025.3-workspace`.

## Inventaire extrait des registres Java

L'inventaire est produit à partir des registres du dépôt source, pas d'une estimation :

| Famille | Entrées détectées |
|---|---:|
| Blocs | 352 |
| Items | 189 |
| Entités | 83 |
| Fluides | 4 |
| Biomes | 6 |
| **Total** | **634** |

Fichiers :
- `registry-migration-inventory.json` : données structurées complètes.
- `registry-migration-inventory.csv` : version tableur avec identifiant source et identifiant cible suggéré.

Les identifiants `alexscaves:...` sont les identifiants d'origine. La colonne `target_id` propose leur équivalent `chouganiacave:...`; cette substitution doit être appliquée de façon cohérente dans les références, recettes, tags, loot tables et données de génération.

## Ordre conseillé de reconstruction

1. **Ressources** : textures, sons, modèles, traductions et particules.
2. **Blocs simples** : blocs décoratifs, minerais, variantes, dalles, escaliers et murs.
3. **Items simples** : matériaux, consommables et outils standards.
4. **Recettes, tags et loot tables** : relier les éléments déjà recréés.
5. **Biomes** : créer les six biomes et reconstituer leurs paramètres.
6. **Fluides et blocs spéciaux** : acide, fluides personnalisés, blocs à interactions.
7. **Entités** : d'abord les entités simples, puis IA, animations, montures et boss.
8. **Génération du monde et systèmes avancés** : features, structures, événements, rendu, effets et intégration Citadel.

## Ce qui n'est pas converti automatiquement

Un identifiant extrait d'un registre n'est pas encore un mod element MCreator. Le CSV est un backlog de migration, pas la preuve que 634 éléments sont déjà recréés. Les comportements codés en Java, les animations et l'IA ne peuvent pas être reconstruits à partir du seul nom d'enregistrement.

## Dépendance et licence

Le projet source utilise Citadel. Les fonctions qui en dépendent doivent être adaptées ou remplacées si le workspace cible ne peut pas déclarer cette API comme dépendance. Conserver la GPL-3.0 et les crédits d'AlexModGuy ; présenter le résultat comme un portage/adaptation.
