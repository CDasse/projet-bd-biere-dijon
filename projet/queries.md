# Requêtes obligatoires

## Prix moyen de la bière par quartier

```
SELECT
    q.nom AS nom_quartier,
    ROUND(AVG(p.valeur),2) AS prix_moyen_biere
FROM beerproject.prix p
INNER JOIN beerproject.bar b ON p.id_bar = b.id_bar
INNER JOIN beerproject.quartier q ON b.id_quartier = q.id_quartier
GROUP BY q.nom
ORDER BY prix_moyen_biere ASC;
```

## Bars vendant l'IPA la moins chère

```
SELECT
    b.nom AS nom_bar,
    bi.nom AS nom_biere,
    MIN (p.valeur) AS prix_IPA_le_plus_bas
FROM beerproject.prix p
INNER JOIN beerproject.biere bi ON p.id_biere = bi.id_biere
INNER JOIN beerproject.bar b ON p.id_bar = b.id_bar
WHERE bi.type = 'IPA'
GROUP BY b.nom, bi.nom
ORDER BY prix_IPA_le_plus_bas ASC
LIMIT 1;
```

## Bières vendues dans ≥ 5 bars

```
SELECT
    bi.nom AS nom_biere,
    COUNT(p.id_bar) AS nombre_de_bars
FROM beerproject.prix p
INNER JOIN beerproject.biere bi ON p.id_biere = bi.id_biere
GROUP BY bi.nom
HAVING COUNT(p.id_bar) >= 5
ORDER BY nombre_de_bars ASC, bi.nom ASC;
```

## Bars sans bière à moins de 6€

```
SELECT
    b.nom AS bars_prix_supp_6_euro
FROM beerproject.bar b
INNER JOIN beerproject.prix p ON b.id_bar = p.id_bar
GROUP BY b.nom
HAVING MIN(p.valeur) >= 6
ORDER BY b.nom ASC;
```

## Top bar avec panier moyen maximum

> 💡 **Important** : Affichage du top 3.

```
SELECT
    b.nom AS nom_bar,
    ROUND(AVG(p.valeur),2) AS panier_moyen
FROM beerproject.bar b
INNER JOIN beerproject.prix p ON b.id_bar = p.id_bar
GROUP BY b.nom
ORDER BY panier_moyen DESC
LIMIT 3;
```