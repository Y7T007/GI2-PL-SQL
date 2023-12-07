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
    result := HEURES_VOLS(100);
    DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 100: ' || result);
END;
/