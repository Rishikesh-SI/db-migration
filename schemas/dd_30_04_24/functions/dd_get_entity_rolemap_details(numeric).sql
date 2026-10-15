-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_entity_rolemap_details(numeric)
-- Type: FUNCTION

-- Name: dd_get_entity_rolemap_details(numeric); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_entity_rolemap_details(p_entityrolemapid numeric, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
begin
	
    
     
     select  ('{"entities": '||row_to_json(tab) || '}')::json 
     into p_entityjson
	 from (select   em.entity_master_id, entity_role_map_id, entity_name, entity_display_name, canonical_url, 
           			em.priority
           from  dd.dd_entity_master em
           inner join dd.dd_entity_role_map erm
           	on  (erm.entity_master_id = em.entity_master_id)
           where   erm.entity_role_map_id =  p_entityrolemapid    
            and      erm.is_active        = 1
            and      em.is_active         = 1
            and      em.is_deleted        = 0

       ) as tab;
              		
     
     
exception
	when others then
     	p_entityjson := '{"entities":{"error":"no record"}}';
     
end;

$$;


--
