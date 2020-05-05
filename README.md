# Matlab-LiFi
Ce code Matlab / Simulink implémente une modulation QAM DCO-OFDM selon les spécifications de la norme LiFi IEEE802.11bb 
(http://www.ieee802.org/11/Reports/tgbb_update.htm doc. 11-19/1791r2).

## Fichiers
```
Config.m : Script Matlab contenant la configuration de la modulation (nombre de porteuses, espacement...)
ofdm.slx : Script Simulink contenant les blocs fonctionnels de la modulation
```

## Utilisation
1. Ouvrir avec Matlab, modifier si besoin et exécuter `Config.m`
2. Ouvrir avec Simulink et exécuter `ofdm.slx`

## Captures d'écran
![Fichier `ofdm.slx`](https://puu.sh/FGwZj/15b6f1a95a.png)
![Signal de sortie `RF_IN`](https://puu.sh/FGx1J/25c4779169.png)


