SET SERVEROUTPUT ON;

DECLARE
    CURSOR C_PILOTES_UPDATE IS
        SELECT
            *
        FROM
            PILOTE
        WHERE
            SALAIRE < (
                SELECT
                    AVG(SALAIRE)
                FROM
                    PILOTE
            ) FOR UPDATE;

    TYPE TYPE_TABLE_PILOTES IS
        TABLE OF PILOTE%ROWTYPE;

    TABLE_PILOTES TYPE_TABLE_PILOTES;

BEGIN

    FOR PILOTE IN C_PILOTES_UPDATE LOOP

    -- QUESTION 2 - A :
        UPDATE PILOTE
        SET
            SALAIRE = SALAIRE + SALAIRE * 0.2
        WHERE
            CURRENT OF C_PILOTES_UPDATE;

    -- QUESTION 2 - B :
        IF C_PILOTES_UPDATE%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NOM PILOTE: '
                                || PILOTE.NOM
                                || ', SALAIRE: '
                                || PILOTE.SALAIRE);
        END IF;

    END LOOP;
    
END;
/