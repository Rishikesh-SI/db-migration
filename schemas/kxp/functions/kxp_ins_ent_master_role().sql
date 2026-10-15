-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_ins_ent_master_role()
-- Type: FUNCTION

-- Name: kxp_ins_ent_master_role(); Type: FUNCTION; Schema: kxp; Owner: -
--

CREATE FUNCTION kxp.kxp_ins_ent_master_role(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_count numeric ; 
v_data numeric ; 
i record; 
   
begin     
           
for i in 
select 
    'Cricket' as entity_name
   LOOP
       
          Insert into kxp.kxp_entity_master ("entity_master_id","waf_entity_master_id","client_id","entity_name","entity_display_name","canonical_url","priority","created_date","updated_date","created_by","updated_by","is_active","is_deleted","date_info","city","country","known_as","comp_type","waf_series_master_id","waf_tour_master_id","entity_guid","wafc_entity_name","wafc_entity_display_name")
          values (nextval('kxp.seq_kxp_entity_master_id'),0,0,i.entity_name,i.entity_name,null,1,current_timestamp,current_timestamp,1,1,1,0,null,null,null,i.entity_name,null,null,null,uuid_generate_v4(),i.entity_name,i.entity_name);
                   
         Insert into kxp.kxp_entity_role_map ("entity_role_map_id","entity_role_id","entity_master_id","priority","is_active","source_object_id","created_date","updated_date","hyperlink") 
         values (nextval('kxp.seq_kxp_entity_role_map_id'),8,currval('kxp.seq_kxp_entity_master_id'),1,1,null,current_timestamp,current_timestamp,0); 
    
end loop ;
         	
p_result := 1 ;
end;

$$;


--
