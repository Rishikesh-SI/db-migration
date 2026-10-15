-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_ad_r_test(text, numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: dhm_get_ad_r_test(text, numeric, numeric[], numeric); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_ad_r_test(p_url text, p_ad_client numeric, p_entity_arr numeric[], p_is_detail numeric, OUT p_ad_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_string_entity_arr text[];
	v_string_entity_count numeric;
	v_i numeric := 1;
	v_entity_role_map_id numeric;
	v_numeric_entity_arr numeric[];
	v_entity_arr numeric[] := p_entity_arr;
	v_entity_count numeric;
	v_ad_asset_type_id numeric := 16;
	v_position_entity numeric;
	v_language_entity numeric;
	v_ad_id numeric;
	v_array_length numeric;
	v_entity numeric;
	v_entity_name text;
	v_secondary_entity numeric;
	v_alias text;
	v_loop_counter numeric := 1;
	
begin
	
	select entityid from unnest(v_entity_arr) u(entityid)
	where entityid in(select erm.entity_role_map_id
						from dhm.dhm_entity_category ec
						join dhm.dhm_entity_role_map erm
						on erm.entity_role_id = ec.entity_role_id
						join dhm.dhm_entity_master em
						on em.entity_master_id = erm.entity_master_id
						where category_name = 'Ad Positions')
	into strict v_position_entity;
	
	select entityid from unnest(v_entity_arr) u(entityid)
	where entityid in(select erm.entity_role_map_id
						from dhm.dhm_entity_category ec
						join dhm.dhm_entity_role_map erm
						on erm.entity_role_id = ec.entity_role_id
						join dhm.dhm_entity_master em
						on em.entity_master_id = erm.entity_master_id
						where category_name = 'Language')
	into strict v_language_entity;
	
	if p_url is not null and p_url <> '' and length(p_url) > 0 then
		
		select ('{'||replace(p_url,'/',',')||'}')::text[] into v_string_entity_arr;
		
		select count(1) into v_string_entity_count from (select entity_name from unnest(v_string_entity_arr) u(entity_name)) a;
		
		foreach v_entity_name in array v_string_entity_arr
		loop
			
			if v_secondary_entity is null then
				
				select erm.entity_role_map_id into v_secondary_entity
				from dhm.dhm_entity_category ec
				join dhm.dhm_entity_role_map erm
				on erm.entity_role_id = ec.entity_role_id
				join dhm.dhm_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where category_name = 'Category Type'
				and lower(replace(trim(em.entity_name),' ','-')) = v_entity_name;
				
			end if;
			
			select entity_role_map_id into v_entity_role_map_id
			from dhm.dhm_entity_role_map
			where entity_master_id = (select entity_master_id from dhm.dhm_entity_master where lower(trim(entity_name)) = v_entity_name);
			
			if v_entity_role_map_id is not null then
				
				v_numeric_entity_arr[v_i] := v_entity_role_map_id;
				v_i := v_i + 1;
				
			end if;
			
		end loop;
		
		if v_secondary_entity is null and p_is_detail = 1 then
			
			select substring(p_url,'(?:.*\/)?(.*)$') into v_alias;
			select primary_entity_role_map_id into v_secondary_entity from dhm.dhm_asset_list where title_alias = v_alias;
			
		end if;
		
        select ad_id
        into v_ad_id
        from dhm.dhm_advertisement a
        join dhm.dhm_asset_entity_map aem
        on aem.asset_id = a.ad_id
        and aem.asset_type_id = 16
        where a.ad_position = v_position_entity
        and a.is_published = 1
        and p_ad_client = any(a.ad_client)
        and exists(select 1 from dhm.dhm_asset_entity_map eam
                   where eam.asset_id = a.ad_id
                   and eam.asset_type_id = v_ad_asset_type_id
                   and eam.entity_role_map_id in (v_secondary_entity, v_language_entity)
                   group by eam.asset_id, eam.asset_type_id
                   having count(1) = 2)
		group by a.ad_id
        having count(1) = 2;
        
        if v_ad_id is null then
        	
            select array_cat(v_numeric_entity_arr, v_entity_arr) into v_entity_arr;
			select count(1) into v_entity_count from (select entity_id from unnest(v_entity_arr) u(entity_id)) a;
			
			if v_entity_count > 0 then
				
				select array_remove(v_entity_arr,v_position_entity) into v_entity_arr;
				select array_remove(v_entity_arr,v_language_entity) into v_entity_arr;
				
				select count(1) into v_entity_count from (select entity_id from unnest(v_entity_arr) u(entity_id)) a;
				
				while(v_entity_count >= 0)
				loop
                	
					select ad_id
					into v_ad_id
					from dhm.dhm_advertisement a
					join dhm.dhm_asset_entity_map aem
					on aem.asset_id = a.ad_id
					and aem.asset_type_id = 16
					where a.ad_position = v_position_entity
					and a.is_published = 1
					and p_ad_client = any(a.ad_client)
					and a.is_detail = case p_is_detail when 0 then 0 else a.is_detail end
					and exists(select 1 from dhm.dhm_asset_entity_map eam
                               where eam.asset_id = a.ad_id
                               and eam.asset_type_id = v_ad_asset_type_id
                               and eam.entity_role_map_id in ((select entityid from unnest(array_append(v_entity_arr, v_language_entity)) u(entityid)))
                               group by eam.asset_id, eam.asset_type_id
                               having count(1) = (v_entity_count + 1))
					group by a.ad_id
					having count(1) = (v_entity_count + 1)
					order by a.is_detail desc
					limit 1;
					
					if v_ad_id is not null then
						exit;
					else
						
						if v_entity_count > 0 then
							v_array_length := v_entity_count;
							select v_entity_arr[v_array_length] into v_entity;
							select array_remove(v_entity_arr,v_entity) into v_entity_arr;
							select count(1) into v_entity_count from (select entity_id from unnest(v_entity_arr) u(entity_id)) a;
						else
							v_entity_count := -1;	
						end if;
						
					end if;
					
				end loop;
				
				if v_ad_id is null then
                	
					select ad_id
					into v_ad_id
					from dhm.dhm_advertisement a
					where a.ad_position = v_position_entity
					and a.is_published = 1
					and a.is_default = 1
					and p_ad_client = any(ad_client)
                	and a.is_detail = case p_is_detail when 0 then 0 else a.is_detail end;
					
				end if;
				
			end if;
            
        end if;
        
	else
		
		select ad_id into v_ad_id
		from dhm.dhm_advertisement a
		left join dhm.dhm_asset_entity_map aem
		on aem.asset_id = a.ad_id
		and aem.asset_type_id = 16
		where a.ad_position = v_position_entity
		and a.is_published = 1
		and p_ad_client = any(a.ad_client)
		-- and a.is_detail = case p_is_detail when 0 then 0 else a.is_detail end
        	and a.is_detail = coalesce(p_is_detail,0)
		order by a.is_detail desc
		limit 1;
		
	end if;
	
    if v_ad_id is not null then
    	p_result := 1;
	else
    	p_result := 0;
	end if;
    
	if p_result = 1 then
		
		select ('{"ad":'||string_agg((row_to_json(row))::text,',')||'}')::json
		from (select * from dhm.dhm_advertisement where ad_id = v_ad_id) row
		into p_ad_json;
		
	else
		
		p_ad_json := '{"ad":{}}'::jsonb;
		
	end if;
	
exception
	when others then
		
		p_ad_json := '{"ad":{}}'::jsonb;
		p_result := -1;
	
end;

$_$;


--
