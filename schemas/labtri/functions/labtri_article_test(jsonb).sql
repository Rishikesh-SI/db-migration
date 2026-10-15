-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_article_test(jsonb)
-- Type: FUNCTION

-- Name: labtri_article_test(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_article_test(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
    v_title_alias   character varying;
    v_asset_id      character varying;
    v_asset_type_id character varying;
    v_article_id    jsonb;
begin
    select array_agg(article_id) 
    into v_article_id 
    from labtri.labtri_article;

    
--     select json_agg(json_build_object('title_alias', title_alias, 'asset_id', asset_id, 'asset_type_id', asset_type_id))
--     into p_data
--     from labtri.labtri_asset_list
--     where asset_type_id in (
--         select asset_type_id 
--         from labtri.labtri_asset_type 
--         where title = 'article' )
--     and asset_id = any(v_article_id::text[]);

	   select (row_to_jsonb(title_alias,asset_id,asset_type_id))
		from labtri.labtri_asset_list
		where asset_type_id in (
			select asset_type_id 
			from labtri.labtri_asset_type 
			where title = 'article' )
		and asset_id = any(v_article_id::text[]);
	
	
-- 	select '{"data":' || '{"node":'|| json_agg(x) || '}' || '}' from (
--   select row_to_json(a) from (
--   select title_alias,asset_id,asset_type_id
--     from labtri.labtri_asset_list
--     where asset_type_id in (
--         select asset_type_id 
--         from labtri.labtri_asset_type 
--         where title = 'Article' )
--     and asset_id in (1281,1261,1241,1221))a)x
    
    p_result := 1;
end;
$$;


--
