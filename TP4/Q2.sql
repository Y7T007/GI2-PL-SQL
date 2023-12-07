DROP PROCEDURE PRIME;

CREATE OR REPLACE PROCEDURE PRIME
    (
        TAUX FLOAT ,
        PILOTE YASSIR.PILOTE.ID_PIL%TYPE
    )
IS
    taux_invalide EXCEPTION;
    PILOTE_INTROUVALBE EXCEPTION;
    nb_pil INTEGER;
    NOUV_SALAIRE NUMBER;

    BEGIN 
        IF TAUX < 0 OR TAUX > 0.4 THEN
            RAISE taux_invalide;
        END IF;

        SELECT COUNT(*) into nb_pil FROM YASSIR.PILOTE WHERE ID_PIL = ID_PIL ;

        IF nb_pil =0 THEN
            RAISE PILOTE_INTROUVALBE;
        END IF;

        UPDATE YASSIR.PILOTE SET SALAIRE = SALAIRE + (SALAIRE * TAUX) WHERE ID_PIL = PILOTE;

        SELECT SALAIRE INTO NOUV_SALAIRE FROM YASSIR.PILOTE WHERE ID_PIL = PILOTE;

        DBMS_OUTPUT.PUT_LINE('LE NOUVEAU SALAIRE EST : '|| NOUV_SALAIRE);

        EXCEPTION
            WHEN taux_invalide THEN
                
                UPDATE YASSIR.PILOTE SET SALAIRE = SALAIRE + (SALAIRE * 0.4) WHERE ID_PIL = PILOTE;

                DBMS_OUTPUT.PUT_LINE('LE TAUX QUE VOUS AVEZ SAISSI EST INVALIDE, VEUILLER SAISIR UN TAUX ENTRE 0% ET 40%');
            WHEN PILOTE_INTROUVALBE THEN
                DBMS_OUTPUT.PUT_LINE('PILOTE INTROUVALBE, VEUILLEZ VERIFIEZ UNE AUTRE FOIS QUE L''ID DU PILOTE EST CORRECTE');
END;
/

