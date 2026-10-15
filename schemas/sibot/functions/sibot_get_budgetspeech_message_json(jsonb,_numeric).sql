-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_budgetspeech_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_budgetspeech_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_budgetspeech_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_application_id numeric;
     v_receiver_id text;
     v_user_id numeric;
     v_event_id numeric;
	v_widget_id numeric;
     v_template_id numeric;
     v_parent_template_id numeric;
     v_category char(1);
     v_category_id numeric;
     v_change_option text;
     v_change_value decimal;
     v_bs_scenario_id numeric;
     v_template_json jsonb;
     
     v_message_text text;
     v_priority numeric;
     v_target_amount numeric;
     v_category_name text;
     v_minimum_amount numeric;
     v_maximum_amount numeric;
     v_base_amount numeric;
     v_button_count numeric;
     v_button_title text;
     v_button_payload_text text;
     v_button_widget_id numeric;
    	v_button_template_id numeric;
    	v_button_template_json jsonb;
    	v_button_template_json_arr text[];
     v_image_id text;
     v_income_change_options numeric[];
     v_template_json_arr text[];
     v_template_json_text text;
     v_amount numeric;
     v_total_income numeric;
     v_total_spend numeric;
     v_balance_amount numeric;
     v_next_category_name text;
     
begin
	
    	select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'event_id',
     		p_input_json->>'widget_id', p_input_json->>'template_id', p_input_json->>'parent_template_id', p_input_json->>'bs_category',
               p_input_json->>'bs_category_id', p_input_json->>'bs_change_option', p_input_json->>'bs_change_value',
			p_input_json->>'bs_scenario_id'
    	into v_application_id, v_receiver_id, v_user_id, v_event_id, v_widget_id, v_template_id, v_parent_template_id, v_category, v_category_id,
     	v_change_option, v_change_value, v_bs_scenario_id;
     
     select ('['||template_json::text||']')::jsonb into v_template_json
     from sibot.sibot_template where template_id = case v_parent_template_id when 0 then v_template_id else v_parent_template_id end;
    	
    	case v_widget_id
     	
          when 901 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               with tab1 as (select category_id,category,minimum_amount,maximum_amount,
                             			ceil(random()*(maximum_amount-minimum_amount)+minimum_amount)::numeric as base_amount,0 as spend_percentage,
                             			0 as target_amount
                             from sibot.sibot_bs_income_spend_category
                             where category = 'I'),
				tab2 as (select sum(base_amount) as total_base_income from tab1),
                    tab3 as (select row_number() over(order by random()) as spend_id, spend_percentage from unnest(array[10,15,20,25,30]) u(spend_percentage))
			insert into sibot.sibot_bs_user_budget
			select nextval('sibot.seq_sibot_bs_user_budget_id') as user_budget_id,v_user_id,category_id,category,
					case when v_category_id = category_id and category = 'S' then 1 else 0 end as is_priority,base_amount,target_amount,null,null,null
			from (select * from tab1
                     union
                     select category_id,category,minimum_amount,maximum_amount,base_amount,spend_percentage,
                     		case when target_amount <= maximum_amount then target_amount else (maximum_amount - 20) end as target_amount
                     from (select category_id,category,minimum_amount,maximum_amount,base_amount,spend_percentage,
                           		trunc(base_amount*(cast((1+(spend_percentage::decimal/100)) as double precision))) as target_amount
                           from (select category_id,category,minimum_amount,maximum_amount,
                                 		(select trunc((total_base_income*t3.spend_percentage)/100) from tab2) as base_amount,t3.spend_percentage
                                 from sibot.sibot_bs_income_spend_category isc
                                 join tab3 t3
                                 on spend_id = isc.category_id
                                 where category = 'S'
                                ) as tab4
                          ) as tab5
                    ) as tab6
			order by category, category_id;
               select isc.category_name, ub.target_amount into v_category_name, v_target_amount
               from sibot.sibot_bs_user_budget ub
               join sibot.sibot_bs_income_spend_category isc
               on isc.category_id = ub.category_id
               and isc.category = ub.category
               where isc.category = 'S'
               and ub.is_priority = 1
               and ub.user_id = v_user_id
               and ub.category = v_category;
               select replace(v_message_text,'v_category_name',v_category_name::text) into v_message_text;
               select replace(v_message_text,'v_amount',v_target_amount::text) into v_message_text;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
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
               for i in 1..v_button_count
               loop
               	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = i;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[i] := v_button_template_json::text;
			end loop;
               select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
               from (select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
               v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
               p_template_id := 0;
               p_widget_json := v_template_json;
			
		when 902 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               select sum(base_amount) into v_total_income from sibot.sibot_bs_user_budget where user_id = v_user_id and category = 'I';
               select sum(base_amount) into v_total_spend from sibot.sibot_bs_user_budget where user_id = v_user_id and category = 'S';
               v_balance_amount := v_total_income - v_total_spend;
               v_message_text := replace(v_message_text,'v_balance_amount',v_balance_amount::text);
               drop view if exists user_budget_view;
               execute 'create temporary view user_budget_view as
               		select category_id, category, base_amount, row_number() over(order by category, category_id) as slno
					from sibot.sibot_bs_user_budget
                         where user_id = '||v_user_id;
			for i in 1..10
               loop
               	select category_id, category, base_amount
                    into v_category_id, v_category, v_base_amount
                    from user_budget_view where slno = i;
                    case i
                    	when 1 then
                         	select replace(v_message_text,'v_it_amount',v_base_amount::text) into v_message_text;
                         when 2 then
                         	select replace(v_message_text,'v_vat_amount',v_base_amount::text) into v_message_text;
                         when 3 then
                         	select replace(v_message_text,'v_sin_amount',v_base_amount::text) into v_message_text;
                         when 4 then
                         	select replace(v_message_text,'v_flt_amount',v_base_amount::text) into v_message_text;
                         when 5 then
                         	select replace(v_message_text,'v_ct_amount',v_base_amount::text) into v_message_text;
                         when 6 then
                         	select replace(v_message_text,'v_sg_amount',v_base_amount::text) into v_message_text;
                         when 7 then
                         	select replace(v_message_text,'v_e_amount',v_base_amount::text) into v_message_text;
                         when 8 then
                         	select replace(v_message_text,'v_hc_amount',v_base_amount::text) into v_message_text;
                         when 9 then
                         	select replace(v_message_text,'v_p_amount',v_base_amount::text) into v_message_text;
                         when 10 then
                         	select replace(v_message_text,'v_ed_amount',v_base_amount::text) into v_message_text;
                    end case;
               end loop;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
               p_template_id := 1;
               p_widget_json := v_template_json;
			
		when 903, 910 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               select isc.category_id, isc.category_name, ub.is_priority, ub.target_amount
               into v_category_id, v_category_name, v_priority, v_target_amount
               from sibot.sibot_bs_user_budget ub
               join sibot.sibot_bs_income_spend_category isc
               on isc.category_id = ub.category_id and isc.category = ub.category
               where ub.user_id = v_user_id and isc.category = v_category and ub.change_option is null
               order by ub.category_id
               limit 1;
               select replace(v_message_text,'v_category_name',v_category_name::text) into v_message_text;
               if v_category = 'S' and v_priority = 1 then
               		v_message_text := v_message_text||'\nYour goal is to increase '||v_category_name||' spend to R'||v_target_amount||'bn, while making sure the other areas of the budget are also in good standing.';
               end if;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
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
               for i in 1..v_button_count
               loop
               	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = i;
                    v_button_payload_text := replace(v_button_payload_text,'v_category_id',v_category_id::text);
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[i] := v_button_template_json::text;
			end loop;
               select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
               from (select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
               v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
               p_template_id := 0;
               p_widget_json := v_template_json;
			
		when 904 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               v_message_text := replace(v_message_text,'v_change_option',(case v_change_option when 'I' then 'increase' when 'D' then 'decrease' end)::text);
               select category_name into v_category_name from sibot.sibot_bs_income_spend_category where category = 'I' and category_id = v_category_id;
               v_message_text := replace(v_message_text,'v_category_name',v_category_name::text);
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
               select income_change_options into v_income_change_options
               from sibot.sibot_bs_income_spend_category
               where category = 'I' and category_id = v_category_id;
            	for i in 1..array_length(v_income_change_options,1)
            	loop
               	select template_json into v_button_template_json from sibot.sibot_template where template_id = v_template_id;
               	select v_income_change_options[i]::text||'%', 'BSBudgetAfterIncomeChange_I_'||v_category_id||'_'||v_change_option||'_'||i
                	into v_button_title, v_button_payload_text;
                	v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                	v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                	v_button_template_json_arr[i] := v_button_template_json::text;
			end loop;
            	select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
               from (select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
               v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
            	p_template_id := 0;
               p_widget_json := v_template_json;
               
          when 905,912 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select category_image_attachment_id into v_image_id
               from sibot.sibot_bs_income_spend_category
               where category = v_category and category_id = v_category_id;
               v_template_json := jsonb_set(v_template_json,('{0,message,attachment,payload,attachment_id}')::text[],('"'||coalesce(v_image_id,'')||'"')::text::jsonb,true);
               p_template_id := 0;
               p_widget_json := v_template_json;
               
		when 906,913 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select category_description into v_message_text
               from sibot.sibot_bs_income_spend_category
               where category = v_category and category_id = v_category_id;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
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
               for i in 1..v_button_count
               loop
               	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = i;
                    v_button_payload_text := replace(v_button_payload_text,'v_category_id',v_category_id::text);
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[i] := v_button_template_json::text;
			end loop;
               select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
               from (select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
               v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
               p_template_id := 0;
               p_widget_json := v_template_json;
               
		when 907 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               select isc.category_name, ub.base_amount, isc.income_change_options into v_category_name, v_amount, v_income_change_options
               from sibot.sibot_bs_user_budget ub
               join sibot.sibot_bs_income_spend_category isc
               on isc.category_id = ub.category_id
               and isc.category = ub.category
               where ub.user_id = v_user_id and ub.category_id = v_category_id and ub.category = v_category;
               v_change_value := (v_income_change_options[v_change_value::numeric])::decimal;
               if v_change_option = 'I' then
               	v_amount := ceil(v_amount*(cast((1+(v_change_value/100)) as double precision)));
               elsif v_change_option = 'D' then
               	v_amount := v_amount - trunc(v_amount*(cast((v_change_value/100) as double precision)));
               end if;
               update sibot.sibot_bs_user_budget
               set change_option = v_change_option, change_value = v_amount
               where user_id = v_user_id and category_id = v_category_id and category = v_category;
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               v_message_text := replace(v_message_text,'v_change_option',(case v_change_option when 'I' then 'increased' when 'D' then 'decreased' end)::text);
               v_message_text := replace(v_message_text,'v_category_name',v_category_name::text);
               v_message_text := replace(v_message_text,'v_change_percentage',v_change_value::text);
               select sum(coalesce(change_value,base_amount)) into v_total_income
               from sibot.sibot_bs_user_budget
               where user_id = v_user_id and category = 'I';
               select sum(coalesce(change_value,base_amount)) into v_total_spend
               from sibot.sibot_bs_user_budget
               where user_id = v_user_id and category = 'S';
               v_balance_amount := v_total_income - v_total_spend;
               v_message_text := replace(v_message_text,'v_balance_amount',v_balance_amount::text);
               drop view if exists user_budget_view;
               execute 'create temporary view user_budget_view as
               		select category_id, category, coalesce(change_value, base_amount) as amount, row_number() over(order by category, category_id) as slno
					from sibot.sibot_bs_user_budget
                         where user_id = '||v_user_id;
			for i in 1..10
               loop
               	select category_id, category, amount into v_category_id, v_category, v_amount
                    from user_budget_view where slno = i;
                    case i
                    	when 1 then
                         	select replace(v_message_text,'v_it_amount',v_amount::text) into v_message_text;
                         when 2 then
                         	select replace(v_message_text,'v_vat_amount',v_amount::text) into v_message_text;
                         when 3 then
                         	select replace(v_message_text,'v_sin_amount',v_amount::text) into v_message_text;
                         when 4 then
                         	select replace(v_message_text,'v_flt_amount',v_amount::text) into v_message_text;
                         when 5 then
                         	select replace(v_message_text,'v_ct_amount',v_amount::text) into v_message_text;
                         when 6 then
                         	select replace(v_message_text,'v_sg_amount',v_amount::text) into v_message_text;
                         when 7 then
                         	select replace(v_message_text,'v_e_amount',v_amount::text) into v_message_text;
                         when 8 then
                         	select replace(v_message_text,'v_hc_amount',v_amount::text) into v_message_text;
                         when 9 then
                         	select replace(v_message_text,'v_p_amount',v_amount::text) into v_message_text;
                         when 10 then
                         	select replace(v_message_text,'v_ed_amount',v_amount::text) into v_message_text;
                    end case;
               end loop;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
            	p_template_id := 0;
               p_widget_json := v_template_json;
               
               
		when 908, 909 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               select isc.category_name into v_category_name
               from sibot.sibot_bs_user_budget ub
               join sibot.sibot_bs_income_spend_category isc
               on isc.category_id = ub.category_id
               and isc.category = ub.category
               where ub.user_id = v_user_id and ub.category_id = v_category_id and ub.category = v_category;
               if v_widget_id = 908 then
               	select category_name into v_next_category_name
               	from sibot.sibot_bs_income_spend_category
               	where category_id = (v_category_id + 1) and category = v_category;
               	v_message_text := replace(v_message_text,'v_next_category_name',v_next_category_name::text);
               end if;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
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
               for i in 1..v_button_count
            	loop
               	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = i;
                    v_button_title := replace(v_button_title,'v_category_name',v_category_name::text);
                    v_button_payload_text := replace(v_button_payload_text,'v_category_id',v_category_id::text);
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[i] := v_button_template_json::text;
			end loop;
            	select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
               from (select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
               v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
            	p_template_id := 0;
               p_widget_json := v_template_json;
               
		when 911 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               select isc.category_name into v_category_name
               from sibot.sibot_bs_user_budget ub
               join sibot.sibot_bs_income_spend_category isc
               on isc.category_id = ub.category_id
               and isc.category = ub.category
               where ub.user_id = v_user_id and ub.category_id = v_category_id and ub.category = v_category;
               v_message_text := replace(v_message_text,'v_change_option',(case v_change_option when 'I' then 'increase' when 'D' then 'decrease' end)::text);
               v_message_text := replace(v_message_text,'v_category_name',v_category_name::text);
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
            	p_template_id := 0;
               p_widget_json := v_template_json;
               
		when 914 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               select isc.category_id, isc.category_name, ub.base_amount, ub.change_option
               into v_category_id, v_category_name, v_amount, v_change_option
               from sibot.sibot_bs_user_budget ub
               join sibot.sibot_bs_income_spend_category isc
               on isc.category_id = ub.category_id and isc.category = ub.category
               where ub.user_id = v_user_id and ub.category = 'S' and ub.change_option <> 'U' and ub.change_value is null
               order by isc.category_id limit 1;
               if v_change_value < 0 or (v_change_value >= v_amount and v_change_option = 'D') then
                    v_amount := 0;
			else
               	if v_change_option = 'I' then
               		v_amount := v_amount + v_change_value;
               	elsif v_change_option = 'D' then
               		v_amount := v_amount - v_change_value;
               	end if;
               end if;
               update sibot.sibot_bs_user_budget
               set change_value = v_amount
               where user_id = v_user_id and category = 'S' and category_id = v_category_id;
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               v_message_text := replace(v_message_text,'v_change_option',(case v_change_option when 'I' then 'increased' when 'D' then 'decreased' end)::text);
               v_message_text := replace(v_message_text,'v_category_name',v_category_name::text);
               v_message_text := replace(v_message_text,'v_change_amount',v_change_value::text);
               select sum(coalesce(change_value,base_amount)) into v_total_income
               from sibot.sibot_bs_user_budget
               where user_id = v_user_id and category = 'I';
               select sum(coalesce(change_value,base_amount)) into v_total_spend
               from sibot.sibot_bs_user_budget
               where user_id = v_user_id and category = 'S';
               v_balance_amount := v_total_income - v_total_spend;
               v_message_text := replace(v_message_text,'v_balance_amount',v_balance_amount::text);
               drop view if exists user_budget_view;
               execute 'create temporary view user_budget_view as
               		select category_id, category, coalesce(change_value, base_amount) as amount, row_number() over(order by category, category_id) as slno
					from sibot.sibot_bs_user_budget
                         where user_id = '||v_user_id;
			for i in 1..10
               loop
               	select category_id, category, amount into v_category_id, v_category, v_amount
                    from user_budget_view where slno = i;
                    case i
                    	when 1 then
                         	select replace(v_message_text,'v_it_amount',v_amount::text) into v_message_text;
                         when 2 then
                         	select replace(v_message_text,'v_vat_amount',v_amount::text) into v_message_text;
                         when 3 then
                         	select replace(v_message_text,'v_sin_amount',v_amount::text) into v_message_text;
                         when 4 then
                         	select replace(v_message_text,'v_flt_amount',v_amount::text) into v_message_text;
                         when 5 then
                         	select replace(v_message_text,'v_ct_amount',v_amount::text) into v_message_text;
                         when 6 then
                         	select replace(v_message_text,'v_sg_amount',v_amount::text) into v_message_text;
                         when 7 then
                         	select replace(v_message_text,'v_e_amount',v_amount::text) into v_message_text;
                         when 8 then
                         	select replace(v_message_text,'v_hc_amount',v_amount::text) into v_message_text;
                         when 9 then
                         	select replace(v_message_text,'v_p_amount',v_amount::text) into v_message_text;
                         when 10 then
                         	select replace(v_message_text,'v_ed_amount',v_amount::text) into v_message_text;
                    end case;
               end loop;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
            	p_template_id := 0;
               p_widget_json := v_template_json;
               
		when 915, 916 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select message_text into v_message_text from sibot.sibot_application_event_widget_message
               where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
               if v_widget_id = 915 then
               	select ub.category_id, isc.category_name into v_category_id, v_category_name
               	from sibot.sibot_bs_user_budget ub
               	join sibot.sibot_bs_income_spend_category isc
               	on isc.category_id = ub.category_id
               	and isc.category = ub.category
               	where ub.user_id = v_user_id and ub.category = 'S' and ub.change_option <> 'U' and ub.change_value is not null
               	order by ub.category_id desc limit 1;
               else
               	select ub.category_id, isc.category_name into v_category_id, v_category_name
               	from sibot.sibot_bs_user_budget ub
               	join sibot.sibot_bs_income_spend_category isc
               	on isc.category_id = ub.category_id
               	and isc.category = ub.category
               	where ub.user_id = v_user_id and ub.category = 'S' and ub.change_option is not null
               	order by ub.category_id desc limit 1;
               end if;
               if v_widget_id = 915 then
               	select category_name into v_next_category_name
               	from sibot.sibot_bs_income_spend_category
               	where category_id = (v_category_id + 1) and category = 'S';
               	v_message_text := replace(v_message_text,'v_next_category_name',v_next_category_name::text);
			end if;
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
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
               for i in 1..v_button_count
            	loop
               	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = i;
                    v_button_title := replace(v_button_title,'v_category_name',v_category_name::text);
                    v_button_payload_text := replace(v_button_payload_text,'v_category_id',v_category_id::text);
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[i] := v_button_template_json::text;
			end loop;
            	select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
               from (select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
               v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
            	p_template_id := 0;
               p_widget_json := v_template_json;
               
		when 917 then
          	
               v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
               select scenario_message into v_message_text
               from sibot.sibot_bs_budget_failure_scenario where scenario_id = v_bs_scenario_id;
               select isc.category_name, ub.target_amount into v_category_name, v_amount
               from sibot.sibot_bs_user_budget ub
               join sibot.sibot_bs_income_spend_category isc
               on isc.category_id = ub.category_id
               and isc.category = ub.category
               where ub.user_id = v_user_id and ub.category = 'S' and ub.is_priority = 1;
               v_message_text := replace(v_message_text,'v_category_name',v_category_name::text);
               v_message_text := replace(v_message_text,'v_amount',v_amount::text);
               v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
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
               for i in 1..v_button_count
               loop
               	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = i;
                    v_button_payload_text := replace(v_button_payload_text,'v_category_id',v_category_id::text);
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[i] := v_button_template_json::text;
			end loop;
               select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
               from (select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
               v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
               p_template_id := 0;
               p_widget_json := v_template_json;
               
		else
          	null;
			
	end case;
     
end;

$$;


--
