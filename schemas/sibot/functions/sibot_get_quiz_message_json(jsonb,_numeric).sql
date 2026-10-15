-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_quiz_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_quiz_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_quiz_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_event_id numeric;
    v_widget_id numeric;
    v_sport_id text;
    v_quiz_id numeric;
    v_template_id numeric;
    v_template_json jsonb;
    v_sport_count numeric;
    v_sport_name text;
    v_sport_payload_text text;
    v_template_json_arr text[];
    v_template_json_text text;
    v_quiz_category_count numeric;
    v_element_template_json jsonb;
    v_quiz_title text;
    v_quiz_sub_title text;
    v_quiz_image_url text;
    v_element_template_json_arr text[];
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_question_id numeric;
    v_play_limit numeric;
    v_question_answered_count numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_question_text text;
    v_option_template_json jsonb;
    v_option_count numeric;
    v_option_text text;
    v_option_payload_text text;
    v_option_template_json_arr text[];
    v_question_image_attachement_id text;
    v_option_id numeric;
    v_correct_answer numeric;
    v_correct_answer_text text;
    v_wrong_answer_text text;
    v_is_answer_correct numeric;
    v_message_text text;
    v_question_time timestamp;
    v_answer_time_in_seconds numeric;
    v_points numeric;
    v_points_per_second numeric;
    v_seconds_taken numeric;
    v_points_earned numeric;
    v_extra_points_earned numeric;
    v_correct_answer_attachement_id text;
    v_quiz_max_points numeric;
    v_user_points numeric;
    v_score text;
    v_score_message_text text;
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'event_id',
    		p_input_json->>'widget_id', p_input_json->>'sport_id', p_input_json->>'quiz_id', p_input_json->>'question_id', p_input_json->>'option_id'
    into v_application_id, v_receiver_id, v_user_id, v_event_id, v_widget_id, v_sport_id, v_quiz_id, v_question_id, v_option_id;
    
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
	
	/*raise notice 'v_widget_id:%',v_widget_id;
	raise notice 'v_template_id:%',v_template_id;
	raise notice 'v_template_json:%',v_template_json;
	select 1/0;*/
    
    case v_widget_id
    	
		when 401 then
        	
            drop view if exists quiz_sport_view;
            execute 'create temporary view quiz_sport_view as
            			select row_number() over() slno,aq.sport_id,s.sport_name,s.sport_payload_text
            			from sibot.sibot_application_quiz aq
            			join sibot.sibot_sport s
            			on s.sport_id = aq.sport_id
            			where aq.application_id = '||v_application_id||'
            			and aq.is_active = 1
            			group by aq.sport_id,s.sport_name,s.sport_payload_text;';
			select count(1) into v_sport_count from quiz_sport_view;
            for i in 1..v_sport_count
            loop
            	select sport_name,'GetSportQuizCategory_'||sport_payload_text||'_'||sport_id||'_null_null'
                into v_sport_name,v_sport_payload_text
                from quiz_sport_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_sport_name||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{payload}',('"'||v_sport_payload_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{content_type}',('"text"')::jsonb,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select string_agg(template_json,',') from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json_text;
            p_widget_json := ('['||v_template_json_text||']')::jsonb;
			
		when 402 then
        	
            drop view if exists quiz_category_view;
            execute 'create temporary view quiz_category_view as
            			select row_number() over(order by quiz_order) slno,quiz_id,quiz_title,quiz_sub_title,image_url
            			from sibot.sibot_application_quiz
            			where application_id = '||v_application_id||'
            			and sport_id = '||v_sport_id::numeric||'
            			and is_contest = 0
                        and is_active = 1';
            select count(1) into v_quiz_category_count from quiz_category_view;
            for i in 1..v_quiz_category_count
            loop
            	select quiz_id,quiz_title,quiz_sub_title,image_url into v_quiz_id,v_quiz_title,v_quiz_sub_title,v_quiz_image_url
                from quiz_category_view where slno = i;
            	v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_quiz_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{subtitle}',('"'||coalesce(v_quiz_sub_title,'')||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_quiz_image_url||'"')::jsonb,true);
                select button_title, event_payload||coalesce(button_payload_text,'') payload_text, button_template_id
                into v_button_title, v_button_payload_text, v_button_widget_id
                from sibot.sibot_application_event_widget_button_map aewbm
                join sibot.sibot_event e
                on e.event_id = payload_event_id
                where application_id = v_application_id and aewbm.event_id = v_event_id and widget_id = v_widget_id and is_active = 1;
                select replace(v_button_payload_text,'v_quiz_id',coalesce(v_quiz_id::text,'')) into v_button_payload_text;
                select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],('['||v_button_template_json::text||']')::jsonb,true);
                v_template_json_arr[i] := v_template_json::text;
            end loop;
            select string_agg(template_json,',') from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json_text;
            p_widget_json := ('['||v_template_json_text||']')::jsonb;
			
		when 403 then
        	
            select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = 4;
            v_question_answered_count := 0;
            
            select question_limit into v_play_limit from sibot.sibot_application_quiz where quiz_id = v_quiz_id;
            
            select question_id into v_question_id from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id and is_answered = 0 
            and include_in_scorecard = 1;
            select count(1) into v_question_answered_count from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id 
            and is_answered = 1 and include_in_scorecard = 1;
           /* raise notice 'v_template_json: %',v_template_json;
            raise notice 'v_play_limit: %',v_play_limit;

 raise notice 'v_question_id: %',v_question_id;
 raise notice 'v_question_answered_count: %',v_question_answered_count;

            select 1/0;*/
            if v_question_id is null then
                if v_play_limit > v_question_answered_count then
                	select question_id into v_question_id from sibot.sibot_quiz_question
                    where quiz_id = v_quiz_id
                    and question_id not in(select question_id 
                                           from sibot.sibot_user_quiz_play
                                           where user_id = v_user_id 
                                           and quiz_id = v_quiz_id and is_answered = 1 
                                           and include_in_scorecard = 1)
					order by random()
                    limit 1;
                    insert into sibot.sibot_user_quiz_play(user_quiz_play_id,user_id,
                                                           quiz_id,question_id,is_answered,user_answer,is_answer_correct,
                                                           include_in_scorecard,question_time)
                    values(nextval('sibot.seq_sibot_user_quiz_play_id'),v_user_id,v_quiz_id,v_question_id,0,null,null,1,v_current_timestamp);
                end if;
			end if;
            select 'Question '||(v_question_answered_count + 1)||' of '||v_play_limit||'\n\n'||replace(question_text,'"','\"') into v_question_text
            from sibot.sibot_quiz_question
            where quiz_id = v_quiz_id and question_id = v_question_id;
            v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||v_question_text||'"')::jsonb,true);
            v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::jsonb,true);
            select template_json into v_option_template_json from sibot.sibot_template where template_id = 5;
            drop view if exists quiz_question_option_view;
            execute 'create temporary view quiz_question_option_view as
            			select option_id,option_text
                        from sibot.sibot_quiz_question_option
                        where quiz_id = '||v_quiz_id||'
                        and question_id = '||v_question_id||';';
			select count(1) into v_option_count from quiz_question_option_view;
            for i in 1..v_option_count
            loop
            	select option_text,'QuizSelectOption_null_'||v_quiz_id||'_'||v_question_id||'_'||option_id
                into v_option_text,v_option_payload_text
                from quiz_question_option_view where option_id = i;
                v_option_template_json := jsonb_set(v_option_template_json,'{title}',('"'||v_option_text||'"')::jsonb,true);
                v_option_template_json := jsonb_set(v_option_template_json,'{payload}',('"'||v_option_payload_text||'"')::jsonb,true);
                v_option_template_json := jsonb_set(v_option_template_json,'{content_type}',('"text"')::jsonb,true);
                v_option_template_json_arr[i] := v_option_template_json::text;
			end loop;
            select ('['||string_agg(option_template_json,',')||']')::jsonb into v_option_template_json
            from(select option_template_json from unnest(v_option_template_json_arr) u(option_template_json))a;
            v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_option_template_json,true);
            p_widget_json := v_template_json;
            p_template_id := 0;
            
            
		when 404 then
        	
            v_question_answered_count := 0;
            select question_limit into v_play_limit from sibot.sibot_application_quiz where quiz_id = v_quiz_id;
			
            select question_id into v_question_id from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id and is_answered = 0 and include_in_scorecard = 1;
			/*raise notice 'v_question_id:%',v_question_id;
			raise notice 'v_play_limit:%',v_play_limit;*/
            if v_question_id is null then
            	select count(1) into v_question_answered_count from sibot.sibot_user_quiz_play
            	where user_id = v_user_id and quiz_id = v_quiz_id and is_answered = 1 and include_in_scorecard = 1;
                if v_play_limit > v_question_answered_count then
                	select question_id into v_question_id from sibot.sibot_quiz_question
                    where quiz_id = v_quiz_id
                    and question_id not in(select question_id from sibot.sibot_user_quiz_play
                                           where user_id = v_user_id and quiz_id = v_quiz_id and is_answered = 1 and include_in_scorecard = 1)
					order by random()
                    limit 1;
                    insert into sibot.sibot_user_quiz_play(user_quiz_play_id,user_id,quiz_id,question_id,is_answered,user_answer,is_answer_correct,
                                                           include_in_scorecard,question_time)
                    values(nextval('sibot.seq_sibot_user_quiz_play_id'),v_user_id,v_quiz_id,v_question_id,0,null,null,1,v_current_timestamp);
                end if;
			end if;
			-- select * from sibot.sibot_quiz_question
            select question_image_attachement_id into v_question_image_attachement_id
            from sibot.sibot_quiz_question
            where quiz_id = v_quiz_id and question_id = v_question_id;
			/*raise notice 'v_question_image_attachement_id : %',v_question_image_attachement_id;
              raise notice 'v_quiz_id : %',v_quiz_id;
               select 1/0;*/
            v_template_json := jsonb_set(v_template_json,('{message,attachment,payload,attachment_id}')::text[],
                                         ('"'||v_question_image_attachement_id||'"')::jsonb,true);
            /* raise notice 'v_template_json : %',v_template_json;
               select 1/0;*/
			v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            p_template_id := 0;
			--raise notice 'p_widget_json : %',p_widget_json;
             -- raise notice 'v_quiz_id : %',v_quiz_id;
			 --select 1/0;
            
		when 405 then
        	
            select correct_answer,replace(correct_answer_text,'"','\"'),
            replace(wrong_answer_text,'"','\"')
            into v_correct_answer,v_correct_answer_text,v_wrong_answer_text
            from sibot.sibot_quiz_question
            where quiz_id = v_quiz_id and question_id = v_question_id;
            
            /*raise notice ':v_correct_answer: %',v_correct_answer;
            raise notice ':v_option_id: %',v_option_id;
            raise notice ':v_correct_answer_text: %',v_correct_answer_text;
            raise notice ':v_wrong_answer_text: %',v_wrong_answer_text;
            select 1/0;*/
            if v_option_id = v_correct_answer then
            	v_is_answer_correct := 1;
                v_message_text := v_correct_answer_text;
                select question_time into v_question_time
                from sibot.sibot_user_quiz_play where user_id = v_user_id
                and quiz_id = v_quiz_id and question_id = v_question_id;
                /*select coalesce(answer_time_in_seconds,0), points, coalesce(points_per_second,0)
                into v_answer_time_in_seconds v_points_per_second
                from sibot.sibot_application_quiz
                where quiz_id = v_quiz_id;*/
               /* select round(((date_part('day', b - a) * 24 + DATE_PART('hour', b - a)) * 60 + DATE_PART('minute', b - a)) * 60
                             + DATE_PART('second', b - a))::numeric into v_seconds_taken
				from (select v_question_time a ,v_current_timestamp b) c;*/
               /*select is_answer_correct into v_points  from sibot.sibot_user_quiz_play where user_id =121734
                and quiz_id=1 and is_answered=1 and include_in_scorecard=1;*/
                v_points_earned := 1;
                /*if v_seconds_taken <= v_answer_time_in_seconds then
                	v_extra_points_earned := (v_answer_time_in_seconds - v_seconds_taken) * v_points_per_second;
                	v_points_earned := v_points_earned + v_extra_points_earned;
                    v_message_text := v_message_text||'\n\n'||'Congrats!! You got '||v_extra_points_earned||' extra points for answering before '
                    					||v_answer_time_in_seconds::text||' seconds.';
                end if;*/
			else
            	v_is_answer_correct := 0;
                v_message_text := v_wrong_answer_text;
                v_points_earned := 0;
               /* raise notice ':v_is_answer_correct: %',v_is_answer_correct;
            raise notice ':v_message_text: %',v_message_text;
            raise notice ':v_points_earned: %',v_points_earned;
            select 1/0;*/
            end if;
            update sibot.sibot_user_quiz_play
            set user_answer = v_option_id, is_answered = 1,
            is_answer_correct = v_is_answer_correct, 
            answer_time = v_current_timestamp,
            	points = v_points_earned
              -- include_in_scorecard = 1 
            where user_id = v_user_id and quiz_id = v_quiz_id and question_id = v_question_id;
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            /*raise notice 'p_widget_json : %',p_widget_json;
          raise notice 'p_template_id : %',p_template_id;
               select 1/0;*/
		when 406 then
        	
            select correct_answer_attachement_id into v_correct_answer_attachement_id
            from sibot.sibot_quiz_question
            where quiz_id = v_quiz_id and question_id = v_question_id;
            
            -- raise notice 'v_correct_answer_attachement_id : %',v_correct_answer_attachement_id;
         
            v_template_json := jsonb_set(v_template_json,('{message,attachment,payload,elements,0,attachment_id}')::text[],
                                         ('"'||v_correct_answer_attachement_id||'"')::jsonb,true);
			v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            p_template_id := 0;
          /*  raise notice 'p_widget_json : %',p_widget_json;
          raise notice 'p_template_id : %',p_template_id;
               select 1/0;*/
		when 407 then
        	
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id and is_active = 1;
            
            v_template_json := jsonb_set(v_template_json,'{scorecard_template,0,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);

            v_template_json := jsonb_set(v_template_json,'{scorecard_template,0,0,message,text}',('"'||v_message_text||'"')::jsonb,true);
                            
		
            select quiz_title -- ,(question_limit * ((coalesce(answer_time_in_seconds,0) * coalesce(points_per_second,0)) + points))
            into v_quiz_title -- , v_quiz_max_points
            from sibot.sibot_application_quiz where quiz_id = v_quiz_id;
            

            select sum(points) into v_user_points
            from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id 
            and include_in_scorecard = 1;
            v_quiz_max_points:=5;
            v_score := v_user_points||' / '||v_quiz_max_points;
            
                        /*raise notice 'v_user_points : %',v_user_points;
            raise notice 'v_score : %',v_score;
               select 1/0;*/
            v_score_message_text := '';
            v_template_json := jsonb_set(v_template_json,'{quiz_title}',('"'||v_quiz_title||'"')::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{score}',('"'||v_score||'"')::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{score_message}',('"'||v_score_message_text||'"')::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{scorecard_template,1,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{scorecard_template,1,0,message,attachment,payload,elements,0,title}',('"'||v_quiz_title||'"')::jsonb,true);
            
            /*raise notice ':v_template_json: %',v_template_json;
            select 1/0;*/
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
               /*raise notice ':v_button_count: %',v_button_count;
            select 1/0;*/
            for j in 1..v_button_count
            loop
            	select button_title, payload_text, button_template_id
                into v_button_title, v_button_payload_text, v_button_widget_id
                from event_widget_button_view where slno = j;
                /*raise notice ':v_button_title: %',v_button_title;
                raise notice ':v_button_payload_text: %',v_button_payload_text;
                raise notice ':v_button_widget_id: %',v_button_widget_id;*/
            
                select replace(v_button_payload_text,'v_quiz_id',
                               coalesce(v_quiz_id::text,'')) into 
                               v_button_payload_text;
                        
                               
                select template_id into v_template_id from 
                sibot.sibot_widget where widget_id = v_button_widget_id;
               -- raise notice ':v_template_id: %',v_template_id;       
                select template_json into v_button_template_json from 
                sibot.sibot_template where template_id = v_template_id;
               -- raise notice ':v_button_template_json: %',v_button_template_json;
                v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                v_button_template_json_arr[j] := v_button_template_json::text;
			end loop;
             
              /* raise notice ':v_button_template_json: %'
               ,v_button_template_json;
            select 1/0;*/
            select ('['||string_agg(button_template_json,',')||']')::jsonb
            from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a
            into v_button_template_json;
            v_template_json := jsonb_set(v_template_json,('{scorecard_template,1,0,message,quick_replies}')::text[],v_button_template_json,true);
            
            update sibot.sibot_user_quiz_play set include_in_scorecard = 0
            where user_id = v_user_id and quiz_id = v_quiz_id and 
            include_in_scorecard = 1;
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            /*raise notice 'p_widget_json : %',p_widget_json;
          raise notice 'p_template_id : %',p_template_id;
               select 1/0;*/
	  when 408 then
	   /*raise notice 'v_widget:%',v_widget_id;
	   raise notice 'v_parent_template_id:%',v_parent_template_id;
	   select 1/0;*/
               	select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template 
				        where template_id = v_parent_template_id;
                	v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
                	select message_text into v_message_text
                    from sibot.sibot_application_event_widget_message
                	where application_id = v_application_id and event_id = v_event_id and is_active = 1
                	and widget_id in(select widget_id from sibot.sibot_widget where template_id = v_template_id);
                	v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
                	
                	drop view if exists event_widget_button_view;
                    	execute 'create temporary view event_widget_button_view as
                         		select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                   		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                                	join sibot.sibot_event e
                                	on e.event_id = payload_event_id
                                	where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                                	' and is_active = 1
                                   group by button_title, event_payload||coalesce(button_payload_text,''''), button_template_id, button_order';
					select count(1) into v_button_count from event_widget_button_view;
                    	for j in 1..v_button_count
                    	loop
                    		select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                        		from event_widget_button_view where slno = j;
                        		
                        		select replace(v_button_payload_text,'v_quiz_id',coalesce(v_quiz_id::text,'')) into v_button_payload_text;
                        		select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                        		select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                        		v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        		v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                        		v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    	select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                    	from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                    	v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
				
				
                	
              
	  
		else
        	null;
			
		end case;
        
end;

$$;


--
