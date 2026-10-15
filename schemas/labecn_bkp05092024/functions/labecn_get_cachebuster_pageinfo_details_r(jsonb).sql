-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: labecn_get_cachebuster_pageinfo_details_r(jsonb)
-- Type: FUNCTION

-- Name: labecn_get_cachebuster_pageinfo_details_r(jsonb); Type: FUNCTION; Schema: labecn_bkp05092024; Owner: -
--

CREATE FUNCTION labecn_bkp05092024.labecn_get_cachebuster_pageinfo_details_r(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_page_id numeric;
	v_template_id numeric;
begin
	select 
		   p_inputjson->'page_id',
		   p_inputjson->'template_id'		   
	into   
		   v_page_id,
		   v_template_id;
		   
		   if v_page_id>0 then
		   
		    p_data:= (SELECT JSON_AGG(src) FROM (SELECT meta_info as metainfo FROM labecn.labecn_page where page_id=v_page_id) src)::jsonb;
		    
		   end if;
		   
		   if v_template_id>0 then
		   
		   p_data:= (
		   SELECT JSON_AGG(src) FROM (SELECT meta_info as metainfo FROM labecn.labecn_page where page_id in (
		   select page_id from labecn.labecn_template where parent_id=v_template_id and page_id>0
		   )
		   
		   ) src)::jsonb;
		   
		   end if;
		   
	
	
end;
$$;


--
