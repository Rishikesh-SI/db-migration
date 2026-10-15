-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_get_activity_feed()
-- Type: FUNCTION

-- Name: labupstox_get_activity_feed(); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_get_activity_feed(OUT p_activity_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
 select array_to_json(array_agg(row)) as jsonrow  
   from (SELECT 
		  email_id,
		   bib_no, 
		 activity_date, 
		 activity_time,
		 distance_in_km, 
		 speed,
		 run_id,
		 runner_id,
		 datasource,
		 activity_link,
		 activity_start_time
	FROM labupstox.mv_user_activity   
	   ) as row
	   into p_activity_json;

end;
$$;


--
