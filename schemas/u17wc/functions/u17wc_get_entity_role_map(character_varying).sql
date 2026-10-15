-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_entity_role_map(character varying)
-- Type: FUNCTION

-- Name: u17wc_get_entity_role_map(character varying); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_entity_role_map(p_entity_name character varying, OUT p_entityrolemap_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_entity_name character varying ; 
   
begin     
           
       
       v_entity_name := lower( p_entity_name);
		
       select rm.entity_role_map_id  
       into p_entityrolemap_id
       from u17wc.u17wc_entity_master EM
 	   inner join u17wc.u17wc_entity_role_map RM 
 	   on (EM.entity_master_id = RM.entity_master_id) 
		where lower(entity_name) =  v_entity_name
		 ;
        

end;

$$;


--
