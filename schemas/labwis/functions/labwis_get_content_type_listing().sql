-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_content_type_listing()
-- Type: FUNCTION

-- Name: labwis_get_content_type_listing(); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_content_type_listing(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
    select jsonb_build_object('data',json_agg(tab)) from
     (
 SELECT a.title as content_type_name,a.asset_type_id as content_type_id,b.content_type_field_id as content_field_id,b.content_type_id, b.field_name, b.field_data_type, b.field_defaultvalue, b.field_type, b.field_label, b.show_in_listing_json, b.is_active, b.is_deleted, b.created_date,b.updated_date, b.created_by, b.updated_by,b.order_no, b.settingjson::text, b.is_required
         from labwis.labwis_content_type_fields b 
     left join labwis.labwis_asset_type a
     on a.asset_type_id = b.content_type_id
         and a.is_content_type=1
     where b.is_active=1
     )tab
     into p_data;

end;
$$;


--
