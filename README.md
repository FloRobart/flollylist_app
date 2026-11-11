# FlollyList — Application

FlollyList est l'application qui permet de gérer facilement les cadeaux de Noël de ses proches : pour chacun, les cadeaux de chaque année, leur prix, une description et un lien. L'accueil montre le budget de Noël de l'année, et en rouge les proches qui n'ont pas encore de cadeau.

Elle fonctionne sur le web (image Docker servie par nginx) et sur Android. Les données viennent de `flollylist-api`, et la connexion de [Floraccess](https://github.com/FloRobart/FlorAccess_server).

# Table des matières

- [Fonctionnement](#fonctionnement)
- [Architecture](#architecture)
- [Configuration des environnements](#configuration-des-environnements)
- [Développement](#développement)
- [Tests et qualité](#tests-et-qualité)
- [Production](#production)

# Fonctionnement

- **Connexion sans mot de passe** : l'utilisateur entre son email, reçoit un code de 6 caractères (lettres majuscules et chiffres), puis le saisit. Floraccess crée le compte s'il n'existe pas : connexion et inscription ne font qu'un.
- **Code de l'application** : après la première connexion, l'utilisateur choisit un code de 4 à 12 chiffres, demandé à chaque ouverture, pour que ses proches ne découvrent pas leurs cadeaux sur son appareil. Seule son empreinte (PBKDF2-HMAC-SHA256 salé) est stockée. « Code oublié ? » déconnecte l'utilisateur : il doit se reconnecter par email pour en choisir un nouveau. La déconnexion supprime aussi le code.
- **Rien n'est gardé sur l'appareil**, à part le JWT, l'email de connexion, le thème et l'empreinte du code : les listes de cadeaux restent sur le serveur. Au démarrage, l'application supprime ce que l'ancienne version laissait dans le stockage (le code en clair et une copie de tous les cadeaux).
- **Session refusée par le serveur** (expirée, ou « déconnexion de tous les appareils ») : l'application revient d'elle-même à l'écran de connexion.

# Architecture

La même que celle d'`econoris-app` : MVVM avec [Riverpod](https://riverpod.dev), [go_router](https://pub.dev/packages/go_router), [Dio](https://pub.dev/packages/dio) et des modèles [freezed](https://pub.dev/packages/freezed).

```
lib/
├── config/        ← configuration (.env, --dart-define), clés du stockage, constantes
├── data/          ← DTO, repositories, clients d'API, session (AuthManager) et verrouillage (AppLockManager)
├── domain/        ← modèles de l'application et cas d'utilisation
├── routing/       ← routes, et route_guard.dart qui décide où envoyer l'utilisateur
├── ui/            ← écrans, widgets et view models
└── utils/
```

Après un changement d'un modèle freezed ou d'un DTO, régénérer le code :

```bash
./scripts/generate_json_serializable_models.sh
```

# Configuration des environnements

L'application charge la configuration dans cet ordre de priorité :

1. Fichier `.env` optionnel servi au runtime, chargé par `flutter_dotenv`
2. Valeurs de compilation via `--dart-define`
3. Valeurs de fallback dans le code

Variables supportées :

- `APP_NAME`
- `AUTH_URL` : l'API de Floraccess
- `DATA_URL` : `flollylist-api`
- `LOCALIZATION`

⚠️ Le `.env` est servi par nginx à tous les visiteurs : il ne doit jamais contenir de secret.

### Android : valeurs à la compilation

```bash
flutter build apk --dart-define-from-file=.env
```

### Web : override au runtime via `.env`

Le fichier `.env` est lu au démarrage (requête sur `/assets/.env`) et permet de changer les URL sans recompiler le code Dart.

En production, le navigateur ne peut appeler que les adresses listées dans le `connect-src` de `nginx.conf` (`https://api.flollylist.florobart.fr` et `https://api.floraccess.florobart.fr`). Une nouvelle adresse doit donc aussi y être ajoutée, puis publiée avec une nouvelle image. En local, `http://localhost` est toujours autorisé.

# Développement

1. Démarrer la base et l'API (voir les README de `flollylist-database` et de `flollylist-api`), ainsi que Floraccess sur le port `26001`.
2. Créer le fichier d'environnement :

    ```bash
    cp .env.example .env
    ```

3. Lancer l'application web sur le port attendu par le CORS de l'API :

    ```bash
    flutter run -d chrome --web-port 26006 --dart-define-from-file=.env
    ```

Avec VS Code, les configurations de `.vscode/launch.json` passent déjà `--dart-define-from-file=.env`.

# Tests et qualité

```bash
dart format --set-exit-if-changed .
```

```bash
flutter analyze
```

```bash
flutter test
```

La CI ([Github-ci](https://github.com/FloRobart/github-ci), type « Flutter ») lance ces trois contrôles sur chaque pull request, puis construit l'APK de debug et l'image Docker. Elle installe Flutter **3.47.9**, la version fixée dans `pubspec.yaml` : le `pubspec.lock` doit être généré avec cette version. À chaque merge sur `main`, elle publie l'image `florobart/flollylist-app` (`<version>` et `latest`) et l'APK dans la GitHub Release.

# Production

L'application est déployée par `flollylist-wrapper`, avec l'API, la base et Traefik : voir son README. Le [docker-compose.yml](docker-compose.yml) de ce dépôt est celui de production : nginx durci (`dhi.io`, sans shell, utilisateur non-root, système de fichiers en lecture seule), aucun port publié, et le `.env` de la machine monté en lecture seule sur `/assets/.env`.

L'image n'utilise aucun CDN (`--no-web-resources-cdn`) et embarque la police Roboto : la Content-Security-Policy de `nginx.conf` n'autorise que les scripts et les polices de l'application elle-même.
