-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_upd_topic_data(jsonb)
-- Type: FUNCTION

-- Name: labwis_upd_topic_data(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_upd_topic_data(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_topic_id numeric;

begin

select p_in_json->'data'->>'topic_id'
into   v_topic_id;

-- if v_topic_id is not null THEN

-- 		update labwis.labwis_article
-- 		set updated_date = current_timestamp
-- 		where article_id in (select asset_id from labwis.labwis_asset_list where asset_type_id=1 and 
-- 		is_published=1 and is_trashed=0 and (web_detail_jsn->'data'->'topic'->>'channel_id')::numeric=v_topic_id);
		
-- 		with topic_data as (select asset_id,published_version_number,is_published,is_trashed from labwis.labwis_asset_list where asset_type_id=1 and (web_detail_jsn->'data'->'topic'->>'channel_id')::numeric=v_topic_id)
-- 		update labwis.labwis_asset_draft c set asset_data = 
-- 		jsonb_set(asset_data, '{data,modified_date}', to_jsonb(current_timestamp))
-- 		from topic_data d 
-- 		where c.asset_type_id = 1 and c.asset_id=d.asset_id
-- 		and d.is_published=1 and d.is_trashed=0	and c.version_number >= d.published_version_number;
		
-- 		update labwis.labwis_asset_list
-- 		set updated_date = current_timestamp,
-- 		web_listing_json=jsonb_set(web_listing_json, '{updated_date}', to_jsonb(current_timestamp)),
-- 		web_detail_jsn = jsonb_set(web_detail_jsn, '{data,modified_date}', to_jsonb(current_timestamp))
-- 		where asset_type_id = 1 and asset_id in (select asset_id from labwis.labwis_asset_list 
-- 		where asset_type_id=1 and (web_detail_jsn->'data'->'topic'->>'channel_id')::numeric=v_topic_id
-- 		and is_published=1 and is_trashed=0);
		
-- 		select jsonb_agg(web_detail_jsn) into p_out_json from labwis.labwis_asset_list where asset_type_id=1 and (web_detail_jsn->'data'->'topic'->>'channel_id')::numeric=v_topic_id and is_published=1 and is_trashed=0;

-- end if;


end;
$$;


--
