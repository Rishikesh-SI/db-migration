-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_edit_del_template(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labpc_edit_del_template(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: labpc; Owner: -
--

CREATE FUNCTION labpc.labpc_edit_del_template(p_temp_id numeric, p_temp_name character varying, p_flag numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

  

declare
v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
begin
if p_temp_id is not null
then 
if p_flag =0 then 

update labpc.labpc_template 
set template_name=p_temp_name,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where template_id=p_temp_id;

end if;

if p_flag =1 then 
update labpc.labpc_template 
set is_deleted=1,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where template_id=p_temp_id;

end if ;

end if;

p_result:=p_temp_id;

exception
	
     when others then
    	 p_result := -1;
	

end

  

 $$;


--
