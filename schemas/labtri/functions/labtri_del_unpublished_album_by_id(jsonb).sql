-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_del_unpublished_album_by_id(jsonb)
-- Type: FUNCTION

-- Name: labtri_del_unpublished_album_by_id(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_del_unpublished_album_by_id(p_json jsonb, OUT p_output_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
v_article_guid character varying;
v_album_id_array numeric[];
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
v_album_count numeric;
k numeric;
v_ar_count numeric;
v_article_id numeric;
v_json1 jsonb;
v_refid_count numeric;
p_data1 jsonb;
l jsonb;
b numeric;
begin

	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-delete_article','logs',uuid_generate_v4(),p_json,current_timestamp,'labrr','logs');
  

	delete from labtri.labtri_info_delete_article;

   select p_json->'data'->>'ref_ids'
   into   v_ref_ids;
	
	for i in select * from jsonb_array_elements(v_ref_ids)
	loop
		
		j:=j+1;
				
		select array_agg(album_id) into v_album_id_array
		from labtri.labtri_album
		where ref_id=i::numeric;		
		
		select count(1)
		 into   v_album_count
		 from   unnest(v_album_id_array)album_id;
		 
		 --select JSONB_ARRAY_LENGTH(v_ref_ids) into v_refid_count;
		
		raise notice 'v_article_id_array %',v_album_id_array;
		
		update labtri.labtri_album
		set is_published=0,is_trashed=1
		where album_id = any(v_album_id_array);
		
		update labtri.labtri_asset_list
		set is_published=0,is_trashed=1
		where asset_id = any(v_album_id_array) and asset_type_id=1;		
		 
		
		
		if v_album_count > 1 then
		k=1;
		
		
			foreach i in array(v_album_id_array)
			loop
			
						v_json1:='{
						"album_id": "'||coalesce(i,0)||'"
						}
						';
						
						raise notice 'i %',i;
						
						insert into labtri.labtri_info_delete_article
						values(v_json1);
						
			end loop;
		else 

						v_json1:='{
						"album_id": "'||coalesce(i,0)||'"
						}
						';
						
						raise notice 'i %',i;
						
						insert into labtri.labtri_info_delete_article
						values(v_json1);
	
			end if;
	end loop;
	
	select '{"response" :'||json_agg(row_alias)||'}'  FROM
	(select data from labtri.labtri_info_delete_article)row_alias
	into p_output_json;
	
	
	
	p_result:=1;
	
	
	
end ;
$$;


--
