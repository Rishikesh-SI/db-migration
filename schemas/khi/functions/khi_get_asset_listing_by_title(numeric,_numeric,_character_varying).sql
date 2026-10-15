-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_asset_listing_by_title(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: khi_get_asset_listing_by_title(numeric, numeric, character varying); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_asset_listing_by_title(p_pagenumber numeric, p_itemnumber numeric, p_searchwords character varying, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_assetcount numeric := 0;
    	v_fromrownumber numeric;
    	v_torownumber numeric;
     v_searchwords varchar(4000);
     v_searchquery varchar(4000) := ' ';
     v_assetjsonarr jsonb[];
    	v_assetjson jsonb;
    	v_json text := '{"items":[';
    	v_asset_count numeric:=0;
    
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_searchwords is not null then
     	v_searchwords := p_searchwords;
     --	v_searchquery := ' and asset_title like ''%''||'||'$1'||'||''%'' ';
      v_searchwords:='*'|| replace(''||v_searchwords||'',' ',':* & *') ||':*';
       v_searchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchwords||''') 
                                        OR   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchwords||'''))';
     
     end if;
	
     execute'select count(1)
             from   khi.khi_asset_list sl
             where  1=1'
             ||v_searchquery
	into   v_assetcount
     using  v_searchwords;
    
     execute 'select array(select row_to_json(row) as jsonrow
                  from (select *
                        from (select asset_list_id, sl.asset_id, sl.asset_type_id, asset_title, title_alias, author_id, short_desc, tags, primary_entity_role_map_id,
                              secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app, published_version_number,
                              is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid,
                              show_copyright, order_number, image_file_name, image_path, rank() over (order by sl.asset_id) as rno, u.user_name, entity_name
                              from khi.khi_asset_list sl
                              left join khi.khi_user u
                              on u.user_id = sl.author_id
                              and sl.is_active = 1
                              and sl.is_deleted = 0
                              
                              join khi.khi_asset_entity_map aem
                              on aem.asset_type_id = sl.asset_type_id
                              and aem.asset_id = sl.asset_id
                              join khi.khi_entity_role_map erm
                              on erm.entity_role_map_id = aem.entity_role_map_id
                              and erm.entity_role_map_id = primary_entity_role_map_id
                              join khi.khi_entity_master em
                              on em.entity_master_id = erm.entity_master_id'
                              ||v_searchquery||
                              '
                              where  sl.is_published=1) as tab1
					where rno between '||'$2'||' and '||'$3'||'
                      ) row
                 )'
	into v_assetjsonarr
     using v_searchwords, v_fromrownumber, v_torownumber;
     
     foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
     
     SELECT COUNT(1)
    	INTO    v_asset_count
    	FROM    UNNEST(v_assetjsonarr) asset_id;
      
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     IF v_asset_count>0 THEN
        V_JSON:= substring(v_json,1,(length(v_json)-1));
     ELSE 
        V_JSON:= substring(v_json,1,(length(v_json)));
     END IF;
     
     v_json := v_json||']}';
     
     p_assetjson  := v_json::jsonb;
     p_assetcount := v_assetcount;
          
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

$_$;


--
