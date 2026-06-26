/*Scenario 1*/

    Exercise 1: Control Structures

BEGIN
    FOR c IN (SELECT CustomerID,
                     DOB
              FROM Customers)
    LOOP
        IF TRUNC(MONTHS_BETWEEN
        (SYSDATE,c.DOB)/12) > 60 THEN

            UPDATE Loans
            SET InterestRate =
                InterestRate - 1
            WHERE CustomerID =
                  c.CustomerID;

        END IF;
    END LOOP;

    COMMIT;
END;
/

/*Scenario 2*/

BEGIN
    FOR c IN
    (SELECT CustomerID,Balance
     FROM Customers)
    LOOP
        IF c.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP='TRUE'
            WHERE CustomerID=
                  c.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
END;
/

/*Scenario 3*/

BEGIN
    FOR l IN
    (SELECT c.Name,
            l.EndDate
     FROM Customers c
     JOIN Loans l
     ON c.CustomerID=l.CustomerID
     WHERE l.EndDate
     BETWEEN SYSDATE
     AND SYSDATE+30)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        'Reminder for '
        ||l.Name||
        ' Loan due on '
        ||l.EndDate);
    END LOOP;
END;
/