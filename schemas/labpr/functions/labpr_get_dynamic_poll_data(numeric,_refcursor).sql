-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_dynamic_poll_data(numeric, refcursor)
-- Type: FUNCTION

-- Name: labpr_get_dynamic_poll_data(numeric, refcursor); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_dynamic_poll_data(p_poll_id numeric, p_poll_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

DECLARE
v_poll_id numeric := p_poll_id;
v_poll_desc jsonb;
v_type numeric;
i record;
v_options json;
v_question text;
v_contactid numeric;
o jsonb;
b jsonb;
j jsonb;
v_user_id jsonb;
v_polloption_array jsonb;
v_correct_ans numeric[];
s_correct_ans numeric[];
v_ans_array numeric[];
s_ans_array numeric[];
v_ans character varying;
v_question_text character varying;
v_correct_ans_id jsonb;

begin

--insert into labpr.labpr_p values('391');

select poll_desc into v_poll_desc from labpr.labpr_poll where poll_id = v_poll_id;

select (v_poll_desc ->> 'type')::numeric into v_type;

--execute 'GRANT USAGE, CREATE ON SCHEMA labpr TO wafwebagent ';

--drop table labpr.labpr_cur_table;

if v_type = 1 THEN

open p_poll_cur for select wu.user_id,(option ::jsonb ->> 'player'):: varchar as user_answer_player_name, wu.first_name,wu.last_name,wu.email_id,wu.mobile_no,wu.dob,ct.name as country_name,
wu.city,wu.pincode from labpr.labpr_poll_option po  
join labpr.labpr_user_poll_response pr on (po.poll_option_id = pr.response_option_id) 
left join labpr.labpr_web_user wu on (wu.user_id = pr.user_id)
left join waf_master.waf_countries ct on (wu.country_id=ct.country_id) 
where po.poll_id = v_poll_id;

 --execute 'GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labpr TO wafwebagent;';

 --execute 'GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labpr TO waf_agent';

elsif v_type = 2 THEN


--drop table poll_data_t2;
 delete from labpr.labpr_poll_temp;

	
	for i in 
	select poll_option_id,option from labpr.labpr_poll_option
	where poll_id = v_poll_id
	loop

	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;

	--raise notice 'v_options%',v_options;
	--raise notice 'v_question%',v_question;
    
	insert into labpr.labpr_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
     
     	--raise notice 'v_poll_id %',v_poll_id;
	
	delete from labpr.labpr_poll_temp_1;
				
				    insert into labpr.labpr_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from labpr.labpr_user_poll_response pr
					left join labpr.labpr_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labpr.labpr_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
					
update labpr.labpr_poll_temp_1 set user_id = '0' where user_id is null;

			
perform colpivot('poll_data_t2', $$ select user_id,question,answer_display_value from labpr.labpr_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');

open p_poll_cur for select first_name,last_name,email_id,mobile_no,dob,city,pincode,a.* from poll_data_t2 a
	left join labpr.labpr_web_user wu on wu.user_id=a.user_id::numeric;
	

 --execute 'GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labpr TO wafwebagent;';

 --execute 'GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labpr TO waf_agent';

elsif v_type = 3 then

-- select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	--drop table poll_data_t3;
   delete from labpr.labpr_poll_temp_1;
   
	select json_agg(x) from 
	(select distinct(a.user_id)
	from labpr.labpr_web_user a
	join labpr.labpr_user_poll_response b
	on a.user_id=b.user_id
	where b.poll_id=v_poll_id)x
	into v_user_id;
    
    select json_agg(x) from 
(select option::json->'question_text' as question_text,poll_option_id 
from labpr.labpr_poll_option
where poll_id=v_poll_id
order by poll_option_id asc)x
into v_polloption_array;
    
   for b in select * from jsonb_array_elements(v_user_id)
	loop
    
    for j in select * from jsonb_array_elements(v_polloption_array)
		loop
    
        
        select ans_array into v_ans_array
			from labpr.labpr_user_poll_response
			where response_option_id=(j->>'poll_option_id')::numeric
			and user_id=(b->>'user_id')::numeric and poll_id=v_poll_id;
            
         select (option::json->>'correct_ans_id')
			into v_correct_ans_id
			from labpr.labpr_poll_option
			where poll_option_id=(j->>'poll_option_id')::numeric
			and poll_id=v_poll_id; 
            
            --raise notice 'v_ans_array:%',v_ans_array;
            --raise notice 'v_correct_ans:%',v_correct_ans_id;
            v_correct_ans:=null;
         for o in select * from jsonb_array_elements(v_correct_ans_id)
			loop

				v_correct_ans:= array_append(v_correct_ans,o::numeric);
			end loop;
            
            select sort(v_ans_array::int[]) into s_ans_array;
            select sort(v_correct_ans::int[]) into s_correct_ans;
			
			if s_ans_array = s_correct_ans then
				v_ans:= v_ans_array::text||'-(CORRECT)';
			else
				v_ans:=v_ans_array::text||'-(WRONG)';
			end if;  
        --raise notice 'user_id:%',b->'user_id';    
        --raise notice 'question:%',j->>'question_text';    
        insert into labpr.labpr_poll_temp_1 values ((b->'user_id')::numeric,j->>'question_text',v_ans);
        end loop;
        
    
    end loop;
	
	update labpr.labpr_poll_temp_1 set user_id = '0' where user_id is null;
	
    perform colpivot('poll_data_t3',$$ select user_id,question,answer_display_value from labpr.labpr_poll_temp_1 $$,array['user_id'], array['question'], '#.answer_display_value',null);

open p_poll_cur for select * from poll_data_t3;

 --execute 'GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labpr TO wafwebagent;';

 --execute 'GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labpr TO waf_agent';

else

open p_poll_cur for select 1/0;

end if;

--ALTER TABLE labpr.labpr_cur_table OWNER TO waf_agent;

end;

$_$;


--
