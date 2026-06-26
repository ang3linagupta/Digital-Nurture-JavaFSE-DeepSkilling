CREATE OR REPLACE PACKAGE AccountOperations AS

    PROCEDURE OpenAccount(
        p_AccountID NUMBER,
        p_CustomerID NUMBER,
        p_AccountType VARCHAR2,
        p_Balance NUMBER
    );

    PROCEDURE CloseAccount(
        p_AccountID NUMBER
    );

    FUNCTION GetTotalBalance(
        p_CustomerID NUMBER
    ) RETURN NUMBER;

END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount(
        p_AccountID NUMBER,
        p_CustomerID NUMBER,
        p_AccountType VARCHAR2,
        p_Balance NUMBER
    )
    IS
    BEGIN
        INSERT INTO Accounts
        VALUES(
            p_AccountID,
            p_CustomerID,
            p_AccountType,
            p_Balance,
            SYSDATE
        );

        COMMIT;
    END OpenAccount;

    PROCEDURE CloseAccount(
        p_AccountID NUMBER
    )
    IS
    BEGIN
        DELETE FROM Accounts
        WHERE AccountID = p_AccountID;

        COMMIT;
    END CloseAccount;

    FUNCTION GetTotalBalance(
        p_CustomerID NUMBER
    )
    RETURN NUMBER
    IS
        v_Total NUMBER;
    BEGIN
        SELECT SUM(Balance)
        INTO v_Total
        FROM Accounts
        WHERE CustomerID = p_CustomerID;

        RETURN NVL(v_Total,0);
    END GetTotalBalance;

END AccountOperations;
/