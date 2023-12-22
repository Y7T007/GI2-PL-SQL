DECLARE
    PILOTE YASSIR.PILOTE%ROWTYPE;
    TYPE PIL_TABLE IS TABLE OF YASSIR.PILOTE%ROWTYPE INDEX BY BINARY_INTEGER;
    TABLE_PILOTES PIL_TABLE;
    NB_PILOTES INTEGER ;
begin

    TABLE_PILOTES(0).ID_PIL :=5;
    TABLE_PILOTES(0).NOM :='YASSIR';
    TABLE_PILOTES(0).AGE := 23 ;
    TABLE_PILOTES(0).VILLE :='CASABLANCA';
    TABLE_PILOTES(0).SALAIRE := 23000 ;
    TABLE_PILOTES(0).HEURE_VOLS := 230 ;

    TABLE_PILOTES(1).ID_PIL :=6;
    TABLE_PILOTES(1).NOM :='WAHID';
    TABLE_PILOTES(1).AGE := 23 ;
    TABLE_PILOTES(1).VILLE :='TETOUAN';
    TABLE_PILOTES(1).SALAIRE := 23000 ;
    TABLE_PILOTES(1).HEURE_VOLS := 250 ;
    

    FOR I IN 0..(TABLE_PILOTES.COUNT-1) LOOP
        DBMS_OUTPUT.PUT_LINE(' PILOTE : '||TABLE_PILOTES(I).NOM );
    END LOOP;

end;
/

DECLARE
    V_NUM INTEGER;
    V_VILLE VARCHAR2(100);
    V_HEURES INTEGER;
BEGIN

    V_NUM :='&NUM_VOL';
END;
/