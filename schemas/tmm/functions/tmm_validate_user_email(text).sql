-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_validate_user_email(text)
-- Type: FUNCTION

-- Name: tmm_validate_user_email(text); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_validate_user_email(p_email_id text, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_exists numeric;
p_out numeric;
v_virtual_reg numeric;
v_onground_reg numeric ;

begin

select count(1)
from tmm.tmm_user_master
where upper(email_id)=upper(p_email_id)
and payment_status=1
into v_exists;




select count(1)
from tmm.tmm_og_user_master
where upper(email_id)=upper(p_email_id)
and payment_status=1
into v_onground_reg;

---raise notice '%',v_exists;
if v_exists>0 and v_onground_reg>0 then
v_virtual_reg:=1;
v_onground_reg:=1;
p_out:=1;
elsif  v_exists>0 
then v_virtual_reg:=1;
v_onground_reg:=0;
p_out:=1;
elsif  v_onground_reg>0  then
 v_onground_reg:=1;
 v_virtual_reg:=0;
 p_out:=1;
 else 
 v_onground_reg:=0;
 v_virtual_reg:=0;
 p_out:=0;
end if;
select row_to_json(row)
from(
select v_virtual_reg as virtual_reg,
	v_onground_reg as onground_reg,
	p_out as is_user
)as row
into p_json;
 
exception when others then
p_json:='{}'; 

end;
$$;


--
