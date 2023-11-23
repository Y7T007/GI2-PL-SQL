
-- QUESTION 1 -A

DECLARE
    TYPE RECORD_DE_PILOTE IS RECORD(
        ID_PIL INTEGER,
        NOM VARCHAR2(50),
        AGE INTEGER,
        VILLE VARCHAR2(25),
        SALAIRE INTEGER,
        HEURE_VOLS INTEGER
    );
    TYPE TABLE_DE_PILOTES IS
        TABLE OF RECORD_DE_PILOTE INDEX BY PLS_INTEGER;

    PILOTES TABLE_DE_PILOTES;

    NB_PILOTES INTEGER;

BEGIN

    PILOTES(1).ID_PIL:=1;
    PILOTES(1).NOM:='YASSIR';
    PILOTES(1).AGE:=21;
    PILOTES(1).VILLE:='CASABLANCA';
    PILOTES(1).SALAIRE:=15000;
    PILOTES(1).HEURE_VOLS:=150;

    PILOTES(2).ID_PIL:=12;
    PILOTES(2).NOM:='NOM 12';
    PILOTES(2).AGE:=12;
    PILOTES(2).VILLE:='VILLE 12';
    PILOTES(2).SALAIRE:=12;
    PILOTES(2).HEURE_VOLS:=12;

    PILOTES(3).ID_PIL:=3;
    PILOTES(3).NOM:='NOM 3';
    PILOTES(3).AGE:=3;
    PILOTES(3).VILLE:='VILLE 3';
    PILOTES(3).SALAIRE:=3;
    PILOTES(3).HEURE_VOLS:=3;

    PILOTES(4).ID_PIL:=4;
    PILOTES(4).NOM:='NOM 4';
    PILOTES(4).AGE:=4;
    PILOTES(4).VILLE:='VILLE 4';
    PILOTES(4).SALAIRE:=4;
    PILOTES(4).HEURE_VOLS:=4;

    PILOTES(5).ID_PIL:=5;
    PILOTES(5).NOM:='NOM 5';
    PILOTES(5).AGE:=5;
    PILOTES(5).VILLE:='VILLE 5';
    PILOTES(5).SALAIRE:=5;
    PILOTES(5).HEURE_VOLS:=5;

    -- AFFICHAGE DES RESULTATS:
    FOR I IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('NOM : '||PILOTES(I).NOM);
    END LOOP;

    -- AFFICHAGE DES NOMBRES DE PILOTES :
    NB_PILOTES:= PILOTES.COUNT;
    DBMS_OUTPUT.PUT_LINE('LE NOMBRE TOTALE DES PILOTES EST : '||NB_PILOTES);

END;
/