-- QUESTION 4 :

SET SERVEROUTPUT ON;

DECLARE
    SOMME_SALAIRES1 NUMBER := 0 ;
    SOMME_SALAIRES2 NUMBER := 0 ;
BEGIN
    SELECT SUM(SALAIRE)
        INTO SOMME_SALAIRES1
        FROM PILOTE WHERE AGE > 40;
    DBMS_OUTPUT.PUT_LINE('LA SOMME DES SALAIRES PAR SELECTION EST : ' || SOMME_SALAIRES1);

    FOR PILOTE IN (SELECT * FROM PILOTE) LOOP
        IF PILOTE.AGE > 40 THEN
            SOMME_SALAIRES2 := SOMME_SALAIRES2 + PILOTE.SALAIRE;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('LA SOMME DES SALAIRES PAR LOOP FOR EST : ' || SOMME_SALAIRES2);


END;
/
