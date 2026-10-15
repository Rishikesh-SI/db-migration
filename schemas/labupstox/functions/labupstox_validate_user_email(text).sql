-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_validate_user_email(text)
-- Type: FUNCTION

-- Name: labupstox_validate_user_email(text); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_validate_user_email(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_exists numeric;
v_payment_status numeric;
v_pledged_distance varchar(500);

begin

select count(1)
from labupstox.labupstox_user_master
where email_id=p_email_id
into v_exists;

select payment_status,pledged_distance
from labupstox.labupstox_user_master
where email_id=p_email_id
into v_payment_status,v_pledged_distance;

if v_exists>0 and coalesce(v_payment_status,0)=1 and v_pledged_distance is not null
then
p_out:=1;
elsif v_exists>0 and coalesce(v_payment_status,0)=1 and v_pledged_distance is null
then
p_out:=2;

elsif v_exists>0 and coalesce(v_payment_status,0)=0 then
p_out:=2;

else
p_out:=0;

end if;
 

exception when others then
p_out:=-1;

end;

$$;


--
