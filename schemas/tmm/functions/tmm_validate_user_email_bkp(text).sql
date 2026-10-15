-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_validate_user_email_bkp(text)
-- Type: FUNCTION

-- Name: tmm_validate_user_email_bkp(text); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_validate_user_email_bkp(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_exists numeric;

begin

select count(1)
from tmm.tmm_user_master
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
