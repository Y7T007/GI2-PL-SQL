
/****************************************************
*                PL SQL    - TP 3                   *
*    Les structures de contrôles en PL/SQL          *
*****************************************************
*                                                   *
* NOM: WAHID                                        *
* PRENOM: YASSIR                                    *
* NIVEAU: GI2                                       *
* ENCADRE PAR: Prof. YASSER MASMOUDI                *
*                                                   *
****************************************************/



-- QUESTION 1

DECLARE
    CURSOR AFFICH_VOLS (
        V_VILLE VOL.VILLE_DEPART%TYPE DEFAULT 'CASABLANCA'
    ) 
    IS
        SELECT *
            FROM YASSIR.VOL
            WHERE VILLE_DEPART=V_VILLE;

BEGIN
    FOR VOL IN AFFICH_VOLS LOOP
        DBMS_OUTPUT.PUT_LINE('NUM DU VOL : ' || VOL.ID_VOL);
        DBMS_OUTPUT.PUT_LINE('DATE DEPART : ' || VOL.DATE_DEPART);
        DBMS_OUTPUT.PUT_LINE('DATE ARRIVEE : ' || VOL.DATE_ARRIVEE);
        DBMS_OUTPUT.PUT_LINE('VILLE DEPART : ' || VOL.VILLE_DEPART);
        DBMS_OUTPUT.PUT_LINE('VILLE ARRIVEE : ' || VOL.VILLE_ARRIVEE);
        DBMS_OUTPUT.PUT_LINE('NUM AVION : ' || VOL.N_AVION);
        DBMS_OUTPUT.PUT_LINE('NUM PILOTE : ' || VOL.N_PILOTE);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------'); 
    END LOOP;
END;
/

-- QUESTION 2 : 


DECLARE
    
    CURSOR AFFICH_VOLS_PILOTE (
        NUM_PILOTE YASSIR.VOL.N_PILOTE%TYPE
    ) 
    IS
        SELECT *
            FROM YASSIR.VOL
            WHERE N_PILOTE=NUM_PILOTE;

    TYPE VOL_PIL_TYPE IS TABLE OF YASSIR.VOL%ROWTYPE;
    VOL_PIL VOL_PIL_TYPE;

    NUM_PILOTE YASSIR.VOL.N_PILOTE%TYPE; 

BEGIN

    NUM_PILOTE := '&NUM_PILOTE' ;

    OPEN AFFICH_VOLS_PILOTE(NUM_PILOTE);
    FETCH AFFICH_VOLS_PILOTE BULK COLLECT INTO VOL_PIL;

    FOR I IN 1..VOL_PIL.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('NUM DU VOL : ' || VOL_PIL(I).ID_VOL);
            DBMS_OUTPUT.PUT_LINE('DATE DEPART : ' || VOL_PIL(I).DATE_DEPART);
            DBMS_OUTPUT.PUT_LINE('DATE ARRIVEE : ' || VOL_PIL(I).DATE_ARRIVEE);
            DBMS_OUTPUT.PUT_LINE('VILLE DEPART : ' || VOL_PIL(I).VILLE_DEPART);
            DBMS_OUTPUT.PUT_LINE('VILLE ARRIVEE : ' || VOL_PIL(I).VILLE_ARRIVEE);
            DBMS_OUTPUT.PUT_LINE('NUM AVION : ' || VOL_PIL(I).N_AVION);
            DBMS_OUTPUT.PUT_LINE('NUM PILOTE : ' || VOL_PIL(I).N_PILOTE);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------'); 
    END LOOP;

END;
/

-- QUESTION 3 :

DECLARE
    CURSOR c_VOLS_PLUS_COURT 
    IS
        SELECT *
            FROM YASSIR.VOL
            ORDER BY (DATE_ARRIVEE-DATE_DEPART) 
            FETCH FIRST 1 ROW ONLY ;

    VOL_PLUS_COURT YASSIR.VOL%ROWTYPE;

    HEURES INTEGER;
    MINUTES INTEGER;
    JOURS INTEGER;

    DUREE_TOTAL FLOAT;
    DUREE_CONVERTIE INTERVAL DAY TO SECOND;


BEGIN

    OPEN c_VOLS_PLUS_COURT;

    FETCH c_VOLS_PLUS_COURT INTO VOL_PLUS_COURT;


        DBMS_OUTPUT.PUT_LINE('NUM DU VOL : ' || VOL_PLUS_COURT.ID_VOL);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------'); 
        DBMS_OUTPUT.PUT_LINE('DUREE DU VOL EN JOUR : ' || (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART));
        DBMS_OUTPUT.PUT_LINE('DUREE DU VOL EN HEURES : ' || (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART)*24);
        DBMS_OUTPUT.PUT_LINE('DUREE DU VOL EN MINUTES : ' || (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART)*24*60);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------'); 
        DBMS_OUTPUT.PUT_LINE('DATE DEPART : ' || VOL_PLUS_COURT.DATE_DEPART);
        DBMS_OUTPUT.PUT_LINE('DATE ARRIVEE : ' || VOL_PLUS_COURT.DATE_ARRIVEE);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------'); 
        DBMS_OUTPUT.PUT_LINE('VILLE DEPART : ' || VOL_PLUS_COURT.VILLE_DEPART);
        DBMS_OUTPUT.PUT_LINE('VILLE ARRIVEE : ' || VOL_PLUS_COURT.VILLE_ARRIVEE);
        DBMS_OUTPUT.PUT_LINE('NUM AVION : ' || VOL_PLUS_COURT.N_AVION);
        DBMS_OUTPUT.PUT_LINE('NUM PILOTE : ' || VOL_PLUS_COURT.N_PILOTE);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------'); 

        DUREE_TOTAL := (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART);
        JOURS := TO_NUMBER(DUREE_TOTAL);
        HEURES := TO_NUMBER(DUREE_TOTAL*24);
        MINUTES := (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART)*24*60;

        -- DBMS_OUTPUT.PUT_LINE('J  : ' || DUREE_TOTAL);
        -- DBMS_OUTPUT.PUT_LINE('H  : ' || HEURES);
        -- DBMS_OUTPUT.PUT_LINE('M  : ' || MINUTES);

        DUREE_CONVERTIE := NUMTODSINTERVAL((MINUTES*60), 'SECOND');

        JOURS := EXTRACT(DAY FROM DUREE_CONVERTIE);
        HEURES := EXTRACT(HOUR FROM DUREE_CONVERTIE);
        MINUTES := EXTRACT(MINUTE FROM DUREE_CONVERTIE);

        DBMS_OUTPUT.PUT_LINE('LA DUREE TOTAL DU VOL EST : ''' 
            || MINUTES
            ||''' MINUTES, '''
            || HEURES
            ||''' HEURES, ET '''
            || JOURS
            ||''' JOURS. '''
        
            );


        


END;
/


-- QUESTION 4 : 

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