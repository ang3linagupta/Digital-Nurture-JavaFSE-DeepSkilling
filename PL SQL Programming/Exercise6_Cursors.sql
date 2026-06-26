/*Scenario 1*/

DECLARE
    CURSOR GenerateMonthlyStatements IS
    SELECT *
    FROM Transactions
    WHERE EXTRACT(MONTH
          FROM TransactionDate)=
          EXTRACT(MONTH
          FROM SYSDATE);

    v_rec Transactions%ROWTYPE;
BEGIN
    OPEN GenerateMonthlyStatements;

    LOOP
        FETCH GenerateMonthlyStatements
        INTO v_rec;

        EXIT WHEN
        GenerateMonthlyStatements%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
        'Transaction ID : '
        ||v_rec.TransactionID||
        ' Amount : '
        ||v_rec.Amount);
    END LOOP;

    CLOSE GenerateMonthlyStatements;
END;
/

/*Scenario 2*/

DECLARE
    CURSOR ApplyAnnualFee IS
    SELECT AccountID
    FROM Accounts;
BEGIN
    FOR acc IN ApplyAnnualFee
    LOOP
        UPDATE Accounts
        SET Balance=
            Balance-100
        WHERE AccountID=
              acc.AccountID;
    END LOOP;

    COMMIT;
END;
/

/*Scenario 3*/

DECLARE
    CURSOR UpdateLoanInterestRates IS
    SELECT LoanID,
           InterestRate
    FROM Loans;
BEGIN
    FOR l IN
    UpdateLoanInterestRates
    LOOP
        UPDATE Loans
        SET InterestRate=
            l.InterestRate+0.5
        WHERE LoanID=l.LoanID;
    END LOOP;

    COMMIT;
END;
/

