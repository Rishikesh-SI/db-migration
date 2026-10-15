-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_sitemap_category(jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_sitemap_category(jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_sitemap_category(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_sysdate timestamp:= current_timestamp at time zone 'utc';
	
	p_data jsonb;
	v_client_id varchar(200);
	v_created_by numeric;
	v_edited_by numeric;
	v_user_name varchar(500);
	v_data jsonb;
	v_cat_name varchar(2000);
	v_is_active numeric;
	v_category_id numeric;
	v_exist numeric;
	v_paginated numeric;
	v_pagelimit numeric;
begin
	
	select p_json->'data',
		   p_json->>'client_id',
		   p_json->>'created_by_id',
		   p_json->>'edited_by_id',
		   p_json->>'user_name'
	into   p_data ,
		   v_client_id,
		   v_created_by,
		   v_edited_by,
		   v_user_name
		   ;
	   -- start for loop for data ingest --
	 	
		
		for v_data in select * from jsonb_array_elements(p_data)
			loop
			  -- read json fields --
	 			select v_data->>'category_name',
					   v_data->>'is_checked',
					   v_data->>'category_id'
				into   v_cat_name,
				       v_is_active,
					   v_category_id
					   ;
			--select * from siwaf.siwaf_client_sitemap_category_map order by 1 desc			  
			 			   
			   -- raise notice 'v_is_active %',v_is_active;
				if v_category_id = 3 then
					v_paginated:=1;
					v_pagelimit:=5000;
				else
					v_paginated:= null;
					v_pagelimit:= null;
				end if;
				
				if not exists(select sitemap_category_id from siwaf.siwaf_client_sitemap_category_map
							  where client_code=v_client_id and sitemap_category_id=v_category_id)then
				raise notice 'v_cat_name %',v_cat_name;
					insert into siwaf.siwaf_client_sitemap_category_map
					values(nextval('siwaf.seq_siwaf_client_sitemap_category_map_id'),v_client_id,v_category_id,v_paginated,v_pagelimit,null,'site-map/','.xml',v_is_active);
				
				elsif exists(select 1 from siwaf.siwaf_client_sitemap_category_map
							  where client_code=v_client_id and sitemap_category_id=v_category_id)then
									raise notice 'v_cat_name %',v_cat_name;
							raise notice 'v_is_active %',v_is_active;
		  
					update siwaf.siwaf_client_sitemap_category_map
					set  is_checked=v_is_active
					where client_code=v_client_id and sitemap_category_id=v_category_id;
					
				end if;
			  
			end loop;
	   -- end for loop ---
	   p_result =1;

end;
$$;


--
