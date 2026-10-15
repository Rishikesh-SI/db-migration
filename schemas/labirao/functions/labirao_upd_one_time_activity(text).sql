-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_upd_one_time_activity(text)
-- Type: FUNCTION

-- Name: labirao_upd_one_time_activity(text); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_upd_one_time_activity(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare  
v_current_date date:=current_date;
begin


update labirao.labirao_user_master
set activity_date=v_current_date
where upper(email_id)=upper(p_email_id)
and payment_status=1;

p_out:=1;

end;
$$;


--
