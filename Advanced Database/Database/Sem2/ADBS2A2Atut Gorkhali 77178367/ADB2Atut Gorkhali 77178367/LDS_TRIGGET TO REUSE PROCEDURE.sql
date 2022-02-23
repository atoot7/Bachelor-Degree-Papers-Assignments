create or replace trigger skillUpdateDelete_audit
after update or delete
on LDS_SKILL
for each row
Declare
v_id number;
begin
If updating THEN
Begin
If (:Old.SKILL_DESC<> :New.SKILL_DESC) Then
begin
lds_pkg.SkilAudit('Update',to_char(:old.SKILL_DESC),to_char(:new.SKILL_DESC));
end;
end if;
END;
End If;
If deleting THEN
begin
lds_pkg.SkilAudit('Delete',to_char(:old.SKILL_DESC),NULL);
end;
End if;
end;