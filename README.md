# Inception-Of-Things

## Description

**Inception-Of-Things** est un projet visant à approfondir les connaissances sur **Kubernetes**, en utilisant **K3s**, **K3d** et **Vagrant**.  
Le projet est divisé en **trois parties principales**, chacune centrée sur des aspects spécifiques de la mise en place et de la gestion d’un environnement Kubernetes.

---

## Prérequis

- Un système d’exploitation de type Unix (Linux, macOS…)
- **Docker** et **Docker Compose** installés
- **Kubernetes** installé
- L’outil en ligne de commande **kubectl**
- **Vagrant** installé avec un provider (VirtualBox, libvirt…)
- Des connaissances de base en Docker, Kubernetes

---

## Structure du projet

- **`P1/`** : Mise en place de K3s avec Vagrant
- **`P2/`** : Déploiement de trois applications simples sur K3s
- **`P3/`** : Utilisation de K3d avec déploiement automatisé via Argo CD
- **`bonus/`** : Fonctionnalités supplémentaires avec mise en place de Gitlab en local

---

## Installation

```bash
git clone https://github.com/HarounKr/Inception-Of-Things.git
cd Inception-Of-Things
```

# Projet Kubernetes – Déploiement local avec K3s, K3d, Vagrant et Argo CD

## Partie 1 – K3s + Vagrant

### Objectif
Déployer un cluster Kubernetes local en utilisant **K3s** sur **deux machines virtuelles** via **Vagrant**.

### Infrastructure
- **Machine 1 (Server)** : `192.168.56.110`
- **Machine 2 (ServerWorker)** : `192.168.56.111`

### Configuration
- **K3s installé sur les deux machines**
  - `Server` : rôle **contrôleur** (nœud maître)
  - `ServerWorker` : rôle **agent** (nœud de travail)
- **Installation de `kubectl`** pour interagir avec le cluster depuis la machine hôte ou l'une des VMs.

### Exécution

```bash
cd P1/
bash scripts/run.sh
```
---

## Partie 2 – K3s + 3 Applications

### Objectif
Utiliser **K3s** sur une **seule machine virtuelle** pour héberger plusieurs applications web.

### Configuration
- Installation de **K3s en mode server** via vagrant
- Déploiement de **trois applications web** dans le cluster
- Configuration d’un accès **différencié par virtual host** :
  - Les requêtes HTTP vers `192.168.56.110` sont redirigées vers une application **en fonction du champ `Host`** de la requête (reverse proxy + Ingress).
- **Modification du fichier `/etc/hosts`** sur la machine cliente pour simuler la résolution DNS

### Exécution

```bash
cd P2/
bash scripts/run.sh
```

---

## Partie 3 – K3d + Argo CD

### Objectif
Utiliser **K3d** (Kubernetes dans Docker) et mettre en place une **pipeline CI/CD** avec **Argo CD**.

### Étapes
1. **Installation de `k3d`**
2. **Déploiement de Argo CD**
3. **Création de deux namespaces** :
   - `argocd`
   - `dev`
4. **Déploiement automatique** d’une application dans le namespace `dev` :
   - Depuis un **dépôt GitHub public**
   - Géré via Argo CD (GitOps)

### Exécution

```bash
cd P3/
bash scripts/install.sh
bash scripts/run.sh
```

---

## Partie Bonus – Intégration GitLab

### Objectif
Compléter l’environnement avec une instance locale de **GitLab**, intégrée au cluster Kubernetes.

### Configuration
- **Ajout de GitLab local**
- **Intégration de GitLab** avec le cluster Kubernetes
- **Création d’un namespace dédié** : `gitlab`
- **Vérification de la compatibilité** des fonctionnalités de la Partie 3 avec GitLab :
  - Déploiement via GitLab CI
  - Suivi GitOps via Argo CD ou GitLab Auto DevOps

### Exécution

```bash
cd bonus/
bash argocd_run.sh
gitlab_install.sh
bash clone_repos.sh
```
---

## Ressources Utiles

- [K3s Documentation](https://docs.k3s.io/)
- [K3d Documentation](https://k3d.io/)
- [Argo CD Documentation](https://argo-cd.readthedocs.io/)
- [Vagrant Documentation](https://developer.hashicorp.com/vagrant/docs)
- [Gitlab Helm Chart](https://docs.gitlab.com/charts/installation/deployment/)
