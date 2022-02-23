create or replace PACKAGE BODY "LDS_PKG" AS


Procedure SkilAudit(Action in varchar2,OldData varchar2,NewData varchar2)IS
BEGIN
Insert into skillInteractionAudit(action,oldData,newData,ACTIONBY) values(Action,OldData,NewData,V('APP_USER'));
EXCEPTION
      WHEN OTHERS THEN
      Insert Into log_errors_table(errorId,description,tablename)values(log_errors_table_seq.nextval,'Error during inserting audit','Skill Audit');

END;


FUNCTION get_sal(Id IN NUMBER)
   RETURN NUMBER
   IS salary NUMBER(18,2);
   BEGIN
       
SELECT to_number(placement.ACTUAL_SALARY) into salary FROM
        LDS_PLACEMENT placement
        JOIN
        ( SELECT FK2_CONTRACTOR_ID,MAX(PTL_ACTUAL_START_DATE) AS col_date
          FROM LDS_PLACEMENT
WHERE FK2_CONTRACTOR_ID=Id
 GROUP BY FK2_CONTRACTOR_ID
        ) m
      ON  m.FK2_CONTRACTOR_ID = placement.FK2_CONTRACTOR_ID
      AND m.col_date = placement.PTL_ACTUAL_START_DATE;
return salary;  
EXCEPTION
      WHEN OTHERS THEN
      Insert Into log_errors_table(errorId,description,tablename)values(log_errors_table_seq.nextval,'Error during getting salary info','LDS_PLACEMENT');

END;


FUNCTION getMaxJoinDate(Id IN NUMBER)
return date is
  lds_date date;
begin
select (MAX(PTL_ACTUAL_START_DATE))
    into lds_date
    from LDS_PLACEMENT where FK2_CONTRACTOR_ID=Id;
  return lds_date;
EXCEPTION
      WHEN OTHERS THEN
      Insert Into log_errors_table(errorId,description,tablename)values(log_errors_table_seq.nextval,'Error during getting join date info','LDS_PLACEMENT');

end;


FUNCTION getCurrentCompany(Id IN NUMBER)
return varchar2 is
company varchar2(50);
begin
SELECT account.ACC_NAME into company
FROM LDS_ACCOUNT account
INNER JOIN LDS_PLACEMENT placement
ON account.ACCOUNT_ID = placement.FK1_ACCOUNT_ID
where placement.FK2_CONTRACTOR_ID =Id
AND placement.PTL_ACTUAL_START_DATE=LDS_PKG.getMaxJoinDate(Id);
return company;
EXCEPTION
      WHEN OTHERS THEN
      Insert Into log_errors_table(errorId,description,tablename)values(log_errors_table_seq.nextval,'Error during getting company info','LDS_ACCOUNT');

end;

FUNCTION getSkillNmae(SkillId IN NUMBER)
return varchar2 is
skillname varchar2(50);
begin
SELECT SKILL_DESC into skillname
FROM LDS_SKILL where SKILL_ID    =SkillId;
return skillname ;
EXCEPTION
      WHEN OTHERS THEN
      Insert Into log_errors_table(errorId,description,tablename)values(log_errors_table_seq.nextval,'Error during getting skill name','LDS_SKILL');

end;

PROCEDURE proc_my_placement (Id NUMBER, result_refcur IN OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN result_refcur FOR SELECT * FROM LDS_PLACEMENT WHERE FK2_CONTRACTOR_ID= Id;
EXCEPTION
      WHEN OTHERS THEN
      Insert Into log_errors_table(errorId,description,tablename)values(log_errors_table_seq.nextval,'Error during getting salary info','LDS_PLACEMENT');

END;


END;