-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_del_unpublished_article_by_guid(jsonb)
-- Type: FUNCTION

-- Name: labuww_del_unpublished_article_by_guid(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_del_unpublished_article_by_guid(p_json jsonb, OUT p_output_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
v_article_guid character varying;
v_article_id numeric;
v_version_number numeric;
v_asset_data_json jsonb;

/*
{
  "guid":"95748703-bf1d-4b68-bbd5-fad603705104"
}
*/

begin
	
   select p_json->>'guid'
   into   v_article_guid;

	select article_id 
	into v_article_id
	from labuww.labuww_article
	where article_guid=v_article_guid;

	if v_article_id is null then
		p_result:=0;
		p_output_json:='{
		"message":"Invalid Guid/Article Not Found"
		}';
	else 	
	
	select max(version_number)
	into v_version_number
	from labuww.labuww_asset_draft
	where asset_id=v_article_id
	and asset_type_id=1;
	
	select asset_data 
	into v_asset_data_json
	from labuww.labuww_asset_draft
	where asset_id=v_article_id
	and asset_type_id=1
	and version_number=v_version_number;
	
	--v_asset_data_json:=jsonb_set(v_asset_data_json, '{data,status}','0', true);
	v_asset_data_json:=jsonb_set(v_asset_data_json, '{data,is_publish}','0', true);
	v_asset_data_json:=jsonb_set(v_asset_data_json, '{data,is_trashed}','1', true);
	
	update labuww.labuww_article
	set is_published=0,
	is_trashed=1,
	published_version_number=coalesce(published_version_number,0)+1
	where article_guid=v_article_guid;
	
	
	update labuww.labuww_asset_list
	set is_active=0,
		is_trashed=1,
      is_deleted=1,
     is_published=0
	where asset_id=v_article_id
	and asset_type_id=1;

	
	insert into labuww.labuww_asset_draft
	values(nextval('labuww.seq_labuww_asset_draft_id'),v_article_id,1,v_version_number+1,v_asset_data_json,current_timestamp,current_timestamp,41,41,1,0,uuid_generate_v4());
	
	p_output_json:= v_asset_data_json;
	p_result:=1;
	
	
	end if;
end ;
$$;


--
