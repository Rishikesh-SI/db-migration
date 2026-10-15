-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_validate_user_email(text)
-- Type: FUNCTION

-- Name: dhm_validate_user_email(text); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_validate_user_email(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_exists numeric;

begin

select count(1)
from dhm.dhm_user_master
where upper(email_id)=upper(p_email_id)
and payment_status=1
into v_exists;

if v_exists>0 then
p_out:=1;
else
p_out:=0;
end if;

exception when others then
p_out:=-1;

end;
$$;


--
