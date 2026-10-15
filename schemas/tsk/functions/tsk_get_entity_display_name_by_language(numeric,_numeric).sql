-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_get_entity_display_name_by_language(numeric, numeric)
-- Type: FUNCTION

-- Name: tsk_get_entity_display_name_by_language(numeric, numeric); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_get_entity_display_name_by_language(p_lang_id numeric, p_ent_role_map_id numeric, OUT p_entity_disp_name character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

declare
  v_lang_id numeric;
  v_ent_mast_id numeric;
    
begin
 
select 
erm.entity_master_id into v_lang_id
                                  
from tsk.tsk_entity_role_map erm
                   
where erm.entity_role_map_id =(p_lang_id);

select 
erm.entity_master_id into v_ent_mast_id
                                  
from tsk.tsk_entity_role_map erm
                   
where erm.entity_role_map_id =(p_ent_role_map_id);

  if ( v_lang_id  is not null  or   v_ent_mast_id is not null)
  then 
  
        select 
        entity_display_name into p_entity_disp_name
        from tsk.tsk_entity_language_map
        where entity_master_id=v_ent_mast_id
        and language_master_id=v_lang_id;
        
        if p_entity_disp_name is null or p_entity_disp_name='' then
             select entity_display_name into p_entity_disp_name from tsk.tsk_entity_master
             where entity_master_id=v_ent_mast_id;
        end if;
  else 
  
        select entity_display_name into p_entity_disp_name from tsk.tsk_entity_master
        where entity_master_id=v_ent_mast_id;
  end if;
  

end ;

 $$;


--
