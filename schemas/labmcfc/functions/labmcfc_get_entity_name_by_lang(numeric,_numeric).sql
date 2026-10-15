-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_get_entity_name_by_lang(numeric, numeric)
-- Type: FUNCTION

-- Name: labmcfc_get_entity_name_by_lang(numeric, numeric); Type: FUNCTION; Schema: labmcfc; Owner: -
--

CREATE FUNCTION labmcfc.labmcfc_get_entity_name_by_lang(p_lan_id numeric, p_entity_role_map_id numeric, OUT p_entity_name character varying, OUT p_entity_display_name character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare 
v_entity_name text ;
v_error_check text ;
err_msg text;
v_dif_ln_ds_name text;
v_other_lang_name text;
v_is_defualt_lang numeric;
begin

select is_defualt_lang into strict v_is_defualt_lang
from labmcfc.labmcfc_entity_role_map erm
inner join labmcfc.labmcfc_entity_master  em 
on em.entity_master_id=erm.entity_master_id
where erm.entity_role_map_id=p_lan_id;

--raise notice '%',p_entity_name;
--p_entity_name:=v_entity_name;
select a.entity_display_name ,
c.entity_display_name ,a.entity_name into v_dif_ln_ds_name ,v_other_lang_name,p_entity_name
from  labmcfc.labmcfc_entity_master a
 join labmcfc.labmcfc_entity_role_map b on b.entity_master_id=a.entity_master_id
left join labmcfc.labmcfc_entity_language_map c on c.entity_master_id=b.entity_master_id
where b.entity_role_map_id=p_entity_role_map_id;

if v_is_defualt_lang =1 then 
p_entity_display_name:=v_dif_ln_ds_name;
                        
else
p_entity_display_name:=COALESCE(v_other_lang_name,v_dif_ln_ds_name);
end if ;

exception when others then 
    get stacked diagnostics 
	v_error_check =pg_exception_context;
	 err_msg := SQLERRM;
end ;

$$;


--
