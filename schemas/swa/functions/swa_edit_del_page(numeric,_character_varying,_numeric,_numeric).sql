-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_edit_del_page(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: swa_edit_del_page(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_edit_del_page(p_page_id numeric, p_page_title character varying, p_flag numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

--********************************PREFACE BLOCK*******************************
--  NAME: swa.swa_edit_del_page
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
if p_page_id is not null
then 
if p_flag =0 then 

update swa.swa_page 
set title=p_page_title,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where page_id=p_page_id;

end if;

if p_flag =1 then 
update swa.swa_page 
set is_deleted=1,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where page_id=p_page_id;

end if ;

end if;

p_result:=p_page_id;

exception
	
     when others then
    	 p_result := -1;
end


$$;


--
