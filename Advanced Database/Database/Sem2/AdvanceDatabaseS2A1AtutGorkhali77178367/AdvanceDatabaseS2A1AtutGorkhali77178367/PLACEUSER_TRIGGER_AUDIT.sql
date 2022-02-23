create or replace trigger placeuser_trigger_audit
Before
update on lds_placement
for each row
Begin
:new.updatedby:=V('APP_USER');
:new.updateddate:=sysdate;
end;
