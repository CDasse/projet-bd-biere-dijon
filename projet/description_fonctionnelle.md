# Description fonctionnelle

L’objectif de la base de données est de gérer les bars, les bières qu’ils proposent et les prix pratiqués dans chaque quartier de Dijon.

## Les entités principales avec leurs attributs

### Quartiers

Ils représentent un secteur géographique de la ville.

Attributs :

* id_quartier : identifiant unique

* nom : nom du quartier

### Bars

Ils représentent un établissement qui vend des bières.

Attributs :

* id_bar : identifiant unique

* nom : nom de l'établissement

* adresse : adresse postale complète

### Bières

Elles représentent les boissons vendues dans un ou plusieurs bars.

Attributs :

* id_biere : identifiant unique

* nom : nom de la boisson

* type : type de bière (Lager, IPA, Stout…)

* degres : degrés d’alcool


### Table_de_prix

Table associative entre "bar" et "bière", qui contient les prix définis par chaque bar.

Attributs :

* id_prix : référence du prix

* prix : prix de vente TTC


## Les relations

### QUARTIER 1 — N BAR

Un quartier peut contenir plusieurs bars.

Un bar appartient à un seul quartier.

### BAR N — N BIERE

Un bar peut proposer plusieurs bières.

Une bière peut être vendue dans différents bars.


### BAR 1 — N PRIX

Un bar peut proposer plusieurs prix.

Un prix est unique pour un boisson donnée dans un bar.

### BIERE 1 — N PRIX

Une bière peut voir des prix différents en fonction du lieu de vente.


## Les règles métier

* Un bar appartient à un seul quartier, mais un quartier peut accueillir plusieurs bars ;

* Un bar peut vendre plusieurs bières et une bière peut être vendue dans plusieurs bars ;

* Un bar peut définir un prix distinct pour chaque bière, mais ne peux pas définir plusieurs prix pour une même bière ;

* Un prix et le degré d'alcool doivent être strictement positifs ;

* Un bar ne peut pas exister sans nom ou adresse ;

* Une bière ne peut pas exister sans nom ;

* Un quartier ne peut pas exister sans nom ;

* Deux bières ne peuvent pas avoir strictement le même nom ;

* Une adresse est unique à un bar.