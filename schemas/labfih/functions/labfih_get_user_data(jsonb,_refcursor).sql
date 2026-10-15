-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labfih_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

/*
select * from labfih.labfih_get_user_data
(
    '{
    "opt_type": 3,
  "start_date_time": "2019-03-23 00:00:00",
  "end_date_time": "2019-03-23 23:20:02",
  "jsondata":{"entity_id":111041,"country":1}
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
    v_entity_id numeric;
    v_country numeric;
    v_poll_id numeric;
	v_userguid_array jsonb;
	v_wua_array jsonb;
	i record;
	v_options json;
	v_question text;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
 /*if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labfih.labfih_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labfih.labfih_web_user wu
          join labfih.labfih_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labfih.labfih_web_user wu
          join labfih.labfih_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labfih.labfih_web_user wu
          join labfih.labfih_asset_comment_reaction acr
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
      		from labfih.labfih_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labfih.labfih_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labfih.labfih_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labfih.labfih_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 */
 if v_opt_type = 1 then 
  
   --v_poll_id:=81; 
  open p_user_cursor for
  select contact_json->'data'->'user_info'->>'first_name' as user_full_name,
  contact_json->'data'->'user_info'->>'email_id' as email_id,feedback
  from labfih.labfih_contact
  where created_date between v_start_date_time and v_end_date_time;
  	
  
 end if;  
 
 if v_opt_type = 2 then 
 

   open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' 
  when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,wu.user_guid,
         first_name,last_name,email_id,age_group as "Age Group",gender,wc.name as country,created_date,
         tab.asc_with_hockey,tab1.ext_info as fav_team,tab3.poll_name as "Participation in Activations" , tab_audit.audit_date + '5.5 hours'::interval as last_login_date--,.(select tab4.audit_date order by tab4.audit_date desc limit 1 ) as "Last Login Date"
         from labfih.labfih_web_user wu
		 left join (select user_id,string_agg(pl.title,',') as poll_name from labfih.labfih_user_poll_response upr 
			   JOIN labfih.labfih_poll pl
			   on pl.poll_id = upr.poll_id
			   group by user_id
			   )tab3
		 on tab3.user_id = wu.user_id
-- 		 left join (select wua.user_guid,audit_date from labfih.labfih_web_user_audit wua 
-- 					where wua.user_guid in (select (ab.user_guid) from labfih.labfih_web_user_audit wua
-- 															left join labfih.labfih_web_user ab
-- 					                                        on ab.user_guid = wua.user_guid
-- 															 where option_type=4 
-- 														  order by audit_date desc limit 1))tab4
-- 		 on wu.user_guid = tab4.user_guid 
         left join (SELECT string_agg(distinct(hockey_value), ',') as asc_with_hockey,user_id
            FROM labfih.labfih_web_user, 
            LATERAL jsonb_array_elements_text(asc_with_hockey ->'asc_with_hockey') as hockey_value
            group by asc_with_hockey,user_id) tab 
			on tab.user_id=wu.user_id  
         left join (SELECT user_id, string_agg(distinct((select name from waf_master.waf_countries where country_id=clubs_value::numeric)), ',') as ext_info
            FROM labfih.labfih_web_user, 
            LATERAL jsonb_array_elements_text(ext_info->'clubs') as clubs_value
            group by ext_info,user_id) tab1 
			on tab1.user_id=wu.user_id
        left join waf_master.waf_countries wc 
		on wc.country_id=wu.country_id 
		left join (select max(audit_date) as audit_date,user_guid from labfih.labfih_web_user_audit where option_type in (1,2,4,20) group by user_guid) tab_audit
		 on wu.user_guid = tab_audit.user_guid 
  where created_date between v_start_date_time and v_end_date_time ;
 
 end if;
 
 
  if v_opt_type = 3 then 
 
 select p_input_json->'jsondata'->>'entity_id',
 p_input_json->'jsondata'->>'country' into v_entity_id,v_country;
 
  if v_country=1 then
 
 open p_user_cursor for
 select po.option::jsonb->>'answer' as "Player Name",p.title as "Poll",tab1.count_as_country as "Country Wise Count",tab1.country as country_name
 from labfih.labfih_poll p join labfih.labfih_poll_option po on po.poll_id=p.poll_id
 left join (select upr.country,count(upr.country) as "count_as_country",upr.poll_id,upr.response_option_id 
        from  labfih.labfih_user_poll_response upr 
      --join labfih.labfih_web_user wu
      --on upr.user_id=wu.user_id
      group by upr.country,upr.poll_id,upr.response_option_id)tab1
  on tab1.poll_id=po.poll_id and tab1.response_option_id=po.poll_option_id
 where p.poll_id in (select asset_id from labfih.labfih_asset_entity_map 
 where asset_Type_id=6 and entity_role_map_id=v_entity_id) and p.is_active=1 and p.is_deleted=0  order by p.title,tab1.count_as_country;
 
 elsif v_country=0 or v_country is null then
 
 open p_user_cursor for
 select p.title as "Poll",po.option::jsonb->>'answer' as "Player Name",tab.count as "Total Users Count"
 from labfih.labfih_poll p join labfih.labfih_poll_option po on po.poll_id=p.poll_id
 left join (select count(po.*) as "count",po.poll_id,po.poll_option_id from labfih.labfih_user_poll_response pr 
  join labfih.labfih_poll_option po on po.poll_id=pr.poll_id and po.poll_option_id=pr.response_option_id 
 where po.poll_id in (select asset_id from labfih.labfih_asset_entity_map 
 where asset_Type_id=6 and entity_role_map_id=v_entity_id) 
       group by po.poll_id,po.poll_option_id)tab on (tab.poll_id=po.poll_id and tab.poll_option_id=po.poll_option_id)
 where p.poll_id in (select asset_id from labfih.labfih_asset_entity_map 
 where asset_Type_id=6 and entity_role_map_id=v_entity_id) and p.is_active=1 and p.is_deleted=0 order by p.title,tab.count;
 
 end if;
 
 end if;
 
 
 ---
 if v_opt_type = 4 then 
   
     select p_input_json->'jsondata'->>'poll_id'into v_entity_id;
 
 		open p_user_cursor for
  		select user_full_name,first_name,last_name,email_id,(po.option::jsonb->>'answer')::text as "Answer Voted"
 		from labfih.labfih_user_poll_response upr
 		join labfih.labfih_web_user wu
 		on upr.user_id=wu.user_id
 		join labfih.labfih_poll_option po
		on po.poll_id=upr.poll_id
 		and upr.response_option_id=po.poll_option_id
 		where po.poll_id=v_entity_id;
 
 end if;
 --
 
 
 if v_opt_type = 5 then 
   
   select p_input_json->'jsondata'->>'poll_id' into v_entity_id;
	
	delete from labfih.labfih_poll_temp;

	
	for i in 
	select poll_option_id,option from labfih.labfih_poll_option
	where poll_id = v_entity_id
	loop

	select options into v_options from (
	select b->'options' as options from (
	select b
	from json_array_elements((i.option)::json->'questions') b)as a )c
	where options is not null ;
	raise notice '%',v_options;
	select question_text into v_question from (
	select b->>'question_text' as question_text from (
	select b
	from json_array_elements((i.option)::json->'questions') b)as a )c
	where question_text is not null ;

	insert into labfih.labfih_poll_temp
	select *,i.poll_option_id,v_entity_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from labfih.labfih_poll_temp_1;
				
				    insert into labfih.labfih_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from labfih.labfih_user_poll_response pr
					left join labfih.labfih_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labfih.labfih_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_entity_id
					order by 1,2;
	
	
	perform siwaf.colpivot('data2', $$ select user_id,question,answer_display_value from labfih.labfih_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';
    open p_user_cursor for
	select user_full_name,email_id,age_group,c.name as country,
	case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as "Login Details"
	,a.*,(select response_date+'5:30 hours'::interval from labfih.labfih_user_poll_response where poll_id=v_entity_id and user_id=wu.user_id group by poll_id,response_date)
	as "Response Date"
      from data2 a
	left join labfih.labfih_web_user wu 
	on a.user_id::numeric = wu.user_id
	left join waf_master.waf_countries c 
	on c.country_id=wu.country_id
order by "Response Date" desc
	;
   
   
   end if;
 
 
 

 if v_opt_type = 6 then 
 open p_user_cursor for
  select * from siwaf.siwaf_Client_logs
  where client_name in ('labfih') order by 1 desc limit 100;
 --select * from labfih.labfih_web_user where client_id=9 order by created_date desc limit 50;

 end if;
 
 
 
-- if v_opt_type = 5 then

	
-- 	select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
--    delete from labfih.labfih_poll_temp;
	
-- 	for i in 
-- 	select poll_option_id,option from labfih.labfih_poll_option
-- 	where poll_id = v_poll_id
-- 	loop

-- 		select options into v_options from (
-- 	select b->'options' as options from (
-- 	select b
-- 	from json_array_elements((i.option)::json->'questions') b)as a )c
-- 	where options is not null ;
-- 	raise notice 'v_options %',v_options;
-- 	select question_text into v_question from (
-- 	select b->>'question_text' as question_text from (
-- 	select b
-- 	from json_array_elements((i.option)::json->'questions') b)as a )c
-- 	where question_text is not null ;

-- 	insert into labfih.labfih_poll_temp
-- 	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
-- 	as x("answer_id" numeric, "answer_display_value" text);

-- 	end loop;
-- 	                delete from labfih.labfih_poll_temp_1;
				
-- 				    insert into labfih.labfih_poll_temp_1
-- 	                select   user_id::text,question,
-- 					answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
-- 					from labfih.labfih_user_poll_response pr
-- 					left join labfih.labfih_poll_temp pt on pr.poll_id = pt.poll_id 
-- 					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
-- 					left join labfih.labfih_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
-- 					where pr.poll_id = v_poll_id
-- 					order by 1,2;
	
-- 	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value from labfih.labfih_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
--      -- raise notice '2';

--     open p_user_cursor for
-- 	select first_name,last_name,email_id,dob,a.*,tab.score
--       from data1 a
-- 	left join labfih.labfih_web_user wu on a.user_id::numeric = wu.user_id
-- 	left join (select user_id,sum(score) as score from
-- 					(select distinct user_id,question,
-- 					answer_display_value,case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 1 else 0 end as score
-- 					from labfih.labfih_user_poll_response pr
-- 					left join labfih.labfih_poll_temp pt on pr.poll_id = pt.poll_id 
-- 					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
-- 					left join labfih.labfih_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
-- 					where pr.poll_id = v_poll_id 
-- 					order by 1 desc) a
-- 					group by 1
-- 					order by 2 desc) tab on a.user_id::numeric = tab.user_id 
-- 	order by tab.score desc	;

-- 	end if;

-- if v_opt_type = 6 then

	
--      select p_input_json->'jsondata'->'poll_id' into v_poll_id;
 
--  delete from labfih.labfih_poll_temp;

	
-- 	for i in 
-- 	select poll_option_id,option from labfih.labfih_poll_option
-- 	where poll_id = v_poll_id
-- 	loop

-- 	select (i.option)::json->'options' into v_options;
-- 	select (i.option)::json->>'question_text' into v_question;

-- 	--raise notice 'v_options%',v_options;
-- 	--raise notice 'v_question%',v_question;
    
-- 	insert into labfih.labfih_poll_temp
-- 	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
-- 	as x("answer_id" numeric, "answer_display_value" text);

-- 	end loop;
     
--      	--raise notice 'v_poll_id %',v_poll_id;
	
-- 	delete from labfih.labfih_poll_temp_1;
				
-- 				    insert into labfih.labfih_poll_temp_1
-- 	                select   user_id::text,quote_literal(question),
-- 					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
-- 					from labfih.labfih_user_poll_response pr
-- 					left join labfih.labfih_poll_temp pt on pr.poll_id = pt.poll_id 
-- 					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
-- 					left join labfih.labfih_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
-- 					where pr.poll_id = v_poll_id
-- 					order by 1,2;
                    
                    
-- 	perform siwaf.colpivot('data1', $$ select * from labfih.labfih_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
-- --    perform siwaf.colpivot('vivek', $$ select user_id,question,answer_display_value from labfih.labfih_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
--      -- raise notice '2';

--     open p_user_cursor for
--  select * from data1;
-- -- 		select first_name,last_name,email_id,dob,a.* --,tab.score
-- --       from vivek a
-- -- 	left join labfih.labfih_web_user wu 
-- -- 	on a.user_id::numeric = wu.user_id;
-- 	end if;

-- if v_opt_type = 5 then

	
-- 	select p_input_json->'jsondata'->'poll_id' into v_poll_id;	
--   	delete from labfih.labfih_poll_temp;

	
-- 	for i in 
-- 	select poll_option_id,option from labfih.labfih_poll_option
-- 	where poll_id = v_poll_id
-- 	loop

-- 	select options into v_options from (
-- 	select b->'options' as options from (
-- 	select b
-- 	from json_array_elements((i.option)::json->'questions') b)as a )c
-- 	where options is not null ;

-- 	select question_text into v_question from (
-- 	select b->>'question_text' as question_text from (
-- 	select b
-- 	from json_array_elements((i.option)::json->'questions') b)as a )c
-- 	where question_text is not null ;

-- 	insert into labfih.labfih_poll_temp
-- 	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
-- 	as x("answer_id" numeric, "answer_display_value" text);

-- 	end loop;
-- 	                delete from labfih.labfih_poll_temp_1;
				
-- 				    insert into labfih.labfih_poll_temp_1
-- 	                select   user_id::text,question,
-- 					answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
-- 					from labfih.labfih_user_poll_response pr
-- 					left join labfih.labfih_poll_temp pt on pr.poll_id = pt.poll_id 
-- 					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
-- 					left join labfih.labfih_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
-- 					where pr.poll_id = v_poll_id
-- 					order by 1,2;
	
-- 	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value from labfih.labfih_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
--      -- raise notice '2';

--     open p_user_cursor for
-- 	select first_name,last_name,email_id,dob,a.*,tab.score
--       from data1 a
-- 	left join labfih.labfih_web_user wu on a.user_id::numeric = wu.user_id
-- 	left join (select user_id,sum(score) as score from
-- 					(select distinct user_id,question,
-- 					answer_display_value,case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 1 else 0 end as score
-- 					from labfih.labfih_user_poll_response pr
-- 					left join labfih.labfih_poll_temp pt on pr.poll_id = pt.poll_id 
-- 					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
-- 					left join labfih.labfih_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
-- 					where pr.poll_id = v_poll_id 
-- 					order by 1 desc) a
-- 					group by 1
-- 					order by 2 desc) tab on a.user_id::numeric = tab.user_id 
-- 	order by tab.score desc	;

-- 	end if;
 
 

 
end;

$_$;


--
