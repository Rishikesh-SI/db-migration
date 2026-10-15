-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_ins_upd_contest_response_14022025(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_ins_upd_contest_response_14022025(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_ins_upd_contest_response_14022025(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_currenttimestamp timestamp;
    v_json jsonb := p_json;
    v_contest_id numeric;
	v_contestdatajson jsonb;
    v_userguid character varying(256);
    v_userid numeric;
    v_uservotecount numeric;
    v_contestdata json;
    v_option_id numeric;
    v_rows numeric;
    v_contest_response_id numeric;
    v_total_responses numeric;
	v_player_rating numeric;
    v_contest_questions_id numeric;
	v_no_of_ans_allowed numeric;
    v_score numeric;
	v_player_id numeric;
	v_wickets numeric;
	v_image_path character varying(1000);
	v_video_path character varying(1000);
	v_extra character varying(1000); 
    v_answer_id numeric;
	v_user_info jsonb;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'contest_id', v_json->'data'->>'contest_questions' , v_json->'data'->>'user_info'
    into v_contest_id, v_contestdatajson , v_user_info;
    
	
            	
            	
    insert into labgsoc.labgsoc_contest_response(contest_response_id,contest_id,contest_questions , user_info , created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,contest_response_guid,response_count)
         		values(nextval('labgsoc.seq_labgsoc_contest_response_id'),v_contest_id,v_contestdatajson ,v_user_info ,  v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				
           
            
		
    	
   p_result := 1;
		
    
    
    select sum(response_count)
    into v_total_responses
    from labgsoc.labgsoc_contest_response
    where contest_id = v_contest_id;
    
    if p_result = 1 then

	raise notice 'sachin';
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_contest_id contest_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(contest_questions)) as contest_questions
              from(select  sum(response_count) as response_count
                   from labgsoc.labgsoc_contest_response
                   where contest_id = v_contest_id
                   )contest_questions))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"contest_questions":null,"contest_id":null}}'::jsonb;
     
    end if;
  
exception
	when others then
	raise notice 'sachin2';
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"contest_questions":null,"contest_id":null}}'::jsonb;
	
end;

$$;


--
