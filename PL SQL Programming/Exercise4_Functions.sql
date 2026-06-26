/*Scenario 1*/

CREATE OR REPLACE FUNCTION
CalculateAge(
    p_dob DATE
)
RETURN NUMBER
IS
BEGIN
    RETURN TRUNC(
        MONTHS_BETWEEN
        (SYSDATE,p_dob)/12);
END;
/

/*Scenario 2*/

CREATE OR REPLACE FUNCTION
CalculateMonthlyInstallment(
    p_amount NUMBER,
    p_rate NUMBER,
    p_years NUMBER
)
RETURN NUMBER
IS
    v_emi NUMBER;
    r NUMBER;
    n NUMBER;
BEGIN
    r:=p_rate/12/100;
    n:=p_years*12;

    v_emi:=
    (p_amount*r*
    POWER(1+r,n))/
    (POWER(1+r,n)-1);

    RETURN v_emi;
END;
/

/*Scenario 3*/

CREATE OR REPLACE FUNCTION
HasSufficientBalance(
    p_account NUMBER,
    p_amount NUMBER
)
RETURN BOOLEAN
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID=
          p_account;

    RETURN v_balance>=p_amount;
END;
/
