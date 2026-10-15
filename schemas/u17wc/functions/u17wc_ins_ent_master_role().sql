-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_ins_ent_master_role()
-- Type: FUNCTION

-- Name: u17wc_ins_ent_master_role(); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_ins_ent_master_role(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_count numeric ; 
v_data numeric ; 
i record; 
   
begin     
           
for i in 
 select sportname, rolename, entityname, sourceobjectid as matchid ,row_number() OVER (ORDER BY Sportname) AS rn , null::timestamp matchdate_gmt 
	from u17wc.u17wc_entity_mast
	-- where rolename='Matches'  
	where  rolename = 'Syndication'
    
   LOOP
       
          Insert into u17wc.u17wc_entity_master ("entity_master_id","waf_entity_master_id","client_id","entity_name","entity_display_name","canonical_url","priority","created_date","updated_date","created_by","updated_by","is_active","is_deleted","date_info","city","country","known_as","comp_type","waf_series_master_id","waf_tour_master_id","entity_guid","wafc_entity_name","wafc_entity_display_name")
          values (nextval('u17wc.seq_u17wc_entity_master_id'),0,0,i.entityname,i.entityname,null,1,current_timestamp,current_timestamp,1,1,1,0,i.matchdate_gmt,null,null,i.entityname,null,null,null,uuid_generate_v4(),i.entityname,i.entityname);
                   
         Insert into u17wc.u17wc_entity_role_map ("entity_role_map_id","entity_role_id","entity_master_id","priority","is_active","source_object_id","created_date","updated_date","hyperlink") 
         values (nextval('u17wc.seq_u17wc_entity_role_map_id'),16,currval('u17wc.seq_u17wc_entity_master_id'),1,1,i.matchid,current_timestamp,current_timestamp,0); 
    
end loop ;
         	
p_result := 1 ;
end;

$$;


--
