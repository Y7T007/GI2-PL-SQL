-- Declare a table type with a user-defined record
CREATE TYPE EmployeeRecordType AS OBJECT (
  EmployeeID   NUMBER,
  FirstName    VARCHAR2(50),
  LastName     VARCHAR2(50),
  Salary       NUMBER
);

-- Declare a table type of the record type
CREATE TYPE EmployeeTableType AS TABLE OF EmployeeRecordType;

-- Declare a variable of the table type
employees_table EmployeeTableType;

-- Populate the table with records
BEGIN
  employees_table := EmployeeTableType(
    EmployeeRecordType(101, 'John', 'Doe', 50000),
    EmployeeRecordType(102, 'Jane', 'Smith', 60000),
    EmployeeRecordType(103, 'Bob', 'Johnson', 55000)
  );

  -- Display the values using index
  FOR i IN employees_table.FIRST .. employees_table.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employees_table(i).EmployeeID);
    DBMS_OUTPUT.PUT_LINE('Name: ' || employees_table(i).FirstName || ' ' || employees_table(i).LastName);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || employees_table(i).Salary);
    DBMS_OUTPUT.PUT_LINE('---');
  END LOOP;
END;
/



-- Declare a table type with a user-defined record
CREATE TYPE EmployeeRecordType AS OBJECT (
  EmployeeID   NUMBER,
  FirstName    VARCHAR2(50),
  LastName     VARCHAR2(50),
  Salary       NUMBER
);

-- Declare a table type of the record type
CREATE TYPE EmployeeTableType AS TABLE OF EmployeeRecordType;

-- Declare a variable of the table type
employees_table EmployeeTableType;

-- Populate the table with records
BEGIN
  employees_table := EmployeeTableType(
    EmployeeRecordType(101, 'John', 'Doe', 50000),
    EmployeeRecordType(102, 'Jane', 'Smith', 60000),
    EmployeeRecordType(103, 'Bob', 'Johnson', 55000)
  );

  -- Display the values using index
  FOR i IN employees_table.FIRST .. employees_table.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employees_table(i).EmployeeID);
    DBMS_OUTPUT.PUT_LINE('Name: ' || employees_table(i).FirstName || ' ' || employees_table(i).LastName);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || employees_table(i).Salary);
    DBMS_OUTPUT.PUT_LINE('---');
  END LOOP;
END;
/


