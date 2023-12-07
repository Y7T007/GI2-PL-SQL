CREATE OR REPLACE FUNCTION HEURES_VOLS 
    (id_pilote INTEGER)
    RETURN INTEGER
IS 

    PIL_INTROUVABLE EXCEPTION;
    nb_heures INTEGER;
    PIL_EXIST INTEGER := 0 ;

    HEURES INTEGER := 0;
    MINUTES INTEGER := 0;
    DUREE_TOTAL FLOAT :=-1;
    DUREE_CONVERTIE INTERVAL DAY TO SECOND;
    
BEGIN

    SELECT COUNT(*) INTO PIL_EXIST FROM YASSIR.PILOTE WHERE ID_PIL = id_pilote;

    IF PIL_EXIST = 0 THEN
        RAISE PIL_INTROUVABLE;
    END IF;


    SELECT HEURE_VOLS INTO nb_heures
        FROM YASSIR.PILOTE
        WHERE ID_PIL = id_pilote;


    RETURN NB_HEURES;

EXCEPTION
    WHEN PIL_INTROUVABLE THEN
        DBMS_OUTPUT.PUT_LINE('Pilote introuvable');
        RETURN NULL;

END;
/


DECLARE
    result INTEGER;
BEGIN
    result := HEURES_VOLS(1);
    DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 1: ' || result);
END;
/

DECLARE
    result INTEGER;
BEGIN
    result := HEURES_VOLS(2);
    DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 2: ' || result);
END;
/

DECLARE
    result INTEGER;
BEGIN
    result := HEURES_VOLS(77);
    IF result IS NOT NULL THEN

        DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 77: ' || result);
    END IF;
END;
/


drop FUNCTION HEURES_VOLS;