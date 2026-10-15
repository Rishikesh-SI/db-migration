-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_upload_data_filter(character varying)
-- Type: FUNCTION

-- Name: _get_upload_data_filter(character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_upload_data_filter(p_schema_prefix character varying, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	begin
		
		 execute	'select ''{"data":''||json_agg(row)||''}''   
					from (select * from '||p_schema_prefix||'.'||p_schema_prefix||'_upload_data_filter
			 	order by 1)row'
		into p_data;
	

	end;
$$;


--
