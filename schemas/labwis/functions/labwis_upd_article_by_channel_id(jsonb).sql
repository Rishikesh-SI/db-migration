-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_upd_article_by_channel_id(jsonb)
-- Type: FUNCTION

-- Name: labwis_upd_article_by_channel_id(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_upd_article_by_channel_id(p_input jsonb, OUT p_output jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_channel_id text;  
    v_articl_list jsonb; 
    v_json jsonb; 
    v_article_record jsonb; 
    v_article_id text;
    v_title_alias text;
	v_published_date character varying;
	v_published_version_number numeric;
	v_count numeric;
BEGIN
    select p_input->'data'->>'channel_id' INTO v_channel_id;
    select p_input->'data'->>'published_date' INTO v_published_date;

-- raise notice 'v_channel_id:%',v_channel_id;
-- raise notice 'v_published_date:%',v_published_date;

select json_agg( json_build_object('data', 
            json_build_object(
                'asset_id', t.asset_id,
                'title_alias', t.title_alias,
                'entitydata', t.entitydata )))::jsonb INTO v_articl_list
from (
    select asset_id, title_alias,(web_detail_jsn->'data'->>'entitydata')::jsonb as entitydata
    from labwis.labwis_asset_list
    where web_detail_jsn->'data'->'topic'->>'channel_id' = v_channel_id  and asset_type_id = 1 
)t;

--RAISE NOTICE 'v_articl_list: %', v_articl_list;

    if v_articl_list IS NULL THEN
        p_output := '{}'::jsonb;
        RETURN;
    end if;

    p_output :=  v_articl_list ;
--raise notice 'p_output:%',p_output;
raise notice 'v_articl_list %',v_articl_list;

    FOR v_article_record IN
        select * from jsonb_array_elements(v_articl_list) as articles
    LOOP

        v_article_id := v_article_record->'data'->>'article_id';
        v_title_alias := v_article_record->'data'->>'title_alias';

raise notice 'v_article_record:%',v_article_record;
-- raise notice 'v_article_id:%',v_article_id;
-- raise notice 'v_title_alias:%',v_title_alias;

        select web_detail_jsn,published_version_number INTO v_json,v_published_version_number
        from labwis.labwis_asset_list
        where asset_id = v_article_id::int
          and title_alias = v_title_alias
          and asset_type_id = 1;
raise notice 'v_json %',v_json;

        if v_json IS NOT NULL THEN
            v_json := jsonb_set(v_json, '{data,updated_date}', to_jsonb(v_published_date::timestamp),true);

            UPDATE labwis.labwis_asset_list
            set updated_date = v_published_date::timestamp,
                web_detail_jsn = v_json
            where asset_id = v_article_id::int
              and title_alias = v_title_alias
              and asset_type_id = 1;

            UPDATE labwis.labwis_asset_draft
            set asset_data = v_json
            where asset_id = v_article_id::int
              and asset_type_id = 1 
		  	and version_number= v_published_version_number::int;    

            UPDATE labwis.labwis_article
            set updated_date = v_published_date::timestamp
            where article_id = v_article_id::int;
			
            p_result := 1;
        end if;
    end LOOP;

    RETURN;
end;
$$;


--
