-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_del_unpublished_video_by_ref_id(jsonb)
-- Type: FUNCTION

-- Name: labwpl_del_unpublished_video_by_ref_id(jsonb); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl.labwpl_del_unpublished_video_by_ref_id(p_json jsonb, OUT p_output_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
v_ref_video_id numeric;
v_video_id numeric;
v_version_number numeric;
v_asset_data_json jsonb;

/*
{
  "guid":"95748703-bf1d-4b68-bbd5-fad603705104"
}
*/

begin
	
   select p_json->>'id'
   into   v_ref_video_id;

	select video_id 
	into v_video_id
	from labwpl.labwpl_video
	where ref_video_id = v_ref_video_id;

	if v_video_id is null then
		p_result:=0;
		p_output_json:='{
		"message":"Invalid Guid/video Not Found"
		}';
	else 	
	
	select max(version_number)
	into v_version_number
	from labwpl.labwpl_asset_draft
	where asset_id = v_video_id
	and asset_type_id = 4;
	
	select asset_data 
	into v_asset_data_json
	from labwpl.labwpl_asset_draft
	where asset_id=v_video_id
	and asset_type_id = 4
	and version_number=v_version_number;
	
	v_asset_data_json:=jsonb_set(v_asset_data_json, '{data,status}','0', true);
	v_asset_data_json:=jsonb_set(v_asset_data_json, '{data,is_publish}','0', true);
	v_asset_data_json:=jsonb_set(v_asset_data_json, '{data,is_trashed}','1', true);
	
	
	
	update labwpl.labwpl_video
	set is_published=0,
	is_trashed=1,
	is_active = 0,
	is_deleted = 1
	where video_id = v_video_id;
	
	update labwpl.labwpl_asset_list
	set is_published=0,
	is_trashed=1,
	is_active = 0,
	is_deleted = 1
	where asset_id = v_video_id
	and asset_type_id = 4;
	
	
	insert into labwpl.labwpl_asset_draft
	values(nextval('labwpl.seq_labwpl_asset_draft_id'),v_video_id,4,v_version_number+1,v_asset_data_json,current_timestamp,current_timestamp,41,41,1,0,uuid_generate_v4());
	
	p_output_json:= v_asset_data_json;
	p_result:=1;
	
	
	end if;
end ;
$$;


--
