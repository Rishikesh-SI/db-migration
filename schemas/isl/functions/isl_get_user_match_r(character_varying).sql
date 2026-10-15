-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_user_match_r(character varying)
-- Type: FUNCTION

-- Name: isl_get_user_match_r(character varying); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_user_match_r(p_user_guid character varying, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

	declare
	
	v_match_data jsonb;
	v_data jsonb ;
	
	begin

	select ('{"data":'||json_agg(row_to_json(tab))::text||'}')::jsonb into v_data from
	(select match_id,team_id from isl.isl_fan_wall
	where user_guid  = p_user_guid )tab;
	
	
	
	select json_agg(row_to_json(tab))::jsonb into v_match_data  from
	(select team_id,match_id,count(1) as count from isl.isl_fan_wall
	group by 1,2
	having count(1) >= 1000)tab;
	
	if v_data is not null then
	
		if v_match_data is not null then
		
		p_data :=jsonb_set(v_data,'{match_data}',v_match_data,true);
		
		else
		
		p_data := v_data;
		
		end if;
	
	else 
		
		select ('{"match_data":'||json_agg(row_to_json(tab))::text||'}')::jsonb into p_data  from
		(select team_id,match_id,count(1) as count from isl.isl_fan_wall
		 group by 1,2
		 having count(1) >= 1000)tab;
	
	
	end if;
	end ;
	
	$$;


--
