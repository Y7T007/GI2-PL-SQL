
/****************************************************
*                PL SQL    - TP 4                   *
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


-- QUESTION 2 : 
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

-- Test case 1: Valid input with a positive TAUX and existing PILOTE ID
DECLARE
    taux FLOAT := 0.2;
    pilote YASSIR.PILOTE.ID_PIL%TYPE := 1;
BEGIN
    PRIME(taux, pilote);
END;
/

-- Test case 2: Valid input with TAUX equal to 0 and existing PILOTE ID
DECLARE
    taux FLOAT := 0;
    pilote YASSIR.PILOTE.ID_PIL%TYPE := 2;
BEGIN
    PRIME(taux, pilote);
END;
/

-- Test case 3: Valid input with TAUX equal to 0.4 (maximum allowed) and existing PILOTE ID
DECLARE
    taux FLOAT := 0.4;
    pilote YASSIR.PILOTE.ID_PIL%TYPE := 3;
BEGIN
    PRIME(taux, pilote);
END;
/

-- Test case 4: Invalid input with TAUX less than 0 and existing PILOTE ID
DECLARE
    taux FLOAT := -0.1;
    pilote YASSIR.PILOTE.ID_PIL%TYPE := 4;
BEGIN
    PRIME(taux, pilote);
END;
/

-- Test case 5: Invalid input with TAUX greater than 0.4 and existing PILOTE ID
DECLARE
    taux FLOAT := 0.5;
    pilote YASSIR.PILOTE.ID_PIL%TYPE := 5;
BEGIN
    PRIME(taux, pilote);
END;
/

-- Test case 6: Invalid input with non-existing PILOTE ID
DECLARE
    taux FLOAT := 0.2;
    pilote YASSIR.PILOTE.ID_PIL%TYPE := 100;
BEGIN
    PRIME(taux, pilote);
END;
/



-- QUESTION 3 :
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

-- QUESTION 4 : 

DECLARE
CREATE OR REPLACE TRIGGER limite_affect_vol_pil
BEFORE INSERT OR UPDATE ON YASSIR.vol
FOR EACH ROW
DECLARE
    NB_VOL_PIL NUMBER := 0;
BEGIN
    SELECT COUNT(*) 
    INTO NB_VOL_PIL
    FROM YASSIR.VOL
    WHERE N_PILOTE = :NEW.N_PILOTE
    AND :NEW.DATE_DEPART >= NEXT_DAY(TRUNC(SYSDATE) - 7, 'MONDAY')
    AND :NEW.DATE_DEPART < NEXT_DAY(TRUNC(SYSDATE), 'MONDAY');

    IF NB_VOL_PIL >= 4 THEN

        EXECUTE IMMEDIATE 'CREATE TABLE YASSIR.ARCHIVS_VOL (
            UTILISATEUR VARCHAR2(30),
            DATE DATE,
            ID_PILOTE NUMBER,
            DATE_DEPART DATE)' ;

        INSERT INTO YASSIR.ARCHIVS_VOL (UTILISATEUR, DATE, ID_PILOTE, DATE_DEPART)
        VALUES (USER, SYSDATE, :NEW.N_PILOTE, :NEW.DATE_DEPART);
    END IF;

END;
/

DROP TRIGGER limite_affect_vol_pil;
