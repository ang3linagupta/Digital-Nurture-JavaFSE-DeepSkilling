/*Scenario 1*/

CREATE OR REPLACE TRIGGER
UpdateCustomerLastModified
BEFORE UPDATE
ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified :=
        SYSDATE;
END;
/

/*Scenario 2*/

CREATE OR REPLACE TRIGGER
LogTransaction
AFTER INSERT
ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog
    (TransactionID,
     ActionDate,
     Description)
    VALUES
    (:NEW.TransactionID,
     SYSDATE,
     'Transaction Added');
END;
/

/*Scenario 3*/

CREATE OR REPLACE TRIGGER
CheckTransactionRules
BEFORE INSERT
ON Transactions
FOR EACH ROW
DECLARE
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID=
          :NEW.AccountID;

    IF :NEW.TransactionType=
       'Withdrawal'
       AND
       :NEW.Amount>v_balance THEN

       RAISE_APPLICATION_ERROR
       (-20002,
       'Insufficient Balance');

    ELSIF :NEW.TransactionType=
          'Deposit'
          AND
          :NEW.Amount<=0 THEN

       RAISE_APPLICATION_ERROR
       (-20003,
       'Deposit must be positive');
    END IF;
END;
/