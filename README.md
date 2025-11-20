# Cours PostgreSQL - Module SQL

## Pré-requis

### 1. Terminal

Assurez-vous d'avoir accès à un terminal :
- **macOS** : Terminal (pré-installé) ou iTerm2
- **Windows** : PowerShell, Git Bash, ou Windows Terminal
- **Linux** : Terminal de votre distribution

### 2. Git

Git doit être installé sur votre machine :

- **macOS** : 
  ```bash
  # Vérifier si Git est installé
  git --version
  
  # Si non installé, installer via Homebrew
  brew install git
  ```

- **Windows** : Téléchargez et installez [Git pour Windows](https://git-scm.com/download/win)

- **Linux** :
  ```bash
  # Debian/Ubuntu
  sudo apt-get install git
  
  # Fedora
  sudo dnf install git
  ```

Vérifiez l'installation :
```bash
git --version
```

### 3. Cloner ce repository

```bash
git clone git@github.com:lgauthier1/coda-module-sql.git
cd coda-module-sql
```

Si vous n'avez pas encore configuré le remote :
```bash
git remote add origin git@github.com:lgauthier1/coda-module-sql.git
```

### 4. Installer Docker

Assurez-vous d'avoir Docker installé sur votre machine :

- **macOS** : Téléchargez et installez [Docker Desktop pour Mac](https://www.docker.com/products/docker-desktop)
- **Windows** : Téléchargez et installez [Docker Desktop pour Windows](https://www.docker.com/products/docker-desktop)
- **Linux** : Suivez les instructions sur [docs.docker.com](https://docs.docker.com/engine/install/)

Vérifiez l'installation :
```bash
docker --version
docker-compose --version
```

### 5. Client PostgreSQL

**Option 1 : pgAdmin via Docker (recommandé)**

pgAdmin est disponible via un docker-compose séparé. Il sera accessible automatiquement après le démarrage.

> ⚠️ **En cas de problème avec pgAdmin** : Utilisez le fichier `docker-compose.yml` (sans pgAdmin) et installez un client externe (voir Option 2).

**Option 2 : Clients externes (alternative)**

Si vous préférez installer un client localement ou en cas de problème avec pgAdmin Docker :

- **pgAdmin** : [pgadmin.org](https://www.pgadmin.org/download/)
- **DBeaver** : [dbeaver.io](https://dbeaver.io/)
- **TablePlus** : [tableplus.com](https://tableplus.com/)
- **DataGrip** (JetBrains) : [jetbrains.com/datagrip](https://www.jetbrains.com/datagrip/)

## Démarrage de la base de données

### Option 1 : PostgreSQL seul (recommandé si problème avec pgAdmin)

```bash
docker-compose up -d
```

### Option 2 : PostgreSQL + pgAdmin

```bash
docker-compose -f docker-compose-pgadmin.yml up -d
```

> 💡 **Note** : Si vous rencontrez des problèmes avec pgAdmin, utilisez l'Option 1 et installez un client externe (voir section 5).

### Initialiser le schéma et les données

Les scripts doivent être exécutés manuellement après le premier démarrage :

```bash
# 1. Créer le schéma et les tables
docker-compose exec -T postgres psql -U codaSchoolUser -d codaSchool < scripts/init-schema.sql

# Vérifier que les tables ont été créées
docker-compose exec postgres psql -U codaSchoolUser -d codaSchool -c "SELECT tablename FROM pg_tables WHERE schemaname = 'student';"

# 2. Charger les données de test
docker-compose exec -T postgres psql -U codaSchoolUser -d codaSchool < scripts/seed-data.sql

# Vérifier que les données ont été insérées
docker-compose exec postgres psql -U codaSchoolUser -d codaSchool -c "SET search_path TO student; SELECT COUNT(*) FROM etudiant; SELECT COUNT(*) FROM cours; SELECT COUNT(*) FROM inscription; SELECT COUNT(*) FROM note;"
```

La base de données sera accessible avec les paramètres suivants :
- **Host** : `localhost`
- **Port** : `5432`
- **Database** : `codaSchool`
- **Username** : `codaSchoolUser`
- **Password** : `verySecretAndSecurePassword`

### Vérifier que le conteneur fonctionne

```bash
docker-compose ps
```

### Arrêter la base de données

```bash
docker-compose down
```

### Arrêter et supprimer les données

```bash
docker-compose down -v
```

## Connexion avec pgAdmin

### Si vous utilisez docker-compose-pgadmin.yml

1. Accédez à pgAdmin via votre navigateur : http://localhost:5050
2. Connectez-vous avec :
   - Email : `admin@coda-school.com`
   - Password : `admin`
3. Cliquez sur "Add New Server"
4. Dans l'onglet "General" :
   - Name : `Coda School`
5. Dans l'onglet "Connection" :
   - Host : `postgres` (nom du service dans docker-compose)
   - Port : `5432`
   - Database : `codaSchool`
   - Username : `codaSchoolUser`
   - Password : `verySecretAndSecurePassword`
6. Cliquez sur "Save"

### Si vous utilisez un client externe (pgAdmin, DBeaver, etc.)

1. Ouvrez votre client PostgreSQL
2. Créez une nouvelle connexion
3. Paramètres de connexion :
   - Host : `localhost`
   - Port : `5432`
   - Database : `codaSchool`
   - Username : `codaSchoolUser`
   - Password : `verySecretAndSecurePassword`
4. Connectez-vous

## Commandes utiles

### Se connecter via psql (ligne de commande)

```bash
docker-compose exec postgres psql -U codaSchoolUser -d codaSchool
```

Une fois connecté, utilisez le schéma student :
```sql
SET search_path TO student;
\dt
```

### Réinitialiser les données

Pour vider et recréer les données :

```bash
# Supprimer le schéma et toutes ses tables
docker-compose exec postgres psql -U codaSchoolUser -d codaSchool -c "DROP SCHEMA IF EXISTS student CASCADE;"

# Recréer le schéma et les données
docker-compose exec -T postgres psql -U codaSchoolUser -d codaSchool < scripts/init-schema.sql
docker-compose exec -T postgres psql -U codaSchoolUser -d codaSchool < scripts/seed-data.sql
```

### Voir les logs

```bash
docker-compose logs -f postgres
```

### Redémarrer la base de données

```bash
docker-compose restart
```

### Réinitialiser complètement la base de données

Pour recréer la base avec les scripts d'initialisation :

```bash
docker-compose down -v
docker-compose up -d
```

## Structure de la base de données

Le schéma `student` comprend les tables suivantes :

- **student.etablissement** : Établissements d'enseignement
- **student.etudiant** : Étudiants inscrits dans les établissements (2000 étudiants)
- **student.cours** : Cours disponibles (100 cours)
- **student.inscription** : Table de liaison entre étudiants et cours (1000 inscriptions)
- **student.note** : Notes obtenues par les étudiants pour chaque cours (1000 notes)

### Diagramme des relations

```
etablissement (1) ----< (N) etudiant
                            |
                            | (N)
                            |
                        inscription
                            |
                            | (N)
                            |
cours (1) ----< (N) inscription
cours (1) ----< (N) note >---- (N) etudiant
```
