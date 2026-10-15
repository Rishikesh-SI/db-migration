-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_page_detail_r(jsonb)
-- Type: FUNCTION

-- Name: labsaw_get_page_detail_r(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_page_detail_r(p_json jsonb, OUT v_json jsonb) RETURNS jsonb
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
	   (select p.page_id,p.alias
		from labsaw.labsaw_page p
		join labsaw.labsaw_template t
		on p.page_id = t.page_id 
		where p.parent_id in 
		(select template_id from labsaw.labsaw_template
		    where layout_id in (select layout_id from labsaw.labsaw_template
							   where template_id=v_template_id ))
	   and p.page_id !=0 )
	   row_alias
	   into v_json;
	  
			
end;
$$;


--
