-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_del_entity_details(jsonb)
-- Type: FUNCTION

-- Name: labtri_del_entity_details(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_del_entity_details(p_json jsonb, OUT p_data numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_user_guid character varying;
v_ref_id jsonb;
v_entity_master_id numeric;
i numeric;
begin
/*
{"data":{"ref_ids":[124,100,200]}}
*/

 select    p_json->'data'->>'ref_ids'
        
into 
	v_ref_id;
	
	
	
	for i in select * from jsonb_array_elements(v_ref_id)
	loop
	
		select entity_master_id into v_entity_master_id 
		from labtri.labtri_entity_role_map
		where ref_id=i::numeric;
		
		update labtri.labtri_entity_role_map
		set is_active=0
		where entity_master_id=v_entity_master_id;		
	
		update labtri.labtri_entity_master
		set is_active=0 , is_deleted=1
		where entity_master_id=v_entity_master_id;
		
	end loop;
	
	p_data:=1;

end;
$$;


--
