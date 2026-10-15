-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_ins_get_entity(character varying)
-- Type: FUNCTION

-- Name: labisp_ins_get_entity(character varying); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_ins_get_entity(p_entity_name character varying, OUT p_entity_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare
	v_currenttimestamp    timestamp;
	v_entity_array text[];
	i record;

	BEGIN

	  v_currenttimestamp := current_timestamp at time zone 'utc';
	  
	  
	  v_entity_array := string_to_array(replace(p_entity_name,'>',','),',')::text[];
	  
		
	  
	  for i in 
	  select entity_name from unnest(v_entity_array)entity_name
	  loop
	   
		  raise notice '%',i.entity_name;
		  
		  if not exists(select 1 from labisp.labisp_entity_master
					   where lower(trim(entity_name)) = lower(trim(i.entity_name))  )then	
			
			Insert into labisp.labisp_entity_master (entity_master_id,waf_entity_master_id,client_id,entity_name,entity_display_name,canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name)
			values (nextval('labisp.seq_labisp_entity_master_id'),0,1,trim(i.entity_name),trim(i.entity_name),null,1,v_currenttimestamp,v_currenttimestamp,1,1,1,0,null,null,null,trim(i.entity_name),null,null,null,uuid_generate_v4(),trim(i.entity_name),trim(i.entity_name));

			Insert into labisp.labisp_entity_role_map (entity_role_map_id,entity_role_id,entity_master_id,priority,is_active,source_object_id,created_date,updated_date,hyperlink)
			values(nextval('labisp.seq_labisp_entity_role_map_id'),22,currval('labisp.seq_labisp_entity_master_id'),1,1,null,v_currenttimestamp,v_currenttimestamp,0); 
			
			
			
		   end if;	
	  
	  end loop;
	
	 	select '{ "entities":'|| array_to_json(array_agg(tab1))|| '}' into  p_entity_json from 
		(select em.entity_name,erm.entity_role_map_id,em.entity_display_name, 1 as is_visible ,
		 0 as is_linkable,0 as is_lang, 0 as priority
		 from labisp.labisp_entity_master em
		left join labisp.labisp_entity_role_map erm on em.entity_master_id = erm.entity_master_id
		where lower(trim(entity_name)) in (select lower(trim(entity_name)) from unnest(v_entity_array)entity_name)
		)
		tab1;
		
		

	END;

	$$;


--
