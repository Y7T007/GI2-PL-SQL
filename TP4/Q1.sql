create or replace PROCEDURE add_reservation (
        res_passager YASSIR.PASSAGER.ID_PAS%TYPE,
        res_vol YASSIR.VOL.ID_VOL%TYPE ,
        res_date YASSIR.VOL.DATE_DEPART%TYPE 
    )
IS
    Erreur_ajout_vol EXCEPTION;
    passager_count NUMBER;
    VOL_COUNT NUMBER;
    RESERVATION_COUNT NUMBER;
    BEGIN
        SELECT COUNT(*) INTO passager_count FROM YASSIR.PASSAGER WHERE ID_PAS = res_passager;
        SELECT COUNT(*) INTO VOL_COUNT FROM YASSIR.VOL WHERE ID_VOL = res_vol;
        SELECT COUNT(*) INTO RESERVATION_COUNT FROM YASSIR.RESERVATION  WHERE N_PASSAGER = res_passager AND N_VOL = res_vol;

                IF passager_count > 0
                    AND VOL_COUNT > 0
                    AND RESERVATION_COUNT = 0 
                THEN
                    INSERT INTO YASSIR.RESERVATION (N_PASSAGER, N_VOL, DATE_RES) VALUES (res_passager, res_vol, res_date);
                ELSE
                    Raise Erreur_ajout_vol;
                END IF;

            EXCEPTION
                WHEN Erreur_ajout_vol THEN
                    DBMS_OUTPUT.PUT_LINE('Erreur lors de l''ajout de la reservation');
    END;
    /
