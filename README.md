# flollylist_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Configuration des variables d'environnement

Ce projet lit les URL d'API depuis un fichier `.env` à la racine. Copiez
`.env.example` en `.env` et adaptez les valeurs avant de lancer l'application :

```bash
cp .env.example .env
# Éditez .env puis installez les dépendances
flutter pub get
```

Les variables disponibles (exemples) :
- `BASE_URL_AUTH` — URL du service d'authentification
- `BASE_URL_DATA` — URL du service de données

Le fichier `.env` est chargé au démarrage dans `lib/main.dart`.
