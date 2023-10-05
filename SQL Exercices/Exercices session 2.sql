# EXERCICI 1:
"Doneu una sentència SQL per obtenir el número i el nom dels departaments que no tenen cap empleat que visqui a MADRID. Pel joc de proves 
que trobareu al fitxer adjunt, la sortida seria:

NUM_DPT		NOM_DPT
3		MARKETING"

SELECT DISTINCT NUM_DPT, NOM_DPT
FROM DEPARTAMENTS D
WHERE NUM_DPT NOT IN(
    SELECT E.NUM_DPT
    FROM EMPLEATS E
    WHERE E.CIUTAT_EMPL = 'MADRID'
)   
GROUP BY NUM_DPT, NOM_DPT

# EXERCICI 2:
'Doneu una sentència SQL per obtenir les ciutats on hi viuen empleats però no hi ha cap departament. Pel joc de proves que trobareu al fitxer 
adjunt, la sortida seria:

CIUTAT_EMPL
GIRONA'

SELECT DISTINCT CIUTAT_EMPL
FROM EMPLEATS E
WHERE CIUTAT_EMPL NOT IN(
    SELECT CIUTAT_DPT
    FROM DEPARTAMENTS D
)

# EXERCICI 3:
'Doneu una sentència SQL per obtenir el número i nom dels departaments que tenen dos o més empleats que viuen a ciutats diferents. Pel joc de 
proves que trobareu al fitxer adjunt, la sortida seria:

NUM_DPT		NOM_DPT
3		MARKETING'

SELECT NUM_DPT, NOM_DPT
FROM DEPARTAMENTS D
WHERE NUM_DPT IN(
    SELECT E.NUM_DPT
    FROM EMPLEATS E
    GROUP BY E.NUM_DPT
    HAVING COUNT(DISTINCT E.CIUTAT_EMPL) > 1
)

# EXERCICI 4:
"Tenint en compte l'esquema de la BD que s'adjunta, proposeu una sentència de creació de les taules següents: comandes(numComanda, 
instantComanda, client, encarregat, supervisor) productesComprats(numComanda, producte, quantitat, preu)

La taula comandes conté les comandes fetes.
La taula productesComprats conté la informació dels productes comprats a les comandes de la taula comandes.

En la creació de les taules cal que tingueu en compte que:
- No hi poden haver dues comandes amb un mateix número de comanda.
- Un client no pot fer dues comandes en una mateix instant.
- L'encarregat és un empleat que ha d'existir necessariament a la base de dades, i que té sempre tota comanda.
- El supervisor és també un empleat de la base de dades i que s'assigna a algunes comandes en certes circumstàncies.
- No hi pot haver dues vegades un mateix producte en una mateixa comanda. Ja que en cas de el client compri més d'una unitat d'un 
producte en una mateixa comanda s'indica en l'atribut quantitat.
- Un producte sempre s'ha comprat en una comanda que ha d'existir necessariament a la base de dades.
- La quantitat de producte comprat en una comanda no pot ser nul, i té com a valor per defecte 1.
- Els atributs numComanda, instantComanda, quantitat i preu són de tipus integer.
- Els atributs client, producte són char(30), i char(20) respectivament.
- L'atribut instantComanda no pot tenir valors nuls.
Respecteu els noms i l'ordre en què apareixen les columnes (fins i tot dins la clau o claus que calgui definir). Tots els noms s'han 
de posar en majúscules/minúscules com surt a l'enunciat."


CREATE TABLE COMANDES (
    NUMCOMANDA INTEGER,
    INSTANTCOMANDA INTEGER NOT NULL,
    CLIENT CHAR(30),
    ENCARREGAT INTEGER NOT NULL,
    SUPERVISOR INTEGER,
    PRIMARY KEY(NUMCOMANDA),
    FOREIGN KEY(ENCARREGAT) REFERENCES EMPLEATS(NUM_EMPL),
    FOREIGN KEY(SUPERVISOR) REFERENCES EMPLEATS(NUM_EMPL),
    UNIQUE (INSTANTCOMANDA, CLIENT)
);

CREATE TABLE PRODUCTESCOMPRATS (
    NUMCOMANDA INTEGER,
    PRODUCTE CHAR(20),
    QUANTITAT INTEGER DEFAULT 1 NOT NULL,
    PREU INTEGER,
    PRIMARY KEY(NUMCOMANDA, PRODUCTE),
    FOREIGN KEY(NUMCOMANDA) REFERENCES COMANDES(NUMCOMANDA)
);

