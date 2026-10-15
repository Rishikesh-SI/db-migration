-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_ins_ent_master_role()
-- Type: FUNCTION

-- Name: pkl_ins_ent_master_role(); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_ins_ent_master_role(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_count numeric ; 
   v_data numeric ; 
   i record; 
   
begin
      
       
       
for i in 
select match_id,entity_name1,entity_name2,matchdate_gmt from  (select match_id,
'Season 5'||','||match_no||','||team1_match_short_code||' vs '||team2_match_short_code as entity_name1,
'Season 5'||','||match_no||','||team1_name||' vs '||team2_name as entity_name2,
matchdate_gmt
from pkl.pkl_sea_5_match_data
where match_id not in  (286,287)
 )a
       LOOP
       
          Insert into pkl.pkl_entity_master ("entity_master_id","waf_entity_master_id","client_id","entity_name","entity_display_name","canonical_url","priority","created_date","updated_date","created_by","updated_by","is_active","is_deleted","date_info","city","country","known_as","comp_type","waf_series_master_id","waf_tour_master_id","entity_guid","wafc_entity_name","wafc_entity_display_name")
          values (nextval('pkl.seq_pkl_entity_master_id'),0,0,i.entity_name2,i.entity_name2,null,1,current_timestamp,current_timestamp,1,1,1,0,i.matchdate_gmt,null,null,i.entity_name2,null,null,null,uuid_generate_v4(),i.entity_name2,i.entity_name2);
       
           
                     
         Insert into pkl.pkl_entity_role_map ("entity_role_map_id","entity_role_id","entity_master_id","priority","is_active","source_object_id","created_date","updated_date","hyperlink") 
         values (nextval('pkl.seq_pkl_entity_role_map_id'),7,currval('pkl.seq_pkl_entity_master_id'),1,1,i.match_id,current_timestamp,current_timestamp,0); 
    
end loop ;
         	
p_result := 1 ;
end;

$$;


--
