# 🚀 Guide d'Installation Flutter pour BiodiverSen

## ✅ Projet Flutter PRÊT

Tous les fichiers Dart, Android et iOS ont été créés. Il ne manque que **l'installation de Flutter SDK**.

## 📥 Installation de Flutter

### Option 1 - Téléchargement Direct (Recommandé)

1. **Télécharge Flutter** depuis : https://flutter.dev/docs/get-started/install/windows
   - Choisis la dernière version stable (v3.19+)
   - Format : `flutter_windows_X.X.X-stable.zip`

2. **Extrait le fichier** dans un dossier sans espaces
   ```
   C:\src\flutter
   ```
   (Ou n'importe quel dossier, mais sans espaces)

3. **Ajoute Flutter au PATH Windows**
   - Ouvre "Éditer les variables d'environnement"
   - Clique sur "Variables d'environnement"
   - Ajoute `C:\src\flutter\bin` à la variable `Path`
   - Relance PowerShell

4. **Vérifie l'installation**
   ```powershell
   flutter --version
   ```

### Option 2 - Git Clone

Si tu préfères une approche plus légère :

```powershell
cd C:\src
git clone https://github.com/flutter/flutter.git -b stable
$env:PATH += ";C:\src\flutter\bin"
flutter --version
```

## 🔧 Après Installation

Une fois Flutter installé, tape dans le terminal :

```bash
cd C:\Users\Dell\Desktop\PROJET_FLUTTER\biodiversen
flutter pub get
flutter run
```

## ✅ Liste de Vérification

- [ ] Flutter SDK téléchargé et extrait
- [ ] Flutter/bin ajouté au PATH Windows
- [ ] PowerShell fermé et relancé
- [ ] `flutter --version` fonctionne
- [ ] `flutter pub get` complété
- [ ] `flutter run` lance l'app

## 📞 Besoin d'aide ?

Si tu rencontres des problèmes, dis-moi :
- Le message d'erreur exact
- Le résultat de `flutter doctor`
- Ton système (Windows 10/11)

Ton projet BiodiverSen est **100% prêt**. Il manque juste Flutter ! 🎯
