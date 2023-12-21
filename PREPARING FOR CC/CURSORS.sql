
DECLARE
    result INTEGER;
BEGIN
    result := HEURES_VOLS(1);
    DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 1: ' || result);
END;
/
