# Découverte de Docker
*** 

## Prérequis 
* [Virtualbox v6.1](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads)

## Préparation de l'environnement
Clonez le repo :
`git clone https://github.com/avillella05/tp-docker-base.git`

Dans le repertoire **tp-docker-base** :
`vagrant up`

Une fois que la machine est démarrée, il est possible de s'y connecter en SSH : 
`vagrant ssh tp-docker-base`

Connecté sur la machine en SSH, créez un dossier et placez-vous à l’intérieur. Toutes les commandes qui suivront seront lancées depuis ce répertoire.
`mkdir Docker && cd Docker`

## Les bases de Docker :
### Construire une image Nginx


Créez un fichier Dockerfile et ajoutez le contenu suivant : 

```
FROM ubuntu:16.04
RUN apt update \
	&& apt install -yf \
	nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Pour construire notre image nommée monimage :
`docker build -t monimage .`
```
Sending build context to Docker daemon   5.12kB
Step 1/4 : FROM ubuntu:16.04
 ---> 8185511cd5ad
Step 2/4 : RUN apt update       && apt install -yf      nginx
 ---> Using cache
 ---> 2f57c853360d
Step 3/4 : EXPOSE 80
 ---> Using cache
 ---> 4bb8a9e3d455
Step 4/4 : CMD ["nginx", "-g", "daemon off;"]
 ---> Using cache
 ---> d433c8e2ffde
Successfully built d433c8e2ffde
Successfully tagged monimage:latest
```

Une fois que les différentes layers ont été construites, vous devriez retrouver votre image en local :
```
docker image ls
REPOSITORY                   TAG       IMAGE ID       CREATED         SIZE
monimage                     latest    d433c8e2ffde   45 hours ago    219MB
```

### Lancer un conteneur 
`docker run -d monimage`

### Exposer des ports
`docker run -d -p 8000:80 mynginx`

Nous avons exposé le port 8000 de notre host vers le port 80 de notre conteneur.

Vérifions que notre conteneur est bien en écoute :
`curl http://localhost:8000`

```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>

[...]

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

### Créer et monter des volumes
`docker volume create myvolume`

Par défaut, les volumes sont stockés dans /var/lib/docker/volumes/

Il est nécessaire d’être root pour accéder à la sous-arborescence /var/lib/docker
`ls /var/lib/docker/volumes`

```
myvolume metadata.db
```

`cd /var/lib/docker/volumes/myvolume/_data`
`echo "<html> Hello World ! </html>" > index.html`

`docker run -d -p 8001:80 -v myvolume:/var/www/html mynginx`
`curl http://localhost:8001`

```
<html> Hello World ! </html>
```

## Copyright
***
* [Licence : ](https://creativecommons.org/licenses/by-sa/4.0/deed.fr)
* Copyright © 2014-2019 alter way Cloud Consulting.
* Copyright © 2020 particule.
* Depuis 2020, tous les commits sont la propriété de leurs auteurs respectifs.