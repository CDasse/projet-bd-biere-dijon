# Requêtes obligatoires

## Prix moyen de la bière par quartier

```
SELECT
    q.nom AS nom_quartier,
    ROUND(AVG(p.valeur),2) AS prix_moyen
FROM beerproject.prix p
INNER JOIN beerproject.bar b ON p.id_bar = b.id_bar
INNER JOIN beerproject.quartier q ON b.id_quartier = q.id_quartier
GROUP BY q.id_quartier
ORDER BY prix_moyen ASC;
```

## Bars vendant l'IPA la moins chère

------`SELECT
MIN (p.valeur) AS prix_IPA_le_plus_bas
FROM beerproject.prix p
INNER JOIN beerproject.biere b ON p.id_biere = b.id_biere
WHERE b.type = 'IPA';`------ FAUX
SELECT
b.nom AS nom_bar,
bi.nom AS nom_biere,
MIN (p.valeur) AS prix_IPA_le_plus_bas
FROM beerproject.prix p
INNER JOIN beerproject.biere bi ON p.id_biere = bi.id_biere
INNER JOIN beerproject.bar b ON p.id_bar = b.id_bar
WHERE bi.type = 'IPA'
GROUP BY bi.id_biere, b.nom;

## Bières vendues dans ≥ 5 bars

```
SELECT
    bi.nom AS nom_biere,
    COUNT(p.id_bar) AS nombre_de_bars
FROM beerproject.prix p
INNER JOIN beerproject.biere bi ON bi.id_biere = p.id_biere
GROUP BY bi.id_biere
HAVING COUNT(p.id_bar) >= 5
ORDER BY nombre_de_bars ASC, bi.nom ASC;
```

## Bars sans bière à moins de 6€

## Top bar avec panier moyen maximum