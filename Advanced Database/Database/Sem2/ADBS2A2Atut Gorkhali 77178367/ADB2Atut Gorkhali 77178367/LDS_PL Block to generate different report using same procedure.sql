
DECLARE
    Id         NUMBER :=10;
    PlaceId    NUMBER;
    act_end_date DATE;	
    act_start_date DATE;
    row_date LDS_PLACEMENT%rowtype;
    result_refcur    SYS_REFCURSOR;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Contractor ID ' || Id);
    DBMS_OUTPUT.PUT_LINE('PlaceId    Start Date      End Date        Total Length');
    DBMS_OUTPUT.PUT_LINE('-------    ----------      --------        ------------');
    LDS_PKG.proc_my_placement(Id, result_refcur);
    LOOP
        FETCH result_refcur INTO row_date;
        EXIT WHEN result_refcur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(row_date.PLACEMENT_ID 
|| '         ' || row_date.PTL_ACTUAL_START_DATE
|| '      ' || row_date.PLT_ACTUAL_END_DATE 
|| '      ' || (to_date(row_date.PLT_ACTUAL_END_DATE,'dd/mm/yyyy')- to_date(row_date.PTL_ACTUAL_START_DATE,'dd/mm/yyyy'))||' Days'
);
    END LOOP;
    CLOSE result_refcur;
END;

DECLARE
    Id         NUMBER :=10;
    PlaceId    NUMBER;
    act_end_date DATE;
    act_start_date DATE;
    row_data LDS_PLACEMENT%rowtype;
    result_refcur    SYS_REFCURSOR;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Contractor ID ' || Id);
    DBMS_OUTPUT.PUT_LINE('PlaceId    Max Salary      Min Salary    Less Than Max     More than Min     Actual Salary');
    DBMS_OUTPUT.PUT_LINE('-------    ----------      --------      ------------      -------------     -------------');
    LDS_PKG.proc_my_placement(Id, result_refcur);
    LOOP
        FETCH result_refcur INTO row_data;
        EXIT WHEN result_refcur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(row_data.PLACEMENT_ID 
|| '           ' || row_data.MAX_SALARY
|| '           ' || row_data.MIN_SALARY
|| '           ' || (row_data.MAX_SALARY-row_data.ACTUAL_SALARY)
|| '           ' || (row_data.ACTUAL_SALARY-row_data.MIN_SALARY)
|| '                 ' || row_data.ACTUAL_SALARY
);
    END LOOP;
    CLOSE result_refcur;
END;
