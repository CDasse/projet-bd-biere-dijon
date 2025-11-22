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

## Bières vendues dans ≥ 5 bars

## Bars sans bière à moins de 6€

## Top bar avec panier moyen maximum