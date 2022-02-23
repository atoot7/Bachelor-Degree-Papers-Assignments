create or replace package "LDS_PKG" is 
PROCEDURE SkilAudit(Action in varchar2,OldData varchar2,NewData varchar2);
FUNCTION get_sal(Id IN NUMBER) RETURN NUMBER;
FUNCTION getMaxJoinDate(Id IN NUMBER) RETURN DATE;
FUNCTION getCurrentCompany(Id IN NUMBER) RETURN VARCHAR2;
FUNCTION getSkillNmae(SkillId IN NUMBER) RETURN VARCHAR2;
PROCEDURE proc_my_placement (Id NUMBER, result_refcur IN OUT SYS_REFCURSOR);
END LDS_PKG;
