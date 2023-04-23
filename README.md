# Parallel Prime Finder
## Contexte
Ce programme a ete realise pour un projet scolaire. L'objectif du programme est de trouver les nombres premiers dans un intervalle.

Pour cela, le programme crée un **pool de workers**, et le processus master gere l'attribution des taches.

## Composition
Le programme est compile a partir de plusieurs fichiers :
- `search_primes.h` contient un ensemble de fonctions dédiées aux workers ainsi que des constantes permettant de jouer sur l'affichage des étapes, le nombre de workers, etc.
- `utils.h` contient un ensemble de fonctions utilitaires generales (min, max, tri, etc).
- `main.c` contient le derouelement general du programme, avec le code associe au processus master.


## Utilisation du Makefile

Le Makefile est fait de facon a gerer toutes les interactions avec les fichiers et le programme avant qu'il soit lance.
Vous pourrez donc remarquez que la majorite de ces indications sont dirigees sur les actions decrites dans ce Makefile.


### Aide :
    $ make help
        Affiche ce fichier README dans le terminal a l'aide de la commande more.

### Compilation :
    $ make
        S'occupe de compiler et assembler tous les fichiers sources (.c) puis de les regrouper dans le programme final.

### Execution :
    $ make run
        Execute le programme. S'il n'existe pas ou s'il n'est pas a jour, il sera d'abord compile.

### Sauvegarde :
    $ make save
        Force la copie des fichiers sources (.c et .h) dans le dossier de Backup vider ce dernier au prealable.

    $ make savePurge
        Supprime le dossier de sauvegarde avant d'en creer un neuf, les fichiers qui s'y trouvaient n'y seront plus.
        La sauvegarde est ensuite effectuee normalement. Utile pour remettre a jour l'integralite de la sauvegarde.

### Restauration :
    $ make restore
        Force la restauration des fichiers sources existants dans le dossier de Backup.
        Les autres fichiers sources du dossier sources qui n'etaient pas dans la sauvegarde sont intacts.

    $ make restorePurge
        Supprime tous les fichiers sources du dossier sources avant de proceder a la restauration usuelle.
        Utile pour repartir d'une sauvegarde en abandonnant toute progression.

### Nettoyage :
    $ make clean
        Supprime tous les fichiers .o des binaries, le programme lui meme, ainsi que la documentation.
        Pour revenir a un espace propre sans impacter les sauvegardes ou la progression dans les sources.

### Rendu Semi-Automatique :
    $ make give
        Cree un dossier temporaire ($USERNAME-$PROJECT_NAME) contenant tous les fichiers a rendre, et une arborescence propre.
        En fait ensuite une archive .tgz avant de supprimer ce dossier temporaire.