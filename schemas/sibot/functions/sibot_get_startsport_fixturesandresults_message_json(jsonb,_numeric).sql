-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_startsport_fixturesandresults_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_startsport_fixturesandresults_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_startsport_fixturesandresults_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_module_id numeric := 11;
    v_event_id numeric;
	v_widget_id numeric;
    v_template_id numeric;
    v_parent_template_id numeric;
    v_template_json jsonb;
    v_template_json_arr text[];
    v_fullschedule_count numeric;
    v_team_id text;
    v_title text;
    v_image_url text;
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_url text;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_match_count numeric;
    v_match_id numeric;
    v_match_status numeric;
    v_matchcentre_url text;
    v_matchstory_url text;
    v_url text;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_image_attachment_id text;
    v_message_condition_id numeric;
    v_message_text text;
    v_team_name text;
    v_team_a_id numeric;
    v_team_b_id numeric;
    v_team_a_name text;
    v_team_b_name text;
    v_league_id numeric;
    v_filter_query text := ' ';
    v_current_result_query text := ' ';
    v_upcoming_match_limit numeric;
    v_teams_array numeric[];
    v_league_schedule_image_attachment_id text;
    v_count numeric;
    limit_value numeric;
	v_i numeric;
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'event_id', p_input_json->>'widget_id',
    		p_input_json->>'team_id', p_input_json->>'league_id'
    into v_application_id, v_receiver_id, v_user_id, v_event_id, v_widget_id, v_team_id, v_league_id;
    
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
    if v_application_id=1 then
   -- v_league_id =30; /*for ipl*/
	-- v_league_id =48; /*for icc world cup*/
	v_league_id =49; /*for Pkl*/
    end if;
    case v_widget_id
    	
        when 1101 then
        	
           v_template_json := jsonb_set(v_template_json,('{recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
            select league_schedule_image_attachment_id into v_league_schedule_image_attachment_id
            from sibot.sibot_application_league_map
            where application_id = v_application_id
            and league_id = v_league_id;
            v_template_json := jsonb_set(v_template_json,('{message,attachment,payload,attachment_id}')::text[],
                                         ('"'||v_league_schedule_image_attachment_id||'"')::text::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
			
		when 1102 then
	/*	raise notice 'v_widget_id:%',v_widget_id;
		raise notice 'v_league_id:%',v_league_id;
		select 1/0;*/
		v_i :=1;
        	drop view if exists team_view;
			execute 'create temporary view team_view as
			         select * from (select 1 as slno, t.team_id, t.team_name, amltm.team_image_url
                        from sibot.sibot_application_module_league_team_map amltm
                        join sibot.sibot_team t
                        on t.team_id = amltm.team_id
                       where amltm.application_id = '||v_application_id
                        ||' and amltm.module_id = '||v_module_id
                        ||' and amltm.league_id = '||v_league_id
                        ||' and t.team_name is not null
                        and amltm.team_image_url is not null
						and  t.team_name= ''All Teams''
                  union

                       select row_number() over(order by a.team_name) + '||v_i||' as slno, a.team_id, a.team_name, a.team_image_url
						      from (select t.team_id, t.team_name, amltm.team_image_url
													from sibot.sibot_application_module_league_team_map amltm
													join sibot.sibot_team t
													on t.team_id = amltm.team_id
													where amltm.application_id = '||v_application_id
													||' and amltm.module_id = '||v_module_id
													||' and amltm.league_id = '||v_league_id
													||' and t.team_name is not null
													and amltm.team_image_url is not null
													and  t.team_name <> ''All Teams'' order by team_name)a) b order by team_id';

            /*execute 'create temporary view team_view as
            			select row_number() over(order by t.team_name) slno, t.team_id, t.team_name, amltm.team_image_url
                        from sibot.sibot_application_module_league_team_map amltm
                        join sibot.sibot_team t
                        on t.team_id = amltm.team_id
                       	where amltm.application_id = '||v_application_id
                        ||' and amltm.module_id = '||v_module_id
                        ||' and amltm.league_id = '||v_league_id
                        ||' and t.team_name is not null
                        and amltm.team_image_url is not null';*/
            select count(1) into v_count from team_view;
            -- raise notice 'v_count : %',v_count;
             -- raise notice 'v_count : %',v_count;
           -- select 1/0;
            for i in 1..v_count
            loop
            	v_button_template_json_arr := null;
                select team_id, team_name, team_image_url into v_team_id, v_title, v_image_url
                from team_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                            		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            left join sibot.sibot_event e
                            on e.event_id = payload_event_id
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id <> 4 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	 v_button_template_json := null;
                	select button_title, payload_text||'_null_'||v_league_id||'_'||v_team_id||'_null', button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                     v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
            
            -- raise notice  'p_widget_json : %',p_widget_json;
             /*raise notice 'v_team_id : %',v_team_id;
              raise notice 'v_widget_id : %',v_widget_id;
             raise notice 'v_application_id : %',v_application_id;
              raise notice 'v_event_id  : %',v_event_id;*/
             --  select 1/0;
            
		when 1103 then
        
     /* raise notice  'v_league_id : %',v_league_id;
             raise notice 'v_team_id : %',v_team_id;
              raise notice 'v_widget_id : %',v_widget_id;
             raise notice 'v_application_id : %',v_application_id;
              raise notice 'v_event_id  : %',v_event_id;
               select 1/0;*/
        	if v_team_id ='0' then
                 v_filter_query := ' ';
			else
            	v_filter_query := ' and ((team_a_id ='||v_team_id
                                 ||'::numeric) or
                                    (team_b_id = '||v_team_id
                                 ||'::numeric)) and amm.match_schedule_image_url is not null
                                 and m.status=1';
             end if;
           /*raise notice 'v_filter_query : %',v_filter_query;
             -- raise notice 'v_event_id  : %',v_event_id;
               select 1/0;*/
              
            drop view if exists fixtures_view;
            execute 'create temporary view fixtures_view as
            			select row_number() over(order by m.match_start_date) slno,
                                    m.match_name,amm.match_schedule_image_url
                                    from sibot.sibot_match m 
                                    join
                                    sibot.sibot_application_match_map amm
                                    on m.match_id = amm.match_id
                                    where m.league_id ='||v_league_id
                                 ||' and amm.application_id = '||v_application_id
                                 ||' and m.match_end_date >= '''||v_current_timestamp||'''
                                 and amm.match_schedule_image_url is not null
                                 and m.status=1 
                                  '||v_filter_query
                                 ||' 
                                 limit 3';
           
            select count(1) into v_count from fixtures_view;
            
             /*raise notice 'v_count : %',v_count;
             -- raise notice 'v_event_id  : %',v_event_id;
               select 1/0;*/
            for i in 1..v_count
            loop
                select  match_name, match_schedule_image_url into  v_title, v_image_url
                from fixtures_view where slno = i;
                
                /*raise notice 'v_title : %',v_title;
             raise notice 'v_image_url  : %',v_image_url;
               select 1/0;*/
                
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                
                 
                 drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_template_id, row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id = 5 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	select button_template_id into v_button_widget_id from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
               
                /*raise notice 'v_title : %',v_title;
             raise notice 'v_template_json  : %',v_template_json;
               select 1/0;*/
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
            
           /* raise notice 'p_widget_json : %',p_widget_json;
             -- raise notice 'v_event_id  : %',v_event_id;
               select 1/0;*/
            
            
            
            
		/* when 1104 then
        	
            if v_team_id ='0' then
                 v_filter_query := ' ';
			else
            	v_filter_query := ' and (team_a_id ='||v_team_id
                                 ||'::numeric) or
                                    (team_b_id = '||v_team_id
                                 ||'::numeric)
                                 and amm.match_result_image_url is not null';
             end if;
             
            if exists ( select * from sibot.sibot_match where current_timestamp
                  between match_start_date and match_end_date
                  and league_id = v_league_id
                  and status =1
                   ) then
                v_current_result_query := ' union 
                                          select 4 slno,
                                          m.match_name,mp.match_result_image_url from sibot.sibot_match m
                                          join sibot.sibot_application_match_map mp
                                          on m.match_id = mp.match_id
                                          where application_id ='||v_application_id
                                          ||' and current_timestamp
                                          between match_start_date and match_end_date
                                         and league_id ='||v_league_id
                                         ||' and mp.match_result_image_url is not null
                                         and m.status=1
                                        '||v_filter_query
                                         ||' ';
                         limit_value:=4;
             else
             v_current_result_query := ' ';
             limit_value:=3;
             end if;
              
             -- raise notice 'limit_value : %',limit_value;
             -- raise notice 'v_event_id  : %',v_event_id;
              -- select 1/0;
           
              
            drop view if exists results_view;
            execute 'create temporary view results_view as
            			select row_number() over(order by m.match_start_date desc) slno,
                                    m.match_name,amm.match_result_image_url
                                    from sibot.sibot_match m 
                                    join sibot.sibot_application_match_map amm
                                    on m.match_id = amm.match_id
                                    where m.league_id ='||v_league_id
                                 ||' and amm.application_id = '||v_application_id
                                 ||' and m.match_end_date <= '''||v_current_timestamp||'''
                                     and amm.match_result_image_url is not null
                                     and m.status=1
                                 '||v_filter_query||'  
                                '||v_current_result_query
                                 ||' limit '||limit_value
                                 ||'' ;
       
            select count(1) into v_count from results_view;
            
             
            for i in 1..v_count
            loop
                select  match_name, match_result_image_url into  v_title, v_image_url
                from results_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                 drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_template_id, row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id = 5 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                
                
                for j in 1..v_button_count
                loop
                	select button_template_id into v_button_widget_id from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;*/
            
            when 1104 then
        	
            if v_team_id ='0' then
                 v_filter_query := ' ';
			else
            	v_filter_query := ' and ((team_a_id ='||v_team_id
                                 ||'::numeric) or
                                    (team_b_id = '||v_team_id
                                 ||'::numeric))';
             end if;
             
            if exists ( 
select * from sibot.sibot_match m join
sibot.sibot_application_match_map mp
on m.match_id =mp.match_id
where  m.league_id = v_league_id and m.status=1 and mp.match_result_image_url is not null
                                 and current_timestamp
                  between m.match_start_date and m.match_end_date
                   ) then
                v_current_result_query :=' union
                                          select * from (select  1 as status,row_number() over(order by match_end_date desc)
                                 as numbers,
                                          m.match_name,mp.match_result_image_url,m.match_end_date
                                          from sibot.sibot_match m
                                          join sibot.sibot_application_match_map mp
                                          on m.match_id = mp.match_id
                                          where application_id ='||v_application_id
                                          ||'
                                          and current_timestamp
                                          between match_start_date and match_end_date
                                          and league_id ='||v_league_id
                                         ||' '||v_filter_query
                                         ||'and mp.match_result_image_url is not null
                                          and m.status=1  limit 1)a';
                         limit_value:=4;
             else
             v_current_result_query := ' ';
             limit_value:=3;
             end if;
              
             /* raise notice 'limit_value : %',limit_value;
              raise notice 'v_current_result_query  : %',v_current_result_query;
              select 1/0;*/
           
              
            drop view if exists results_view;
            execute 'create temporary view results_view as
            			     select row_number() over(order by status, numbers) as slno,*
                                 from (select 2 as status,row_number() over(order by match_end_date desc)
                                 as numbers,
                                    m.match_name,amm.match_result_image_url,m.match_end_date
                                    from sibot.sibot_match m 
                                    join sibot.sibot_application_match_map amm
                                    on m.match_id = amm.match_id
                                    where m.league_id ='||v_league_id
                                 ||'
                                    and amm.application_id = '||v_application_id
                                 ||'
                                    and m.match_end_date <= '''||v_current_timestamp||'''
                                    '||v_filter_query||'
                                     and amm.match_result_image_url is not null
                                     and m.status=1
                                         
                                '||v_current_result_query
                                 ||' )as tab order by slno limit '||limit_value
                                 ||'' ;
         -- raise notice 'results_view : %',results_view;
             -- raise notice 'v_filter_query  : %',v_filter_query;
              -- select 1/0;
            select count(1) into v_count from results_view;
            
              -- raise notice 'v_count : %',v_count;
             -- raise notice 'v_event_id  : %',v_event_id;
              -- select 1/0;
            for i in 1..v_count
            loop
                select  match_name, match_result_image_url into  v_title, v_image_url
                from results_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                 drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_template_id, row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id = 5 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                
                 /*raise notice 'v_button_count : %',v_button_count;
             -- raise notice 'v_event_id  : %',v_event_id;
               select 1/0;*/
                for j in 1..v_button_count
                loop
                	select button_template_id into v_button_widget_id from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
            
            -- raise notice 'p_widget_json : %',p_widget_json;
             -- raise notice 'v_event_id  : %',v_event_id;
             -- select 1/0;
      when 1105 then
      
      
        	
           /* -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id 
            and widget_id = v_widget_id ;
            select team_name into v_team_name from sibot.sibot_team 
            where team_id = v_team_id::numeric and team_name is not null;
            
            v_message_text := replace(v_message_text,'<teamname>',v_team_name);
            
            
            
            select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
            select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_template_id;
           -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            v_template_json := jsonb_set(v_template_json,'{0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{0,message,text}',('"'||v_message_text||'"')::jsonb,true);
                    p_widget_json := v_template_json;*/
                    
                    select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id
            and widget_id = v_widget_id ;
            select team_name into v_team_name from sibot.sibot_team where
            team_id = v_team_id::numeric and team_name is not null;
            v_message_text := replace(v_message_text,'<teamname>',v_team_name);
            select parent_template_id into v_parent_template_id from 
            sibot.sibot_widget where widget_id = v_widget_id;
            select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
           -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            v_template_json := jsonb_set(v_template_json,'{0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{0,message,text}',('"'||v_message_text||'"')::jsonb,true);
            drop view if exists event_widget_button_view;
                    execute 'create temporary view event_widget_button_view as
                    			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                		row_number() over(order by button_order) slno
								from sibot.sibot_application_event_widget_button_map aewbm
                                join sibot.sibot_event e
                                on e.event_id = payload_event_id
                                where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                                ' and is_active = 1';
					select count(1) into v_button_count from event_widget_button_view;
                    for j in 1..v_button_count
                    loop
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                        from event_widget_button_view where slno = j;
                        select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                        select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                        v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        select replace(v_button_payload_text,'v_league_id',v_league_id::text) into v_button_payload_text;
                        v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                    from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                    v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
                    p_template_id := 0;
                    p_widget_json := v_template_json;
          
            /*raise notice 'p_widget_json:%',p_widget_json;
            select 1/0;*/
            
		else
        	null;
            
    end case;
    
end;

$$;


--
