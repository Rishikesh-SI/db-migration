-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_upd_job_status(numeric, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_upd_job_status(numeric, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_upd_job_status(p_job_profile_id numeric, p_job_status numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
  		       v_sysdate 		timestamp;
		
begin
select current_timestamp  at time zone 'utc'
	into   v_sysdate;
	
	update labbsc_dev.labbsc_dev_job_profile
	set job_status=p_job_status,job_closing_date=v_sysdate
	where job_profile_id=p_job_profile_id;
	
	p_result:=case when p_job_status=3 then 3 else 1 end;
	
end;
$$;


--
