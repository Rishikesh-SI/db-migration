-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_user_data_filter()
-- Type: FUNCTION

-- Name: tmmimg_upd_get_user_data_filter(); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_user_data_filter(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	begin
		
		select '{"data":'||json_agg(row)||'}'   into p_data
		from (select poll_id as id,title from tmmimg_upd.tmmimg_upd_user_data_filter
			 	order by 1)row;
		
	

	end;
$$;


--
