-- QUESTION 4 :

DECLARE
-- 4-a)
    V_NUM YASSIR.VOL.ID_VOL%TYPE;
    V_VILLE YASSIR.VOL.VILLE_DEPART%TYPE;
    V_HEURE_D YASSIR.VOL.DATE_DEPART%TYPE;

-- 4-b)
    TYPE TYPE_VOL_RECORD IS RECORD(
        V_NUM 
    )

    VOL_SELECTIONNE VARCHAR2(10);
BEGIN

    VOL_SELECTIONNE:= '&NUMERO_DU_VOL';
    -- SCANNER LE NUM DU VOL :
    DBMS_OUTPUT.PUT_LINE('NUM CHOISIT EST : '||VOL_SELECTIONNE);

    SELECT ID_VOL, DATE_DEPART, VILLE_DEPART
    INTO V_NUM, V_HEURE_D, V_VILLE    
    FROM VOL
    WHERE ID_VOL= VOL_SELECTIONNE;

    DBMS_OUTPUT.PUT_LINE('NUMERO DU VOL : '
        ||V_NUM
        ||' VILLE DE DEPART : '
        ||V_VILLE
        ||' HEURE VOLS : '
        ||V_HEURE_D
    );


END;
/