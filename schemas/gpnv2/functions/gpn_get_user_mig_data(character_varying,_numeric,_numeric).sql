-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_get_user_mig_data(character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: gpn_get_user_mig_data(character varying, numeric, numeric); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_get_user_mig_data(p_client_name character varying, p_pagenumber numeric, p_itemnumber numeric, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
  declare
  --p_client_name character varying := 'Indian Super League';
v_application_id numeric[];
v_json jsonb;
v_fromrownumber numeric;
v_torownumber numeric;
--p_pagenumber numeric := 1;
--p_itemnumber numeric := 10 ;

begin

		 v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
 		 v_torownumber := (p_pagenumber * p_itemnumber);

		select array_agg(application_id) into v_application_id from gpnv2.gpn_application
		where environment_id = 2 and lower(application_name) = lower(p_client_name);

-- raise notice '%',v_application_id;

		 select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb into v_json
		 from
		(select device_token as devicetooken,b.endpoint_arn as target_arn,call_json as userjson ,
				row_number() over(order by created_date) as rn, 
				case platform_id when 1 then 'android' when 2 then 'ios' end as platform
		from gpnv2.gpn_user a
		left join (select distinct user_id,endpoint_arn 
				   from gpnv2.gpn_user_topic_map d
				   where d.application_id in (select * from unnest(v_application_id)) ) b on a.user_id = b.user_id
		left join gpnv2.gpn_application c on a.application_id = c.application_id
		where a.application_id in (select * from unnest(v_application_id)) 
		 and is_active = 1 and b.endpoint_arn is not null
		)row
		where rn between v_fromrownumber and v_torownumber;
	
		p_user_data := v_json;
end;
$$;


--
