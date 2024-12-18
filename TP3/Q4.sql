DECLARE
    CURSOR C_PIL 
    IS
        SELECT N_PILOTE, SUM(DATE_ARRIVEE - DATE_DEPART) AS DUREE
        FROM YASSIR.VOL
        GROUP BY N_PILOTE;

    HEURES INTEGER := 0;
    MINUTES INTEGER := 0;

    DUREE_TOTAL FLOAT;
    DUREE_CONVERTIE INTERVAL DAY TO SECOND;

BEGIN
    FOR PIL IN C_PIL LOOP 
        MINUTES := (PIL.DUREE) * 24 * 60;
        DUREE_CONVERTIE := NUMTODSINTERVAL((MINUTES * 60), 'SECOND');
        HEURES := EXTRACT(HOUR FROM DUREE_CONVERTIE);

        UPDATE YASSIR.PILOTE
        SET HEURE_VOLS = HEURES
        WHERE ID_PIL = PIL.N_PILOTE;
    END LOOP;
    

END;
/

ROLLBACK
