-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_edit_del_page(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: khi_edit_del_page(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_edit_del_page(p_page_id numeric, p_page_title character varying, p_flag numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

  

declare
v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
begin
if p_page_id is not null
then 
if p_flag =0 then 

update khi.khi_page 
set title=p_page_title,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where page_id=p_page_id;

end if;

if p_flag =1 then 
update khi.khi_page 
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
