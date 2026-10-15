-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
v_custom_id numeric;
v_captcha character varying;
v_module_name character varying;
v_mobile_no character varying;
v_user_guid character varying;
v_email_id character varying;
v_datajson jsonb;
v_login numeric;
v_multiple_response numeric;
v_page_flag numeric;
v_score numeric;
v_level numeric;
v_duration numeric;
v_best_score numeric;
v_best_level numeric;
v_best_duration numeric;
v_best_at timestamp;
v_attempts numeric;
v_new_json jsonb;
-- pairrup
v_pr_levels jsonb;
v_pr_valid_cnt integer;
v_pr_level_cnt integer;
v_pr_run_levels jsonb;
v_pr_run_moves integer;
v_pr_run_time integer;
v_pr_run_crowns integer;
v_pr_best_levels jsonb;
v_pr_best_moves integer;
v_pr_best_time integer;
v_pr_best_crowns integer;
v_pr_best_at character varying;
v_pr_is_new_best boolean;
v_pr_now character varying;
v_pr_run_time_txt character varying;
v_pr_best_time_txt character varying;

begin
/*
{
  "data": {
    "module": "luckydraw",
    "user_info": {
      "first_name": "Abu",
      "last_name": "Dan",
      "email_id": "ab@gmail.com",
      "mobile_no": ""
    },
    "captcha": ""
  }
}
*/

 select    p_json->'data'->>'module',
		   p_json->'data'->>'user_guid',
		   p_json->'data'->>'captcha',
		   p_json->'data'->>'is_login',
		   p_json->'data'->>'multiple_response',
		   p_json->'data'->'user_info'->>'email_id',
		   p_json->'data'->'user_info'->>'mobile_no',
		   p_json->'data'->>'page_flag'

into
	v_module_name,
	v_user_guid,
	v_captcha,
	v_login,
	v_multiple_response,
	v_email_id,
	v_mobile_no,
	v_page_flag;


-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'insert-custom_web_model','logs',uuid_generate_v4(),p_json,current_timestamp,'labrr','logs');

if v_page_flag = 10 and coalesce(v_mobile_no, '') <> '' and exists (select 1 from labrr.labrr_custom_web_json where lower(module_name) = lower(v_module_name) and datajson->'data'->'user_info'->>'mobile_no' = v_mobile_no) then

	p_data := '{
        "data": {
            "status": "0",
            "message": "This mobile number has already been used for this campaign"
        }
    }'::jsonb;
    return;

end if;

if v_login=1 and v_module_name not in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter','poll','power_score','rakshabandhan_campaign', 'rrally', 'pairrup') then
raise notice ' v_login=1 ';
select coalesce(user_guid,null) into v_user_guid from labrr.labrr_web_user where user_guid=v_user_guid;

if v_user_guid is not null and v_user_guid<>'' then

if v_multiple_response=0 then

	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower(v_module_name)) then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);


				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

	else
	--raise notice ' 2v_module_name %',v_module_name;
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';

	end if;

else

				v_custom_id:=nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
				values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);


				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

end if;

else

					p_data:='{
						"data": {
							"status":"0",
							"message":"Unable to locate user information"
						}
					}';

end if;

elsif v_login=0 and v_module_name not in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter','fan_memories_campaign', 'tickets_early_access_2026','rakshabandhan_campaign', 'rrally', 'pairrup') THEN
raise notice ' v_login=0 ';

if not exists(select 1 from labrr.labrr_custom_web_json where module_name=lower(v_module_name) and datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no) AND
not exists(select 1 from labrr.labrr_custom_web_json where module_name=lower(v_module_name) and datajson->'data'->'user_info'->>'email_id'=v_email_id) and v_multiple_response=0 then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);


				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

elsif v_multiple_response=1 THEN

						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);


				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

else

	p_data:='{
						"data": {
						"status":"0",
						"message":"Duplicate entry"}
						}';

end if;

else
raise notice ' elseeeeee  ';
if v_module_name in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter','rr_sponsors','fan_memories_campaign','tickets_early_access_2026','poll','power_score','rakshabandhan_campaign', 'rrally', 'pairrup') then
raise notice 'v_module_name:%',v_module_name;
	--raise notice 'v_module_name %',v_module_name;
	if lower(v_module_name) = 'royalsmatchdayscoop' then

	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower('royalsmatchdayscoop')) then
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);


				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

	else
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';

	end if;
	------------------------------------------------------------------
	elsif lower(v_module_name) = 'power_score' then
		raise notice 'here 111';
			if not exists (
				select 1
				from labrr.labrr_custom_web_json
				where user_guid = v_user_guid
				  and lower(module_name) = lower('power_score')
			) then

				v_custom_id := nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
				values (
					v_custom_id,
					v_captcha,
					current_timestamp,
					current_timestamp,
					v_user_guid,
					'power_score',
					p_json
				);

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', 1,
						'message', 'successful'
					)
				);

			else

				update labrr.labrr_custom_web_json
				set updated_date = current_timestamp,
					datajson = p_json
				where user_guid = v_user_guid
				  and lower(module_name) = lower('power_score');

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', 2,
						'message', 'Data Updated Successfully!'
					)
				);

			end if;
    -------------------------------------------------------------------
    elsif lower(v_module_name) = 'rrally' then
        if coalesce(v_user_guid, '') = '' or not exists (select 1 from labrr.labrr_web_user where user_guid = v_user_guid) then
            p_data := '{"data":{"status":"0","message":"Unable to locate user information"}}'::jsonb;
        elsif coalesce(p_json->'data'->>'score',    '') !~ '^[0-9]+([.][0-9]+)?$' or coalesce(p_json->'data'->>'level',    '') !~ '^[0-9]+([.][0-9]+)?$' or coalesce(p_json->'data'->>'duration', '') !~ '^[0-9]+([.][0-9]+)?$' then
            p_data := '{"data":{"status":"0","message":"score, level and duration are required and must be numeric"}}'::jsonb;
        else
            v_score    := (p_json->'data'->>'score')::numeric;
            v_level    := (p_json->'data'->>'level')::numeric;
            v_duration := (p_json->'data'->>'duration')::numeric;

            insert into labrr.labrr_custom_web_json values (nextval('labrr.seq_labrr_custom_id'), v_captcha, current_timestamp, current_timestamp, v_user_guid, 'rrally', '{}'::jsonb) on conflict (user_guid) where lower(module_name) = 'rrally' do nothing;

            select datajson into v_datajson from labrr.labrr_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'rrally' for update;

            if (v_datajson->'data'->>'best_score') is null then
                v_best_score    := v_score;
                v_best_level    := v_level;
                v_best_duration := v_duration;
                v_best_at       := current_timestamp;
                v_attempts      := 1;
                p_data := jsonb_build_object('data', jsonb_build_object('status', 1, 'message', 'successful'));
            else
                v_attempts := coalesce((v_datajson->'data'->>'attempts')::numeric, 1) + 1;
                if v_score > (v_datajson->'data'->>'best_score')::numeric then
                    v_best_score    := v_score;
                    v_best_level    := v_level;
                    v_best_duration := v_duration;
                    v_best_at       := current_timestamp;
                else
                    v_best_score    := (v_datajson->'data'->>'best_score')::numeric;
                    v_best_level    := coalesce((v_datajson->'data'->>'best_level')::numeric, v_level);
                    v_best_duration := coalesce((v_datajson->'data'->>'best_duration')::numeric, v_duration);
                    v_best_at       := coalesce((v_datajson->'data'->>'best_achieved_at')::timestamp, current_timestamp);
                end if;
                p_data := jsonb_build_object('data', jsonb_build_object('status', 2, 'message', 'Data Updated Successfully!'));
            end if;

            v_new_json := jsonb_set(p_json, '{data}', (p_json->'data') ||
                jsonb_build_object(
                    'best_score',       v_best_score,
                    'best_level',       v_best_level,
                    'best_duration',    v_best_duration,
                    'best_achieved_at', to_char(v_best_at, 'YYYY-MM-DD HH24:MI:SS'),
                    'last_score',       v_score,
                    'last_level',       v_level,
                    'last_duration',    v_duration,
                    'last_played_at',   to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS'),
                    'attempts',         v_attempts
                ));

            update labrr.labrr_custom_web_json set updated_date = current_timestamp, datajson = v_new_json where user_guid = v_user_guid and lower(module_name) = 'rrally';
        end if;
    -------------------------------------------------------------------
    -- PAIRRUP: one call per COMPLETED run (all 4 levels). Whole-run compare:
    --   lower total_moves wins; if equal, lower total_time wins; else keep stored best.
    --   number_of_attempts += 1 on every completed run. Crowns computed here.
    -------------------------------------------------------------------
    elsif lower(v_module_name) = 'pairrup' then
        v_pr_levels := p_json->'data'->'levels';

        if coalesce(v_user_guid, '') = '' or not exists (select 1 from labrr.labrr_web_user where user_guid = v_user_guid) then
            p_data := '{"data":{"status":"0","message":"Unable to locate user information"}}'::jsonb;
            return;
        end if;

        if coalesce(jsonb_typeof(v_pr_levels), '') <> 'array' then
            p_data := '{"data":{"status":"0","message":"levels must be an array of 4 completed levels"}}'::jsonb;
            return;
        end if;

        -- every element: level 1-4, moves whole number >= 1, time as "MM:SS" (e.g. "02:51"); levels 1..4 each exactly once
        select count(*) filter (where coalesce(e->>'moves', '') ~ '^[1-9][0-9]{0,5}$'
                                  and coalesce(e->>'time',  '') ~ '^[0-9]{1,3}:[0-5][0-9]$'
                                  and coalesce(e->>'time',  '') !~ '^0{1,3}:00$'),
               count(distinct e->>'level') filter (where coalesce(e->>'level', '') ~ '^[1-4]$')
        into   v_pr_valid_cnt, v_pr_level_cnt
        from   jsonb_array_elements(v_pr_levels) e;

        if jsonb_array_length(v_pr_levels) <> 4 or v_pr_valid_cnt <> 4 or v_pr_level_cnt <> 4 then
            p_data := '{"data":{"status":"0","message":"levels must contain levels 1-4 exactly once, moves as a whole number greater than 0 and time in MM:SS format (e.g. 02:51)"}}'::jsonb;
            return;
        end if;

        -- normalise this run (sorted by level, crowns from backend). time stored as "MM:SS";
        -- seconds are used only internally for totals / comparison.
        select jsonb_agg(jsonb_build_object('level', lvl, 'moves', mv,
                                            'time', lpad((tm / 60)::text, 2, '0') || ':' || lpad((tm % 60)::text, 2, '0'),
                                            'crowns', cr) order by lvl),
               sum(mv), sum(tm), sum(cr)
        into   v_pr_run_levels, v_pr_run_moves, v_pr_run_time, v_pr_run_crowns
        from  (select lvl, mv, tm, labrr.labrr_pairrup_crowns(lvl, mv) as cr
               from  (select (e->>'level')::int as lvl, (e->>'moves')::int as mv, split_part(e->>'time', ':', 1)::int * 60 + split_part(e->>'time', ':', 2)::int as tm
                      from jsonb_array_elements(v_pr_levels) e) x) y;

        -- sum() ignores NULLs, so check each level: NULL crowns = moves below pair count
        if exists (select 1 from jsonb_array_elements(v_pr_run_levels) e where e->'crowns' = 'null'::jsonb) then
            p_data := '{"data":{"status":"0","message":"Invalid moves: moves cannot be less than the number of pairs in a level"}}'::jsonb;
            return;
        end if;

        v_pr_now := to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS');
        v_pr_run_time_txt := lpad((v_pr_run_time / 60)::text, 2, '0') || ':' || lpad((v_pr_run_time % 60)::text, 2, '0');

        insert into labrr.labrr_custom_web_json values (nextval('labrr.seq_labrr_custom_id'), v_captcha, current_timestamp, current_timestamp, v_user_guid, 'pairrup', '{}'::jsonb) on conflict (user_guid) where lower(module_name) = 'pairrup' do nothing;

        select datajson into v_datajson from labrr.labrr_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'pairrup' for update;

        if (v_datajson->'data'->>'total_moves') is null then
            -- first ever completed run -> becomes best outright
            v_attempts       := 1;
            v_pr_is_new_best := true;
            p_data := jsonb_build_object('data', jsonb_build_object('status', 1, 'message', 'successful'));
        else
            v_attempts      := coalesce((v_datajson->'data'->>'number_of_attempts')::numeric, 0) + 1;
            v_pr_best_moves := (v_datajson->'data'->>'total_moves')::int;
            v_pr_best_time  := (v_datajson->'data'->>'total_time_seconds')::int;

            v_pr_is_new_best := v_pr_run_moves < v_pr_best_moves
                                or (v_pr_run_moves = v_pr_best_moves and v_pr_run_time < v_pr_best_time);
            p_data := jsonb_build_object('data', jsonb_build_object('status', 2, 'message', 'Data Updated Successfully!'));
        end if;

        if v_pr_is_new_best then
            v_pr_best_levels := v_pr_run_levels;
            v_pr_best_moves  := v_pr_run_moves;
            v_pr_best_time   := v_pr_run_time;
            v_pr_best_time_txt := v_pr_run_time_txt;
            v_pr_best_crowns := v_pr_run_crowns;
            v_pr_best_at     := v_pr_now;
        else
            v_pr_best_levels := v_datajson->'data'->'levels';
            v_pr_best_crowns := (v_datajson->'data'->>'total_crowns')::int;
            v_pr_best_time_txt := v_datajson->'data'->>'total_time';
            v_pr_best_at     := v_datajson->'data'->>'best_run_datetime';
        end if;

        -- stored doc: latest payload (minus captcha / raw levels) + best run block + last run
        v_new_json := jsonb_build_object('data',
            ((p_json->'data') - 'captcha' - 'levels') ||
            jsonb_build_object(
                'module',             'pairrup',
                'levels',             v_pr_best_levels,
                'total_moves',        v_pr_best_moves,
                'total_time',         v_pr_best_time_txt,
                'total_time_seconds', v_pr_best_time,   -- internal: tie-break / leaderboard sort
                'total_crowns',       v_pr_best_crowns,
                'best_run_datetime',  v_pr_best_at,
                'number_of_attempts', v_attempts,
                'last_run',           jsonb_build_object('levels', v_pr_run_levels, 'total_moves', v_pr_run_moves, 'total_time', v_pr_run_time_txt, 'total_crowns', v_pr_run_crowns),
                'last_played_at',     v_pr_now
            ));

        update labrr.labrr_custom_web_json set updated_date = current_timestamp, datajson = v_new_json where user_guid = v_user_guid and lower(module_name) = 'pairrup';

        -- Insert response kept minimal; full data comes from getusercommondetails
        p_data := jsonb_set(p_data, '{data}', (p_data->'data') || jsonb_build_object(
            'is_new_best',        v_pr_is_new_best,
            'number_of_attempts', v_attempts
        ));
	-------------------------------------------------------------------
	elsif lower(v_module_name) = 'rakshabandhan_campaign' then
		if coalesce(v_mobile_no, '') = '' then
				p_data := '{
					"data": {
					"status":"0",
					"message":"Mobile number is required"
					}
					}';
		elsif exists (
				select 1
				from labrr.labrr_custom_web_json
				where lower(module_name) = 'rakshabandhan_campaign'
				  and datajson->'data'->'user_info'->>'mobile_no' = v_mobile_no
			) then
				p_data := '{
					"data": {
					"status":"0",
					"message":"This mobile number has already been used for this campaign"
					}
					}';
		else
				v_custom_id := nextval('labrr.seq_labrr_custom_id');
				insert into labrr.labrr_custom_web_json
				values (
					v_custom_id,
					v_captcha,
					current_timestamp,
					current_timestamp,
					v_user_guid,
					'rakshabandhan_campaign',
					p_json
				);
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));
		end if;
	---------------------------------------------------------------------------------------
	elsif lower(v_module_name) in ('newsletter','rr_sponsors') then

								v_custom_id:=nextval('labrr.seq_labrr_custom_id');

								insert into labrr.labrr_custom_web_json
								values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

								p_data:='{
								"data": {
								"status":"1"
								}}';

	elsif lower(v_module_name) in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','fan_memories_campaign', 'tickets_early_access_2026','poll') then
--raise notice 'v_module_name %',v_module_name;
	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower(v_module_name)) then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);


				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));


	---------------------------------------------------

	-- ================= POLL INSERT (FINAL WORKING) =================

-- -- normalize module name
-- v_module_name := trim(coalesce(v_module_name, ''));

-- RAISE NOTICE 'MODULE VALUE = [%]', v_module_name;

-- IF lower(v_module_name) = 'poll' THEN

--     RAISE NOTICE 'POLL BLOCK HIT';

--     -- A. Validate login
--     IF coalesce(v_user_guid, '') = '' THEN
--         p_data := jsonb_build_object(
--             'data', jsonb_build_object(
--                 'status', '0',
--                 'message', 'User not authenticated'
--             )
--         );
--         RETURN;
--     END IF;

--     -- B. Validate poll_id & option_id
--     IF coalesce(p_json->'data'->>'poll_id', '') = '' 
--        OR coalesce(p_json->'data'->>'option_id', '') = '' THEN

--         p_data := jsonb_build_object(
--             'data', jsonb_build_object(
--                 'status', '0',
--                 'message', 'Invalid poll data'
--             )
--         );
--         RETURN;
--     END IF;

--     -- C. Prevent duplicate vote
--     IF EXISTS (
--         SELECT 1
--         FROM labrr.labrr_poll_response
--         WHERE poll_id = (p_json->'data'->>'poll_id')::numeric
--           AND poll_response_guid = v_user_guid
--           AND is_deleted = 0
--     ) THEN
--         p_data := jsonb_build_object(
--             'data', jsonb_build_object(
--                 'status', '0',
--                 'message', 'User already voted on this poll'
--             )
--         );
--         RETURN;
--     END IF;

--     -- D. Insert vote
--     INSERT INTO labrr.labrr_poll_response
--     (
--         poll_response_id,
--         poll_id,
--         response_option_id,
--         created_date,
--         updated_date,
--         is_active,
--         is_deleted,
--         poll_response_guid
--     )
--     VALUES
--     (
--         nextval('labrr.seq_labrr_poll_response_id'),
--         (p_json->'data'->>'poll_id')::numeric,
--         (p_json->'data'->>'option_id')::numeric,
--         current_timestamp,
--         current_timestamp,
--         1,
--         0,
--         v_user_guid
--     );

--     -- E. Success
--     p_data := jsonb_build_object(
--         'data', jsonb_build_object(
--             'status', '1',
--             'message', 'Vote submitted successfully'
--         )
--     );

--     RETURN;

-- END IF;

-------------------------------------------------------
	else
	--raise notice ' 2v_module_name %',v_module_name;
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';

	--end if;

	end if;

end if;

end if;
end if;
end;
$_$;


--
