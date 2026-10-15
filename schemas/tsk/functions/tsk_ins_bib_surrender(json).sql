-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_ins_bib_surrender(json)
-- Type: FUNCTION

-- Name: tsk_ins_bib_surrender(json); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_ins_bib_surrender(p_surrenderjson json, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_continue 		numeric;
    v_json 			json;
    v_first_name 	character varying(200);
    v_last_name		character varying(200);
    v_dob			date;
    v_gender		character varying(10);
    v_app_id		numeric;
    v_bib_no		numeric;
    v_race_category character varying(50);
    v_reason		text;
    
begin
	
   	v_json := p_surrenderjson;
    
    select v_json->'appdata'->>'first_name',
    	   v_json->'appdata'->>'last_name',
           v_json->'appdata'->>'dob',
           v_json->'appdata'->>'gender',
           v_json->'appdata'->>'app_id',
           v_json->'appdata'->>'bib_no',
           v_json->'appdata'->>'race_category',
           v_json->'appdata'->>'reason'
    into 	v_first_name,
    		v_last_name,
            v_dob,
            v_gender,
            v_app_id,
            v_bib_no,
            v_race_category,
    		v_reason;
   
   
	if exists(select 1 from tsk.tsk_app_status
              where app_id = v_app_id
            --  and bib_no::numeric = v_bib_no  -- comment on 2018/09/21 
              and date_of_birth::date = v_dob
              and lower(race) = lower(v_race_category)
              and lower(first_name)= lower(v_first_name)
              and lower(last_name) = lower(v_last_name)
              and lower(status) = 'accepted') 
    then
		
      if not exists (select 1 from tsk.tsk_bib_surrender 
                     where app_id = v_app_id
              		 -- and bib_no::numeric = v_bib_no -- comment on 2018/09/21 
              		 and date_of_birth::date = v_dob
              		 and lower(race) = lower(v_race_category)
              		 and lower(first_name)= lower(v_first_name)
              		and lower(last_name) = lower(v_last_name)
                    ) 
      then
		insert into tsk.tsk_bib_surrender
        (bib_surrender_id, app_id, first_name, last_name, date_of_birth, gender, race, surrender_reason,
         bib_no, is_nominating, created_date, updated_date, is_active, is_deleted)
        values(nextval('tsk.seq_tsk_bib_surrender_id'), v_app_id, v_first_name, v_last_name, v_dob, v_gender, 
               v_race_category, v_reason, v_bib_no, null, current_timestamp at time zone 'utc',
               current_timestamp at time zone 'utc', 1, 0);
      
      	p_result := currval('tsk.seq_tsk_bib_surrender_id') ;
      
      else 
      		select bib_surrender_id into p_result
            from tsk.tsk_bib_surrender 
             where app_id = v_app_id
             -- and bib_no::numeric = v_bib_no -- comment on 2018/09/21 
             and date_of_birth::date = v_dob
             and lower(race) = lower(v_race_category)
             and lower(first_name)= lower(v_first_name)
            and lower(last_name) = lower(v_last_name) ; 
            
      end if;
	else
    	
        p_result := 0;
        
	end if;
   
    exception 
    	when others then 
         	 p_result := -1;
   
end;

$$;


--
