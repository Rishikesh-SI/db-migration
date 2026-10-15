-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labpr_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

/*
select * from labpr.labpr_get_user_data
(
    '{
    "opt_type": 2,
  "start_date_time": "2019-03-23 00:00:00",
  "end_date_time": "2019-03-23 23:20:02",
  "jsondata" :{"poll_id":281}
}',
    'a'
);
fetch all in "a";
*/

declare
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
    v_poll_id numeric;
	v_contact_id jsonb;
	--i jsonb;
	v_options json;
	v_question text;
    v_display_name character varying ='';
    v_answer character varying ='';
    v_is_ans numeric;
	v_polloption_array jsonb;
	v_polloption_id numeric[];
	v_correct_ans_id jsonb;
	b jsonb;
	j jsonb;
    i record;
	v_ans_array numeric[];
	v_ans character varying;
	v_question_text character varying;
	v_contactid numeric;
	d jsonb;
    o jsonb;
	v_correct_ans numeric[];
    v_result numeric;
    poll_cur REFCURSOR;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    /*
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labpr.labpr_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labpr.labpr_web_user wu
          join labpr.labpr_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labpr.labpr_web_user wu
          join labpr.labpr_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labpr.labpr_web_user wu
          join labpr.labpr_asset_comment_reaction acr
          on acr.user_id = wu.user_id
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
         ) as tab
	left join waf_master.waf_cities c
     on c.city_id = tab.city_id
     left join waf_master.waf_states s
     on s.state_id = tab.state_id
     left join waf_master.waf_countries co
     on co.country_id = tab.country_id;
 end if;
 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labpr.labpr_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labpr.labpr_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labpr.labpr_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labpr.labpr_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
    */
    if v_opt_type = 1 then
    
    	 open p_user_cursor for
         select first_name as first_name,last_name as last_name,email_id as email_id,
         mobile_no as mobile_no,dob as dob,gender as gender,
         country as country,city as city,pincode as pincode
		 from labpr.labpr_web_user 
		 where created_date::date between v_start_date_time and v_end_date_time;
 
 
 	end if;
 
    if v_opt_type = 2 then
    
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labpr.labpr_poll_temp_1;
   
	select json_agg(x) from 
	(select distinct(a.contact_id)
	from labpr.labpr_contact a
	join labpr.labpr_poll_response b
	on a.contact_id=b.contact_id
	where b.poll_id=v_poll_id)x
	into v_contact_id;
    
    select json_agg(x) from 
(select option::json->'question_text' as question_text,poll_option_id 
from labpr.labpr_poll_option
where poll_id=v_poll_id
order by poll_option_id asc)x
into v_polloption_array;
    
   for b in select * from jsonb_array_elements(v_contact_id)
	loop
    
    for j in select * from jsonb_array_elements(v_polloption_array)
		loop
    
        
        select ans_array into v_ans_array
			from labpr.labpr_poll_response
			where response_option_id=(j->>'poll_option_id')::numeric
			and contact_id=(b->>'contact_id')::numeric and poll_id=v_poll_id;
            
         select (option::json->>'correct_ans_id')
			into v_correct_ans_id
			from labpr.labpr_poll_option
			where poll_option_id=(j->>'poll_option_id')::numeric
			and poll_id=v_poll_id; 
            
           -- raise notice 'v_ans_array:%',v_ans_array;
           -- raise notice 'v_correct_ans:%',v_correct_ans_id;
            v_correct_ans:=null;
         for o in select * from jsonb_array_elements(v_correct_ans_id)
			loop

				v_correct_ans:= array_append(v_correct_ans,o::numeric);
			end loop;
			
			if v_ans_array = v_correct_ans then
				v_ans:= v_ans_array::text||'-(CORRECT)';
			else
				v_ans:=v_ans_array::text||'-(WRONG)';
			end if;  
        --raise notice 'contact_id:%',b->'contact_id';    
        --raise notice 'question:%',j->>'question_text';    
        insert into labpr.labpr_poll_temp_1 values ((b->'contact_id')::numeric,j->>'question_text',v_ans);
        end loop;
        
    
    end loop;
	
    perform colpivot('poll_data',$$ select contact_id,question,answer_display_value from labpr.labpr_poll_temp_1 $$,array['contact_id'], array['question'], '#.answer_display_value','question');

                
    	 open p_user_cursor for
         select a.* from labpr.labpr_contact c join (select * from poll_data)a on a.contact_id::numeric=c.contact_id;

 	end if;
    
    if v_opt_type = 3 THEN
    
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
    /*
    For testing purpose created poll
    Poll id   TYPE
        321 - type 1
        301 - type 2
        281 - type 3
    */
        perform labpr.labpr_get_dynamic_poll_data(v_poll_id,p_user_cursor);

    end if;
    
	
end;

$_$;


--
