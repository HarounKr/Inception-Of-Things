if [ ! -d "app" ]; then
    # Depot de l'app sur le gitab local
    git clone http://gitlab.k3d.local:9191/root/app.git
    # Depot de l'app sur le github perso
    git clone git@github.com:HarounKr/hkrifa-app.git

    mv hkrifa-app/manifests ./app
    # cd app/
    # # Ajoute les fichiers au dépôt, crée un commit, et pousse les modifications
    # git add .
    # git commit -m "first push"
    # git push
else
    echo "Folder app exist"
fi
