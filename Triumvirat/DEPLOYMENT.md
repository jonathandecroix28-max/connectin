# Déploiement gratuit Render + TiDB + Supabase Storage

## Render

Le fichier `render.yaml` configure deux services gratuits:

- `triumvirat-backend` pour l'API Laravel sur le plan gratuit de Render
- `triumvirat-frontend` pour la SPA Vue compilée en statique

Le frontend statique est gratuit sur Render. Le backend utilise aussi le compute gratuit, avec la limite classique des services free qui peuvent s'endormir après inactivité.

Pour les médias, le backend utilise Supabase Storage via son interface S3-compatible. Le bucket doit être public si tu veux servir les images directement au frontend.

Avant de lancer le blueprint, renseigne les secrets du backend dans Render:

- `APP_KEY`
- `DB_HOST`
- `DB_DATABASE`
- `DB_USERNAME`
- `DB_PASSWORD`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`
- `AWS_BUCKET`
- `AWS_URL`
- `AWS_ENDPOINT`

`VITE_API_URL` pointe vers le backend Render. `VITE_STORAGE_URL` pointe vers l'URL publique du bucket Supabase. Si tu changes le nom du service, mets `VITE_API_URL` à jour.

`VITE_STORAGE_URL` doit contenir l'URL publique du bucket Supabase, pas l'URL du backend.

## TiDB

TiDB Cloud Starter propose une offre gratuite compatible MySQL, donc Laravel peut s'y connecter avec `DB_CONNECTION=mysql`.

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

Exemple Supabase Storage:

```dotenv
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=ton-bucket-public
AWS_ENDPOINT=https://<project-ref>.supabase.co/storage/v1/s3
AWS_URL=https://<project-ref>.supabase.co/storage/v1/object/public/ton-bucket-public
AWS_USE_PATH_STYLE_ENDPOINT=true
```

## Point important

Le stockage local n'est plus la cible de production. En local, les fichiers passent encore par le disque `public`, mais sur Render les médias doivent aller vers le bucket Supabase public que tu renseignes avec les variables AWS ci-dessus.

