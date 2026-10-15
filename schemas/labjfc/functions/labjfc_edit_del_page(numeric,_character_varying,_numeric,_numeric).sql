-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_edit_del_page(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labjfc_edit_del_page(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: labjfc; Owner: -
--

CREATE FUNCTION labjfc.labjfc_edit_del_page(p_page_id numeric, p_page_title character varying, p_flag numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 

--********************************preface block*******************************
--  name: labjfc.labjfc_edit_del_page
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
if p_page_id is not null
then 
if p_flag =0 then 

update labjfc.labjfc_page 
set title=p_page_title,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where page_id=p_page_id;

update labjfc.labjfc_asset_list
set asset_title=p_page_title,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where asset_id=p_page_id
and asset_type_id=11;

end if;

if p_flag =1 then 
update labjfc.labjfc_page 
set is_deleted=1,
    is_active=0,
	is_published=0,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where page_id=p_page_id;

update labjfc.labjfc_asset_list
set is_deleted=1,
    is_active=0,
	is_published=0,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where asset_id=p_page_id
and asset_type_id=11;

end if ;

end if;

p_result:=p_page_id;

exception
	
     when others then
    	 p_result := -1;
end

 

$$;


--
