# Déploiement Render + TiDB

## Render

Le fichier `render.yaml` configure deux services:

- `triumvirat-backend` pour l'API Laravel
- `triumvirat-frontend` pour la SPA Vue compilée en statique

Avant de lancer le blueprint, renseigne les secrets du backend dans Render:

- `APP_KEY`
- `DB_HOST`
- `DB_DATABASE`
- `DB_USERNAME`
- `DB_PASSWORD`

Les valeurs `VITE_API_URL` et `VITE_STORAGE_URL` pointent vers le backend Render. Si tu changes le nom du service, mets les mêmes valeurs à jour.

## TiDB

TiDB est compatible MySQL, donc Laravel peut s'y connecter avec `DB_CONNECTION=mysql`.

Paramètres à récupérer dans TiDB Cloud:

- hôte
- port MySQL, souvent `4000`
- nom de base
- utilisateur
- mot de passe

Exemple de variables d'environnement:

```dotenv
DB_CONNECTION=mysql
DB_HOST=tidb-host.example.com
DB_PORT=4000
DB_DATABASE=connectin
DB_USERNAME=...
DB_PASSWORD=...
```

