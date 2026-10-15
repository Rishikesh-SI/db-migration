-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_match_predictor(jsonb)
-- Type: FUNCTION

-- Name: isl_get_match_predictor(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_match_predictor(p_json jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

/*p_json json := '{
				"match_id" : "1234,3567"
				}';*/

v_id character varying := '';
v_match_id varchar[];
-- p_result jsonb;

begin

	select p_json->>'match_id' into v_id;

    select string_to_array(v_id, ',') into v_match_id;
	
	-- raise notice '%',v_match_id;
	
	select ('{"data":'||(json_agg(row_to_json(tab_1)))::text||'}')::jsonb into p_result
	from (select match_id,(json_agg(data)) as result
		  from(select match_id,json_build_object(team_id,cnt) as data
			   from (select match_id,team_id,count(1) as cnt from isl.isl_match_predictor
					 where match_id in (select match_id from unnest(v_match_id) match_id)
					 group by 1,2
					 order by 1 desc)row)tab
		  group by 1)tab_1;
		  
		 -- raise notice '%',p_result;

end;

$$;


--
