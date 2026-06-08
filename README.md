# BiodiverSen - Inventaire de Faune et Flore

Application Flutter pour l'inventaire de la biodiversité des aires protégées du Sénégal, en lien avec l'ODD 15 - Vie terrestre.

##  Fonctionnalités

- **Inventaire biodiversité** : Liste complète des observations de faune et flore
- **Création d'observation** : Ajouter une nouvelle espèce observée avec validation complète
- **Modification** : Éditer les observations existantes
- **Suppression** : Retirer une observation avec confirmation
- **Filtrage** : Filtrer par type (Faune/Flore) ou afficher tout
- **Comptage** : Affichage automatique des espèces menacées
- **Navigation** : Passage d'arguments entre écrans avec routage nommé
- **Détail** : Consulter les informations complètes d'une espèce

##  Architecture

```
lib/
├── main.dart                          # Point d'entrée + ThemeData + Routes
├── models/
│   └── observation.dart               # Classe Observation + enum TypeEspece
├── screens/
│   ├── liste_screen.dart              # Écran liste (StatefulWidget)
│   ├── detail_screen.dart             # Écran détail (StatelessWidget)
│   ├── formulaire_screen.dart         # Formulaire Create/Update
│   └── apropos_screen.dart            # Écran À propos
├── widgets/
│   └── observation_card.dart          # Widget réutilisable + BadgeMenacee
└── data/
    └── observations_initiales.dart    # 5 espèces du Niokolo-Koba
```

##  Données Initiales

L'application démarre avec 5 espèces réelles du Sénégal :

### Faune
- **Lion d'Afrique** - Niokolo-Koba (Menacée)
- **Hippotrague rouanne** - Niokolo-Koba (Menacée)
- **Lamantin d'Afrique** - Langue de Barbarie (Menacée)

### Flore
- **Rônier** - Niokolo-Koba (Non menacée)
- **Vétiver** - Langue de Barbarie (Non menacée)

##  Exigences du Barème

| Exigence | Fichier | Justification |
|----------|---------|---------------|
| Enum | `observation.dart` | `TypeEspece { faune, flore }` |
| Classe + Constructeur nommé | `observation.dart` | Classe `Observation` avec `required` |
| List<T> | `observation.dart` | `List<Observation>` dans `compterMenacees()` |
| Map | `observation.dart` | `Map<String, dynamic>` dans `toMap()` |
| Méthode calculée | `observation.dart` | `compterMenacees()` static |
| Null Safety | Partout | `required` + pas de `?` inutiles |
| StatelessWidget | `observation_card.dart` | `ObservationCard` et `BadgeMenacee` |
| StatefulWidget | `liste_screen.dart` | `_ListeObservationsState` avec `setState` |
| Form + Validation | `formulaire_screen.dart` | `TextFormField` avec `validator` |
| CRUD Complet | Écrans multiples | Create/Read/Update/Delete |
| Routage 3 écrans | `main.dart` | Routes nommées + passage d'argument |
| ThemeData | `main.dart` | Thème personnalisé Material 3 |
| Icône selon type | `observation_card.dart` | `Icons.pets` / `Icons.park` |
| Badge menacée | `observation_card.dart` | `BadgeMenacee` widget |
| Données réelles | `observations_initiales.dart` | 5 espèces du Sénégal |

##  Installation et Lancement

```bash
# Se placer dans le répertoire du projet
cd biodiversen

# Obtenir les dépendances
flutter pub get

# Lancer l'application
flutter run
```

##  Code à Expliquer en Vidéo (5 min)

1. **Création et suppression avec validation**
   - `_ajouterObservation()` dans `liste_screen.dart`
   - Validation dans `formulaire_screen.dart`
   - Confirmation avant suppression

2. **Filtrage et compteur menacées**
   - `_filtre` et `_observationsFiltrees` getter
   - `_nombreMenacees` calculé automatiquement
   - Boutons `_boutonFiltre()`

3. **Filtrer les espèces menacées**
   - Affichage conditionnel du `BadgeMenacee`
   - Comptage avec `Observation.compterMenacees()`

4. **Passage d'argument entre écrans**
   - `Navigator.pushNamed(..., arguments: obs)`
   - `ModalRoute.of(context)?.settings.arguments as Observation`

## Rapport

Le rapport doit couvrir :
- Justification de l'architecture (MVC : models + screens + widgets)
- Explication du cycle de vie Flutter (setState → build)
- Null safety et bonnes pratiques Dart
- CRUD complet et persistence (en mémoire)
- Routage et passage d'argument
- Exigences ODD 15 et choix des espèces

---

**Auteur** : Gnima Sane  
**Formation** : DAR 2026 — ESMT  
**Date** : Novembre 2024  
**ODD** : 15 - Vie terrestre
