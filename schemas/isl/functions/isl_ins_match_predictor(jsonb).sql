-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_match_predictor(jsonb)
-- Type: FUNCTION

-- Name: isl_ins_match_predictor(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_match_predictor(p_input_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

v_team_id numeric;
v_match_id character varying;
v_captcha character varying;
v_current_date timestamp;

begin

	select
	  p_input_json->'data'->>'team_id',
	  p_input_json->'data'->>'match_id',
	  p_input_json->'data'->>'captcha'

	into  v_team_id,
		  v_match_id,
		  v_captcha ;
		  
	v_current_date :=  current_timestamp at time zone 'utc';	  
		  

--    if not exists( select 1 from isl.isl_match_predictor
-- 				  where captch = v_captcha ) then	
	insert into isl.isl_match_predictor (match_predictor_id,team_id,match_id,created_date,captch,
										json)
				values(nextval('isl.seq_isl_match_predictor_id'),v_team_id,v_match_id,v_current_date,
					  v_captcha,p_input_json);
					  
			select ('{"data":['||string_agg(row_to_json(row)::text,',')||'],"result": 1}')::jsonb 
			into p_data
			from(select team_id,count(1) from isl.isl_match_predictor
				 where match_id = v_match_id
				 group by 1)row ;
				 
			
					  
				  
--    else
      
-- 	  select ('{"data":['||string_agg(row_to_json(row)::text,',')||'],"result": 0}')::jsonb 
-- 			into p_data
-- 			from(select team_id,count(1) from isl.isl_match_predictor
-- 				 where match_id = v_match_id
-- 				 group by 1)row ;
   
--    end if ;
	  
end ; 
$$;


--
