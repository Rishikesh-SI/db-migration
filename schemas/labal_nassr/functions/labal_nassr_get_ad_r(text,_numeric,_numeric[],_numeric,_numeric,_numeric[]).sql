-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_get_ad_r(text, numeric, numeric[], numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: labal_nassr_get_ad_r(text, numeric, numeric[], numeric, numeric, numeric[]); Type: FUNCTION; Schema: labal_nassr; Owner: -
--

CREATE FUNCTION labal_nassr.labal_nassr_get_ad_r(p_url text, p_ad_client numeric, p_entity_arr numeric[], p_is_detail numeric, p_fetch_from numeric, p_page_required_entity numeric[], OUT p_ad_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_string_entity_arr text[];
	v_string_entity_count numeric;
	v_i numeric := 1;
	v_entity_role_map_id numeric;
	v_numeric_entity_arr numeric[];
	v_entity_arr numeric[];
	v_entity_count numeric;
	v_ad_asset_type_id numeric := 16;
	v_position_entity numeric;
	v_language_entity numeric;
	v_ad_id numeric[];
	v_array_length numeric;
	v_entity numeric;
	v_entity_name text;
	v_secondary_entity numeric;
	v_alias text;
	v_loop_counter numeric := 1;
	
	
begin
    if p_fetch_from=1 then
	 p_entity_arr=uniq(sort(array_cat(p_entity_arr,p_page_required_entity)::int[]))::numeric[];
	end if;
	v_entity_arr := p_entity_arr;
	select entityid
	into strict v_position_entity
	from unnest(v_entity_arr) u(entityid)
	where entityid in(select erm.entity_role_map_id
						from labal_nassr.labal_nassr_entity_category ec
						join labal_nassr.labal_nassr_entity_role_map erm
						on erm.entity_role_id = ec.entity_role_id
						join labal_nassr.labal_nassr_entity_master em
						on em.entity_master_id = erm.entity_master_id
						where category_name = 'Ad Positions');
	
	select array_remove(v_entity_arr,v_position_entity) into v_entity_arr;
	
	raise notice 'v_entity_arr%',v_entity_arr;
	
	 if v_entity_arr is not null and  v_entity_arr!='{}' then
	 
	  select  array(select ad_id
					
					from labal_nassr.labal_nassr_advertisement a
					join labal_nassr.labal_nassr_asset_entity_map aem
					on aem.asset_id = a.ad_id
					and aem.asset_type_id = 16
					where a.ad_position = v_position_entity
					and a.is_published = 1
					---and p_ad_client = any(a.ad_client)
					--and a.is_detail = case p_is_detail when 0 then 0 else a.is_detail end
					and exists(select 1 from labal_nassr.labal_nassr_asset_entity_map eam
                               where eam.asset_id = a.ad_id
                               and eam.asset_type_id = v_ad_asset_type_id
                               and eam.entity_role_map_id 
							   in ((select entityid from unnest(v_entity_arr) u(entityid)))
                               )
					order by a.is_detail desc
					)into v_ad_id
					;
	 else
		--raise notice ' null v_entity_arr : % ',  v_entity_arr ;
		select array(select ad_id 
		from labal_nassr.labal_nassr_advertisement a
		where a.ad_position = v_position_entity
		and a.is_published = 1
		--and p_ad_client = any(a.ad_client)
        --and a.is_detail = coalesce(p_is_detail,0)
		/*and not exists (select 1 from  labal_nassr.labal_nassr_asset_entity_map aem
							where  aem.asset_id = a.ad_id and coalesce(a.is_default,0)=0
							and aem.asset_type_id = 16)
							*/
		order by a.is_detail desc
					 ) into v_ad_id
        ;
		
	end if;				
	
	
    if v_ad_id is not null then
    	p_result := 1;
	else
    	p_result := 0;
	end if;
	
	if p_result = 1 then

		select ('{"items":'||(jsonb_agg(row)::text)||'}')::json
		from (select ad_title,ad_code,ad_position,is_default,ad_client,is_detail,is_external
			  from labal_nassr.labal_nassr_advertisement where ad_id =any( v_ad_id)) row
		into p_ad_json;

	else

		p_ad_json := '{"itemsd":{}}'::jsonb;

	end if;
	
exception
	when others then

		p_ad_json := '{}';
		p_result := -1;

end;
$$;


--
