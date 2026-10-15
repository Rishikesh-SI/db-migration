-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_runner_performance_guid(numeric)
-- Type: FUNCTION

-- Name: tmmimg_upd_get_runner_performance_guid(numeric); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_runner_performance_guid(p_bib_no numeric, OUT p_result numeric, OUT p_runner_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
   
    v_currenttimestamp timestamp;
    v_runner_json jsonb;

begin

	v_currenttimestamp := current_timestamp at time zone 'utc';

    if exists (select 1
               from tmmimg_upd.tmmimg_upd_my_journey_runner_info
               where bib_no=p_bib_no) then
      select row_to_json(tab) 
	    from (select runner_guid,first_name,last_name,bib_no
        
        from tmmimg_upd.tmmimg_upd_my_journey_runner_info 
        where bib_no=p_bib_no) tab
		into v_runner_json;

        p_result := 1;

	else

        p_result :=0;
		p_runner_json:=null;

	end if;

	p_runner_json := v_runner_json;

end;

$$;


--
