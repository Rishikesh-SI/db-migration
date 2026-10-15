-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_upd_user_session_status(date)
-- Type: FUNCTION

-- Name: labbsc_dev_upd_user_session_status(date); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_upd_user_session_status(p_session_date date, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin

update labbsc_dev.labbsc_dev_user_mentor_session
set status=2
where session_date=p_session_date;


update labbsc_dev.labbsc_dev_mentor_slot
set status=2
where session_date=p_session_date;
p_out:=1;
end;
 $$;


--
