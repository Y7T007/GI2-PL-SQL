DECLARE
    CURSOR c_VOLS_PLUS_COURT 
    IS
        SELECT *
            FROM YASSIR.VOL
            ORDER BY (DATE_ARRIVEE-DATE_DEPART)
            FETCH FIRST 1 ROW ONLY ;

    VOL_PLUS_COURT YASSIR.VOL%ROWTYPE;

BEGIN

    OPEN c_VOLS_PLUS_COURT;

    FETCH c_VOLS_PLUS_COURT INTO VOL_PLUS_COURT;

        DBMS_OUTPUT.PUT_LINE('NUM DU VOL : ' || VOL_PLUS_COURT.ID_VOL);
        DBMS_OUTPUT.PUT_LINE('DUREE DU VOL EN JOUR : ' || (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART));
        DBMS_OUTPUT.PUT_LINE('DUREE DU VOL EN HEURES : ' || (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART)*24);
        DBMS_OUTPUT.PUT_LINE('DUREE DU VOL EN MINUTES : ' || (VOL_PLUS_COURT.DATE_ARRIVEE-VOL_PLUS_COURT.DATE_DEPART)*24*60);
        DBMS_OUTPUT.PUT_LINE('DATE DEPART : ' || VOL_PLUS_COURT.DATE_DEPART);
        DBMS_OUTPUT.PUT_LINE('DATE ARRIVEE : ' || VOL_PLUS_COURT.DATE_ARRIVEE);
        DBMS_OUTPUT.PUT_LINE('VILLE DEPART : ' || VOL_PLUS_COURT.VILLE_DEPART);
        DBMS_OUTPUT.PUT_LINE('VILLE ARRIVEE : ' || VOL_PLUS_COURT.VILLE_ARRIVEE);
        DBMS_OUTPUT.PUT_LINE('NUM AVION : ' || VOL_PLUS_COURT.N_AVION);
        DBMS_OUTPUT.PUT_LINE('NUM PILOTE : ' || VOL_PLUS_COURT.N_PILOTE);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------'); 

END;
/