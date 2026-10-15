-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_get_custom_web_model_r(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_get_custom_web_model_r(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_get_custom_web_model_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

	declare
		/*
		 {
		  "module_name": "dadas_delhi_campaign",
		  "limit": "100"
		 }
		*/
		v_user_guid   text;
		v_module_name text;
		v_rows        jsonb;
		v_limit       int;

	begin

		select p_json->>'user_guid',
		       p_json->>'module_name'
		  into v_user_guid,
		       v_module_name;
			   
-------------------------------------------------------------------
		if lower(v_module_name) = 'dadas_delhi_campaign' then

			v_limit := 100;
			if p_json ? 'limit' and p_json->>'limit' ~ '^[0-9]+$' then
				v_limit := least((p_json->>'limit')::int, 500);
			end if;

			select coalesce(jsonb_agg(w order by w.submitted_date desc), '[]'::jsonb)
			  into v_rows
			  from (select datajson->'data'->'wall_info'->>'full_name' as full_name,
			               datajson->'data'->'wall_info'->>'city'      as city,
			               datajson->'data'->'wall_info'->>'message'   as message,
			               created_date                                as submitted_date
			          from labdd_v1.labdd_v1_custom_web_json
			         where lower(module_name) = 'dadas_delhi_campaign'
			           and coalesce((datajson->'data'->>'status')::smallint, 0) = 1
			         order by created_date desc
			         limit v_limit) w;

			p_data := jsonb_build_object('data', v_rows);
-------------------------------------------------------------------

		else

			if exists (select 1
			             from labdd_v1.labdd_v1_custom_web_json
			            where user_guid = v_user_guid
			              and lower(module_name) = lower(v_module_name)) then

				p_data := '{"data": {"status":"1","message":"Already Exists"}}';
			else
				p_data := '{"data": {"status":"0","message":"Not Exists"}}';
			end if;

		end if;

	end;
$_$;


--
