/*Scenario 1*/

CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from NUMBER,
    p_to NUMBER,
    p_amount NUMBER
)
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID=p_from;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(
        -20001,
        'Insufficient Funds');
    END IF;

    UPDATE Accounts
    SET Balance=Balance-p_amount
    WHERE AccountID=p_from;

    UPDATE Accounts
    SET Balance=Balance+p_amount
    WHERE AccountID=p_to;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO ErrorLog
        (ErrorMessage,ErrorDate)
        VALUES
        (SQLERRM,SYSDATE);

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

/*Scenario 2*/

CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_empid NUMBER,
    p_percent NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary=
        Salary+(Salary*p_percent/100)
    WHERE EmployeeID=p_empid;

    IF SQL%ROWCOUNT=0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO ErrorLog
        (ErrorMessage,ErrorDate)
        VALUES
        ('Employee Not Found',
        SYSDATE);
END;
/

/*Scenario 3*/

CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_id NUMBER,
    p_name VARCHAR2,
    p_dob DATE,
    p_balance NUMBER
)
IS
BEGIN
    INSERT INTO Customers
    VALUES
    (p_id,p_name,p_dob,
    p_balance,SYSDATE,
    'FALSE');

    COMMIT;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        INSERT INTO ErrorLog
        (ErrorMessage,ErrorDate)
        VALUES
        ('Customer Already Exists',
        SYSDATE);
END;
/