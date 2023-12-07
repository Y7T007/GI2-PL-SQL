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