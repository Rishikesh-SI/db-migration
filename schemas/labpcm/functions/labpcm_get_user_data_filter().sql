-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_get_user_data_filter()
-- Type: FUNCTION

-- Name: labpcm_get_user_data_filter(); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_get_user_data_filter(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	begin
		
		select '{"data":'||json_agg(row)||'}'   into p_data
		from (select poll_id as id,title from labpcm.labpcm_user_data_filter
			 	order by 1)row;
		
	

	end;

$$;


--
