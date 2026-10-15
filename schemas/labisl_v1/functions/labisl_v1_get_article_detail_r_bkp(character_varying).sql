-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_get_article_detail_r_bkp(character varying)
-- Type: FUNCTION

-- Name: labisl_v1_get_article_detail_r_bkp(character varying); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_get_article_detail_r_bkp(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_versionnumber numeric;
	v_articleid numeric;
	v_titlealias text := lower(p_titlealias);
	v_image_caption varchar(4000);
	v_authorjsonarr jsonb[];
	v_authorjson jsonb;
	-- v_json1 varchar(30000) := '{"authors":[';
	v_author_count numeric;
	v_primary_ent_id numeric;
	v_secondary_ent_id numeric;
	v_asset_type_id numeric:=1;
	v_language_id numeric;
	v_entjsonarr jsonb[];
	v_entjson jsonb;
	--  v_json2 varchar(30000) := '{"entities":[';
	v_ent_count numeric;
	v_lang_master_id numeric;
	v_copyrighttext varchar(4000);
	v_imageid numeric;
	v_modifieddate timestamp;
	v_sysdate timestamp := current_timestamp at time zone 'utc';
	v_lang_id numeric;
	v_logo text;
	v_link text;
	v_cpname text;
	v_tagged_entitiy integer[];
	v_entity_json jsonb;
	v_common_entities integer[];
	
begin
	
	
	select asset_id, published_version_number, updated_date, tagged_entity, web_detail_jsn, language_id, primary_entity_role_map_id,
			secondary_entity_role_map_id
	into strict v_articleid, v_versionnumber, v_modifieddate, v_tagged_entitiy, p_articlejson, v_language_id, v_primary_ent_id,
			v_secondary_ent_id
	from labisl_v1.labisl_v1_asset_list
	where lower(title_alias) = v_titlealias
	and published_date <= v_sysdate
	and asset_type_id = 1
	and is_published = 1;
	
	
	
	select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
	into v_logo, v_link, v_cpname
	from labisl_v1.labisl_v1_asset_list sl
	inner join labisl_v1.labisl_v1_provider_author_map PAM
	on sl.author_id = PAM.author_id
	inner join labisl_v1.labisl_v1_content_provider CP
	on PAM.content_provider_id = CP.content_provider_id
	where sl.asset_id = v_articleid
	and sl.asset_type_id = v_asset_type_id;
	
	
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson,'{data,modified_date}',('"'||v_modifieddate||'"')::text::jsonb);
	

	p_result := 1;
	

exception when others 
then 
p_result := -1;
p_articlejson :='{"Error":"Some error found"}';

end;
$$;


--
