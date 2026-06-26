/*Scenario 1*/

CREATE OR REPLACE PROCEDURE
ProcessMonthlyInterest
IS
BEGIN
    UPDATE Accounts
    SET Balance=
        Balance+(Balance*0.01)
    WHERE AccountType='Savings';

    COMMIT;
END;
/

/*Scenario 2*/

CREATE OR REPLACE PROCEDURE
UpdateEmployeeBonus(
    p_department VARCHAR2,
    p_bonus NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary=
        Salary+(Salary*p_bonus/100)
    WHERE Department=
          p_department;

    COMMIT;
END;
/

/*Scenario 3*/

CREATE OR REPLACE PROCEDURE
TransferFunds(
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
        DBMS_OUTPUT.PUT_LINE(
        'Insufficient Balance');
    ELSE
        UPDATE Accounts
        SET Balance=
            Balance-p_amount
        WHERE AccountID=p_from;

        UPDATE Accounts
        SET Balance=
            Balance+p_amount
        WHERE AccountID=p_to;

        COMMIT;
    END IF;
END;
/
