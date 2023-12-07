-- FILEPATH: /e:/PROGRAMMING/PL_SQL/TPS/GI2-PL-SQL/TP4/TP1.sql

CREATE OR REPLACE PROCEDURE ADD_RESERVATION(
    P_VOL_ID IN RESERVATION.VOL_ID%TYPE,
    P_PASSAGER_ID IN RESERVATION.PASSAGER_ID%TYPE,
    P_RESERVATION_DATE IN RESERVATION.RESERVATION_DATE%TYPE
) AS
    V_VOL_EXISTS      NUMBER;
    V_PASSAGER_EXISTS NUMBER;
BEGIN
 -- Verify the existence of the vol
    SELECT
        COUNT(*) INTO V_VOL_EXISTS
    FROM
        VOL
    WHERE
        VOL_ID = P_VOL_ID;
    IF V_VOL_EXISTS = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Vol does not exist');
    END IF;
 -- Verify the existence of the passager
    SELECT
        COUNT(*) INTO V_PASSAGER_EXISTS
    FROM
        PASSAGER
    WHERE
        PASSAGER_ID = P_PASSAGER_ID;
    IF V_PASSAGER_EXISTS = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Passager does not exist');
    END IF;
 -- Validate the reservation date
    IF P_RESERVATION_DATE < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid reservation date');
    END IF;
 -- Insert the reservation
    INSERT INTO RESERVATION (
        VOL_ID,
        PASSAGER_ID,
        RESERVATION_DATE
    ) VALUES (
        P_VOL_ID,
        P_PASSAGER_ID,
        P_RESERVATION_DATE
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
 -- Handle exceptions
        DBMS_OUTPUT.PUT_LINE('Error: '
                             || SQLERRM);
        ROLLBACK;
END;
/