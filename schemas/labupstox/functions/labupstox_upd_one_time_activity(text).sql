-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_upd_one_time_activity(text)
-- Type: FUNCTION

-- Name: labupstox_upd_one_time_activity(text); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_upd_one_time_activity(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare  
v_current_date date:=current_date;
begin


update labupstox.labupstox_user_master
set activity_date=v_current_date
where upper(email_id)=upper(p_email_id)
and payment_status=1;

p_out:=1;

end;
$$;


--
