# Vérificateur de Dépendances Node.js

Script bash automatisé pour surveiller les dépendances Node.js de plusieurs projets et envoyer des rapports par email.

## Fonctionnalités

- Analyse tous les projets Node.js dans un répertoire spécifié
- Vérifie les packages obsolètes
- Effectue un audit de sécurité
- Envoie des rapports formatés par email
- Planning configurable via cron

## Installation

1. Cloner le dépôt
```bash
git clone https://github.com/Paul-Jeanroy/nodejs-dependencies-checker.git
```

2. Installer les packages requis
```bash
apt install mailutils jq
```

3. Configurer l'email dans le script
```bash
nano check-dependencies.sh
# Mettre à jour la variable EMAIL
```

4. Configurer le cron
```bash
crontab -e
# Ajouter : 0 0 * * 1 /chemin/vers/check-dependencies.sh
```

## Utilisation

Exécution manuelle :
```bash
./check-dependencies.sh
```
