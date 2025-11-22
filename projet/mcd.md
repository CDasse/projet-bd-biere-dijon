# MCD (Modèle Conceptuel de Données)

## Code du MCD

```
erDiagram
direction TB

    Quartier {
        int id_quartier
        string nom
    }

	Bar {
		int id_bar
		string nom
		string adresse
	}

	Bière {
		int id_biere
		string nom
		int degre
		string type
	}

	Prix {
		int id_prix
		int valeur 
	}

	Quartier||--o{Bar:"1..N accueil / se trouve"
	Bar}o--o{Bière:"N..N propose / est vendue"
	Bière||--o{Prix:"1..N coûte"
	Bar||--o{Prix:"1..N propose"
```

## Schéma du MCD
![Diagramme MCD](mcd.png)