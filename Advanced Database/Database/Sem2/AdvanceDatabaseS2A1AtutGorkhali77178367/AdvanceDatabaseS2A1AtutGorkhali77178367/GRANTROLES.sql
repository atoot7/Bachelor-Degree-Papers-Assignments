create or replace procedure grantroles(username in Varchar2)
IS
BEGIN
EXECUTE IMMEDIATE 'GRANT newuserrole to ' || username;
END;
