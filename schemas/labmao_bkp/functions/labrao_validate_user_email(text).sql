-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_validate_user_email(text)
-- Type: FUNCTION

-- Name: labrao_validate_user_email(text); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_validate_user_email(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_exists numeric;

begin

select count(1)
from labrao.labrao_user_master
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
