-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_get_content_type_detail_r(numeric)
-- Type: FUNCTION

-- Name: labetpl_get_content_type_detail_r(numeric); Type: FUNCTION; Schema: labetpl; Owner: -
--

CREATE FUNCTION labetpl.labetpl_get_content_type_detail_r(p_content_type_id numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
v_content_type_fields jsonb;

begin

select row_to_json(x) from
(
select a.title as contenttype,a.asset_type_id as content_type_id,a.asset_desc as description,a.is_content_type,a.component_id,a.status,a.custom_meta_info,a.is_publish
from labetpl.labetpl_asset_type a
where a.asset_type_id = p_content_type_id
)x
into p_data;
 
 select json_agg(tab) from
 (
SELECT b.content_type_field_id as content_field_id,b.content_type_id, b.field_name, b.field_data_type, b.field_defaultvalue, b.field_type, b.field_label, b.show_in_listing_json, b.is_active, b.is_deleted, b.created_date,b.updated_date, b.created_by, b.updated_by,b.order_no, b.settingjson::text, b.is_required
	 from labetpl.labetpl_content_type_fields b 
 left join labetpl.labetpl_asset_type a
 on a.asset_type_id = b.content_type_id
 where b.content_type_id = p_content_type_id	
 )tab
 into v_content_type_fields;
 
 p_result:=1;
 p_data := jsonb_set(p_data,'{content_type_fields}',coalesce(v_content_type_fields,'[]'),true);
-- p_user_json :=jsonb_set(p_user_json,'{permission}',coalesce(p_data,'{}'),true);
if p_data is null then
	   p_result:=-1;
	   p_data:='{
	   "ErrorMessage":"Something Went Wrong"
	   }';      
end if;
end

$$;


--
