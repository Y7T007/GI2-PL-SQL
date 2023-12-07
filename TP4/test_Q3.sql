-- Test case 1: Valid pilote ID with non-zero flight hours
DECLARE
    result INTEGER;
BEGIN
    result := HEURES_VOLS(1);
    DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 1: ' || result);
END;
/

-- Test case 2: Valid pilote ID with zero flight hours
DECLARE
    result INTEGER;
BEGIN
    result := HEURES_VOLS(2);
    DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 2: ' || result);
END;
/

-- Test case 3: Invalid pilote ID
DECLARE
    result INTEGER;
BEGIN
    result := HEURES_VOLS(100);
    DBMS_OUTPUT.PUT_LINE('Flight hours for pilote ID 100: ' || result);
END;
/