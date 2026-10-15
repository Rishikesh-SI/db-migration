-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_get_page_detail_r(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_page_detail_r(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_get_page_detail_r(p_json jsonb, OUT v_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_template_id numeric;
	   
begin
	select p_json ->>'template_id'
	into
	v_template_id;
	
	raise notice 'v_template_id % ',v_template_id;
  select json_agg(row_alias)
	   from 
	   (select p.page_id,p.alias,t.parent_id as template_id
		from labgt.labgt_page p
		join labgt.labgt_template t
		on p.page_id = t.page_id 
		where t.parent_id in 
		(select template_id from labgt.labgt_template
		    where layout_id=v_template_id  and is_master=0 )
	   and p.page_id !=0)
	   row_alias
	   into v_json;
	  
			
end;
$$;


--
