create or replace PROCEDURE add_reservation (
        res_passager YASSIR.PASSAGER.ID_PAS%TYPE,
        res_vol YASSIR.VOL.ID_VOL%TYPE ,
        res_date YASSIR.VOL.DATE_DEPART%TYPE 
    )
IS
    BEGIN
        SELECT COUNT(*) INTO passager_count FROM YASSIR.PASSAGER WHERE ID_PAS = res_passager;

                IF passager_count > 0
                    AND (SELECT COUNT(*) FROM YASSIR.VOL WHERE ID_VOL = res_vol) > 0
                    AND (SELECT COUNT(*) FROM YASSIR.VOL WHERE ID_VOL = res_vol AND DATE_DEPART > res_date) > SYSDATE
                    AND (SELECT COUNT(*) FROM YASSIR.RESERVATION WHERE ID_PAS = res_passager AND ID_VOL = res_vol) = 0 
                THEN
                    INSERT INTO YASSIR.RESERVATION (ID_PAS, ID_VOL, DATE_RESERVATION) VALUES (res_passager, res_vol, res_date);
                ELSE
                    Raise Erreur_ajout_vol;
                END IF;

            EXCEPTION
                WHEN Erreur_ajout_vol THEN
                    DBMS_OUTPUT.PUT_LINE('Erreur lors de l''ajout de la reservation');
    END;
    /
END;
/