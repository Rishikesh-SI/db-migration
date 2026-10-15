-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_get_asset_listing_by_title(numeric, numeric, character varying, numeric[])
-- Type: FUNCTION

-- Name: labgsoc_get_asset_listing_by_title(numeric, numeric, character varying, numeric[]); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_get_asset_listing_by_title(p_pagenumber numeric, p_itemnumber numeric, p_searchwords character varying, p_entityrolemapid numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
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
     v_entitycount numeric := 0;
     v_assetfilterquery varchar(4000) := ' ';
    
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_searchwords is not null then
     	
     	v_searchwords := p_searchwords;
          -- v_searchquery := ' and asset_title like ''%''||'||'$1'||'||''%'' ';
          v_searchwords:='*'|| replace(''||v_searchwords||'',' ',':* & *') ||':*';
          v_searchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchwords||''') 
          					or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchwords||'''))';
		
     end if;
	
     select count(1)
	into   v_entitycount
	from   (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
	
	if v_entitycount > 0 then
     	
          v_assetfilterquery := ' and (sl.asset_id, sl.asset_type_id) in(select eam.asset_id, eam.asset_type_id
          						from   labgsoc.labgsoc_asset_entity_map eam
                                        where  eam.asset_type_id = sl.asset_type_id
                                         and  eam.asset_id = sl.asset_id
                                        and    eam.entity_role_map_id in (select entityid
                                        							from unnest($1) u(entityid))
								group by eam.asset_id, eam.asset_type_id
                                        having count(1) = '||v_entitycount||') ';
			
	end if;
     
     execute'select count(1)
             from   labgsoc.labgsoc_asset_list sl
             where  1=1'
             ||v_searchquery
             ||v_assetfilterquery
	into   v_assetcount
     using p_entityrolemapid;
     
     execute 'select array(select row_to_json(row) as jsonrow
                  from (select *
                        from (
                        select asset_list_id,
                        sl.asset_id, sl.asset_type_id, 
                        asset_title,
                        sl.title_alias, author_id,
                        short_desc, tags,
                        primary_entity_role_map_id,
                              secondary_entity_role_map_id,
                              total_assets, image_file_name, 
                              image_path, duration,
                              show_in_web,
                              show_in_mobile, 
                              show_in_app,
                              sl.published_version_number,
                              sl.is_trashed,
                              sl.created_date, 
                              sl.updated_date, 
                              sl.created_by, 
                              sl.updated_by, 
                              sl.is_active, 
                              sl.is_deleted, 
                              sl.is_published, 
                              sl.published_date,
                              asset_guid,
                              show_copyright, sl.order_number,
                              image_file_name, image_path, 
                              rank() over (order by sl.asset_id) as rno,
                              u.user_name, em.entity_name,
                              erm1.entity_role_map_id l_entity_id ,
                              em1.entity_name as l_entity_name,
                              st.channel_id
                              from labgsoc.labgsoc_asset_list sl
                              left join labgsoc.labgsoc_topic st
                              on sl.asset_id=st.topic_id and sl.asset_type_id=5
                              join labgsoc.labgsoc_user u
                              on u.user_id = sl.author_id
                              and sl.is_active = 1
                              and sl.is_deleted = 0
                              join labgsoc.labgsoc_asset_entity_map aem
                              on aem.asset_type_id = sl.asset_type_id
                              and aem.asset_id = sl.asset_id
                              join labgsoc.labgsoc_entity_role_map erm
                              on erm.entity_role_map_id = aem.entity_role_map_id
                              and erm.entity_role_map_id = primary_entity_role_map_id
                              join labgsoc.labgsoc_entity_master em
                              on em.entity_master_id = erm.entity_master_id
                              join labgsoc.labgsoc_asset_entity_map aem1
                              on aem1.asset_type_id = sl.asset_type_id
                              and aem1.asset_id = sl.asset_id
                              join labgsoc.labgsoc_entity_role_map erm1
                              on erm1.entity_role_map_id = aem1.entity_role_map_id
                              and erm1.entity_role_map_id in(select erm2.entity_role_map_id
                              						 from   labgsoc.labgsoc_entity_role_map erm2
                                                             join   labgsoc.labgsoc_entity_master em2
                                                             on     em2.entity_master_id = erm2.entity_master_id
                                                             join   labgsoc.labgsoc_entity_category ec
                                                             on     ec.entity_role_id = erm2.entity_role_id
                                                             where  erm2.entity_role_id in (select entity_role_id
                                                             						 from   labgsoc.labgsoc_entity_category c1
                                                                                           join   unnest(array[''language'']) m(category_name)
                                                                                           on     m.category_name = c1.category_name
                                                                                           where  c1.is_active = 1
                                                                                           and    c1.is_deleted = 0
                                                                                           and    c1.is_published = 1)
												 and erm2.is_active = 1)
                              join labgsoc.labgsoc_entity_master em1
                              on em1.entity_master_id = erm1.entity_master_id'
                              ||v_searchquery
                              ||' '||
                              'where  sl.is_published=1'
                              ||v_assetfilterquery||
                              ' ) as tab1
					where rno between '||'$2'||' and '||'$3'||'
                      ) row
                 )'
	into v_assetjsonarr
     using p_entityrolemapid, v_fromrownumber, v_torownumber;
     
     foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
     
     select count(1)
    	into    v_asset_count
    	from    unnest(v_assetjsonarr) asset_id;
      
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     if v_asset_count>0 then
        v_json:= substring(v_json,1,(length(v_json)-1));
     else 
        v_json:= substring(v_json,1,(length(v_json)));
     end if;
     
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
