# MonArgent

Application de gestion de finances personnelles développée dans le cadre de l'UE
IF26. Cette application utilise [SwiftUI](https://developer.apple.com/xcode/swiftui/)
et nécesssite iOS 13.1 ou plus récent.

La persistance des données est gérée à l'aide de
[GRDBCombine](https://github.com/groue/GRDBCombine). Cette dépendance est gérée
automatiquement par Xcode à l'aide de [SwiftPM](https://swiftpm.co/about/).

## Développement

Ce projet utilise [SwiftLint](https://github.com/realm/SwiftLint) afin de
vérifier le code Swift. Une fois SwiftLint installé, utilisez les commandes
suivantes (à entrer à la racine du répertoire du projet):

```bash
# Cherche les violations du style de code Swift
swiftlint

# Tente de résoudre automatiquement les violations du style de code Swift
swiftlint autocorrect
```

## Licence

Copyright © 2019-2020 Hugo Locurcio

Sauf mention contraire, les fichiers présents dans ce dépôt sont disponibles
sous licence MIT. Consultez [LICENSE.md](LICENSE.md) pour plus d'informations.
