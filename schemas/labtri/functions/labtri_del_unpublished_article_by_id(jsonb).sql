-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_del_unpublished_article_by_id(jsonb)
-- Type: FUNCTION

-- Name: labtri_del_unpublished_article_by_id(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_del_unpublished_article_by_id(p_json jsonb, OUT p_output_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
v_article_guid character varying;
v_article_id numeric;
v_version_number numeric;
p_data jsonb;
v_ref_ids jsonb;

/*
{
  "data": {
    "ref_ids": [
      124,
      100,
      200
    ]
  }
}
*/
i numeric;
v_json jsonb;
j numeric:=0;
begin
	
   select p_json->'data'->>'ref_ids'
   into   v_ref_ids;

	for i in select * from jsonb_array_elements(v_ref_ids)
	loop
		
		j:=j+1;
				
		select article_id into v_article_id
		from labtri.labtri_article
		where ref_id=i::numeric;
		
		raise notice 'v_article_id %',v_article_id;		
		
		v_json:='{
		"data":{
		"article_id": "'||coalesce(v_article_id,0)||'"
		}
		}';
		
		raise notice 'v_json %',v_json;				
		
		if j = 1 then
		
			p_data:= jsonb_agg(v_json);
			raise notice 'p_data1 %',p_data;
			p_output_json:= '{"response":{}}';
			p_output_json:= jsonb_set(p_output_json,'{response}',p_data,true);
		
		else 
		
			p_data:= p_data || v_json ;
			raise notice 'p_data %',p_data;
			p_output_json:= jsonb_set(p_output_json,'{response}',p_data,true);	
		
		
		end if;
		
	end loop;

	p_result:=1;
	
	
	
end ;
$$;


--
