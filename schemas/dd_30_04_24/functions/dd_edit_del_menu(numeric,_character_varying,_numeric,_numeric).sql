-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_edit_del_menu(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: dd_edit_del_menu(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_edit_del_menu(p_menu_id numeric, p_menu_name character varying, p_flag numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

--********************************PREFACE BLOCK*******************************
--  NAME: 
--
--  Purpose:
--
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified by:   Date:           Reason:
--  R. BHATKAR             03/08/2017      CREATION
--********************************END PREFACE BLOCK*************************** 

declare
v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
begin
if p_menu_id is not null
then 
if p_flag =0 then 

update dd.dd_menu
set menu_name=p_menu_name,
display_name=p_menu_name,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where menu_id=p_menu_id;

end if;

if p_flag =1 then 
update dd.dd_menu 
set is_deleted=1,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where menu_id=p_menu_id;

update dd.dd_menu_page_map 
set is_active=0,is_deleted=1
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
