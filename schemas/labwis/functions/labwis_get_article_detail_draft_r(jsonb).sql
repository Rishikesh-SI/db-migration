-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_article_detail_draft_r(jsonb)
-- Type: FUNCTION

-- Name: labwis_get_article_detail_draft_r(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_article_detail_draft_r(p_inputjson jsonb, OUT p_webjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_titlealias character varying;
    v_asset_id numeric;
    v_version_number numeric;
    v_asset_data jsonb;
	v_assettypeid numeric;

BEGIN

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'get_article_detail_draft_r','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labwis','logs');

select p_inputjson->>'title_alias',
		p_inputjson->>'assettypeid'
into v_titlealias, v_assettypeid;

-- raise notice 'v_titlealias :%',v_titlealias;
-- raise notice 'v_assettypeid :%',v_assettypeid;
-- raise notice 'v_asset_data1 :%',v_asset_data;
if v_assettypeid=1 then
select article_id into v_asset_id from labwis.labwis_article
where title_alias= v_titlealias and is_trashed=0 limit 1;

elsif v_assettypeid=4 then
select video_id into v_asset_id from labwis.labwis_video
where title_alias= v_titlealias and is_trashed=0 limit 1;

else
SELECT asset_id INTO v_asset_id
FROM labwis.labwis_asset_draft 
WHERE asset_data->'data'->>'slug_url' = v_titlealias AND asset_type_id = v_assettypeid;
end if;

SELECT MAX(version_number) into v_version_number
        FROM labwis.labwis_asset_draft
        WHERE asset_id =v_asset_id AND asset_type_id = v_assettypeid 
		and asset_data->'data'->>'status'='0';

-- raise notice 'v_asset_id :%',v_asset_id;
-- raise notice 'v_version_number :%',v_version_number;

SELECT asset_data INTO strict
    v_asset_data
FROM labwis.labwis_asset_draft
WHERE asset_id=v_asset_id
    AND asset_type_id = v_assettypeid::numeric
    AND version_number =v_version_number limit 1;
	
--raise notice 'v_asset_data2 :%',v_asset_data;

p_webjson := v_asset_data::jsonb;

EXCEPTION
    WHEN OTHERS THEN
        p_webjson := '{"Error": "No Draft data found for this url"}'::jsonb;
      
END;
$$;


--
