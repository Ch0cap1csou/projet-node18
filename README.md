# CI/CD Pipeline – Node.js, Docker Hub et Trivy

Ce projet utilise GitHub Actions pour automatiser les tests, la construction d’une image Docker, sa publication sur Docker Hub et l’analyse de sécurité avec Trivy.

## Déclencheurs

La pipeline s’exécute automatiquement lors d’un push sur la branche `main` et lors d’une pull request vers `main`.

## Architecture de la chaîne CI/CD

### 1. Job test  
Ce job vérifie la qualité du code avant toute étape de build.  
Il exécute les actions suivantes :  
- Récupération du code source  
- Installation de Node.js 18  
- Installation des dépendances avec `npm ci`  
- Exécution des tests avec `npm test`  

Si les tests échouent, la pipeline s’arrête.

### 2. Job build-and-push  
Ce job dépend du job `test` et ne s’exécute que lors d’un push sur `main`.  
Il réalise les opérations suivantes :  
- Configuration de Docker Buildx  
- Génération du nom d’image Docker  
- Connexion à Docker Hub  
- Construction de l’image Docker avec deux tags : `latest` et le SHA du commit  
- Publication de l’image sur Docker Hub  

L’image est publiée sous la forme :  
`docker.io/<username>/myapp`

### 3. Job trivy-scan  
Ce job dépend de `build-and-push`.  
Il analyse l’image Docker publiée à l’aide de Trivy.  
Le scan recherche les vulnérabilités de sévérité HIGH et CRITICAL.  
Le paramètre `exit-code: 0` permet de ne pas bloquer la pipeline même si des vulnérabilités sont détectées.

## Résumé du flux CI/CD

1. Tests Node.js  
2. Build Docker et push sur Docker Hub  
3. Analyse de sécurité Trivy  

Cette chaîne garantit la qualité du code, la reproductibilité via Docker et une visibilité sur les vulnérabilités de sécurité.
