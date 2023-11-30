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