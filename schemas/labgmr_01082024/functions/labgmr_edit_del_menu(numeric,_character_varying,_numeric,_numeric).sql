-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_edit_del_menu(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labgmr_edit_del_menu(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: labgmr_01082024; Owner: -
--

CREATE FUNCTION labgmr_01082024.labgmr_edit_del_menu(p_menu_id numeric, p_menu_name character varying, p_flag numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
 

--********************************preface block*******************************
--  name: 
--
--  purpose:
--
--  parameters:  
--
--
--  external output:  
--                    
--
--  written/modified by:   date:           reason:
--  r. bhatkar             03/08/2017      creation
--********************************end preface block*************************** 

declare
v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
begin
 insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'edit_del_menu','logs',
        uuid_generate_v4(),'{}',current_timestamp,'labgmr',p_menu_id::character varying);

if p_menu_id is not null
then 
if p_flag =0 then 

update labgmr.labgmr_menu
set menu_name=p_menu_name,
display_name=p_menu_name,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where menu_id=p_menu_id;

end if;

if p_flag =1 then 
update labgmr.labgmr_menu 
set is_deleted=1,
is_active=0,
is_published=0,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where menu_id=p_menu_id;

update labgmr.labgmr_menu_page_map 
set is_active=0,is_deleted=1,is_published=0
where menu_id=p_menu_id;

end if ;

end if;

p_result:=p_menu_id;

--exception
--	
--     when others then
--    	 p_result := -1;
	

end

  

 
$$;


--
