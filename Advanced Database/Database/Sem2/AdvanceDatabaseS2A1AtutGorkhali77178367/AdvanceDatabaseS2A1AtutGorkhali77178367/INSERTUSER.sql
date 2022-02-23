create or replace Procedure InsertUser(CONTRACTOR_Id IN Number,CON_NAMe in Varchar2,CON_POSTCODe IN varchar2, CON_SKILl_1 IN NUMBER,CON_SKILl_2 IN
NUMBER,CON_SKILl_3 IN
NUMBER, HIGHEST_QUAl IN NUMBER, PREFERRED_ROLe IN Number
)
IS
var_assign_user varchar2(1000);
v_id number;
BEGIN
    insert into lds_contractor(CONTRACTOR_ID,CON_NAME,CON_POSTCODE, CON_SKILL_1,CON_SKILL_2,CON_SKILL_3, HIGHEST_QUAL, PREFERRED_ROLE) VALUES
    (CONTRACTOR_Id,CON_NAMe, CON_POSTCODe, CON_SKILl_1,CON_SKILl_2,CON_SKILl_3, HIGHEST_QUAl, PREFERRED_ROLe)
returning Contractor_Id into v_id;
insert into placeuser(username,password,Contractor_Id) Values (Replace(CON_NAMe,' ','_'),Replace(CON_NAMe,' ','_'),v_id);
var_assign_user := 'create user ' || Replace(CON_NAMe,' ','_') || ' identified by '||Replace(CON_NAMe,' ','_');
EXECUTE IMMEDIATE var_assign_user;
grantroles(Replace(CON_NAMe,' ','_'));
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
