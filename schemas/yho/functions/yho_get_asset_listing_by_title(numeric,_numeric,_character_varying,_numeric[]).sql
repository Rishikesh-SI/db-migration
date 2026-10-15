-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_asset_listing_by_title(numeric, numeric, character varying, numeric[])
-- Type: FUNCTION

-- Name: yho_get_asset_listing_by_title(numeric, numeric, character varying, numeric[]); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_asset_listing_by_title(p_pagenumber numeric, p_itemnumber numeric, p_searchwords character varying, p_entityrolemapid numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

 

declare
	/*	p_pagenumber numeric:=1;
	p_itemnumber numeric:=25;
	p_searchwords character varying  :='sachin';
	p_entityrolemapid numeric[]:=array[35369];
	 p_assetcount numeric;
	 p_assetjson jsonb;*/
     v_assetcount numeric := 0;
    	v_fromrownumber numeric;
    	v_torownumber numeric;
     v_searchwords varchar(4000):=p_searchwords;
     v_searchquery varchar(4000) := ' ';
     v_assetjsonarr jsonb[];
    	v_assetjson jsonb;
    	v_json text := '{"items":[';
    	v_asset_count numeric:=0;
     v_entitycount numeric := 0;
     v_assetfilterquery varchar(4000) := ' ';
    v_str text;
	 v_limit numeric;
    v_offset numeric;
	 v_asset_list_id_arr numeric[];
	 v_assettypequery text;
begin
	
   -- v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  --	v_torownumber   := (p_pagenumber * p_itemnumber);
      v_limit := p_itemnumber;
    v_offset := ((p_pagenumber - 1) * p_itemnumber);
	
   /*  if p_searchwords is not null then
     	
     	v_searchwords := p_searchwords;
          -- v_searchquery := ' and asset_title like ''%''||'||'$1'||'||''%'' ';
          v_searchwords:='*'|| replace(''||v_searchwords||'',' ',':* & *') ||':*';
		    
          v_searchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchwords||''') 
          					OR   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchwords||'''))';
		
		  
        ---  v_searchquery := ' and ( sl.asset_title like '''||'%'||p_searchwords||'%'||''' 
          ---					OR    sl.short_desc  like  '''||'%'||p_searchwords||'%'||''')';
		
     end if;*/
     
      select count(1)
	into   v_entitycount
	from   (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
	
	if v_entitycount > 0 then
     	
        v_assettypequery := 'and sl.asset_type_id in(select asset_type_id from unnest($1) u(asset_type_id))';
		v_assetfilterquery:= ' and exists (select 1 from yho.yho_asset_entity_map eam
                                			where eam.asset_id = sl.asset_id
                                            and eam.asset_type_id = sl.asset_type_id
                                            and eam.entity_role_map_id in (select entity_role_mapid from unnest($3) u(entity_role_mapid))
                                            group by eam.asset_id, eam.asset_type_id
                                            having count(1) = $4) '	;
	end if;
     
      if p_searchwords is not null then
    	
        execute 'select array(select sl.asset_list_id
        						from yho.yho_asset_list sl, plainto_tsquery($2) as q
                                where sl.is_active = 1
                                and sl.is_deleted = 0
                                and sl.is_published = 1
                               ' ||v_assetfilterquery || '
                                
								and (tvs @@ q)
                                       
                                       
                                        )'
                            
		into v_asset_list_id_arr
    	using null, v_searchwords, p_entityrolemapid, v_entitycount,v_limit,v_offset;
		
    else
    	
        execute 'select array(select sl.asset_list_id
        						from yho.yho_asset_list sl
                                where sl.is_active = 1
                                and sl.is_deleted = 0
                                and sl.is_published = 1
                              
                                
                               '|| v_assetfilterquery ||'
                                           
                                        '
		into    v_asset_list_id_arr
    	using   null, p_entityrole_mapid, v_entitycount,v_limit,v_offset;
        
    end if;
     
    
     
	-- raise notice 'v_searchquery: %', v_searchquery;
    
     
    execute' select count(1)
             from   yho.yho_asset_list sl
             where  sl.asset_list_id in 
             (select asset_list_id from
             unnest($2)U(asset_list_id)) '
             
           
	into   v_assetcount
     USING p_entityrolemapid,v_asset_list_id_arr;
     												 
															 
     execute 'select array(select row_to_json(row) as jsonrow
                 from (select *  from (select asset_list_id, sl.asset_id, sl.asset_type_id, asset_title, title_alias, author_id, short_desc, tags, primary_entity_role_map_id,
                              secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app, published_version_number,
                              is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid,
                              show_copyright, order_number, image_file_name, image_path, u.user_name, em.entity_name,
                              35369 l_entity_id ,''English'' as l_entity_name
                              from yho.yho_asset_list sl
                              join yho.yho_user u
                              on u.user_id = sl.author_id
                              and sl.is_active = 1
                              and sl.is_deleted = 0
                              join yho.yho_asset_entity_map aem
                              on aem.asset_type_id = sl.asset_type_id
                              and aem.asset_id = sl.asset_id
                              join yho.yho_entity_role_map erm
                              on erm.entity_role_map_id = aem.entity_role_map_id
                              and erm.entity_role_map_id = primary_entity_role_map_id
                              join yho.yho_entity_master em
                              on em.entity_master_id = erm.entity_master_id
                             
                              where  sl.is_published=1
						and sl.asset_list_id in (select asset_list_id from unnest($4) u(asset_list_id)) 
                              
                              order by sl.published_date desc
						 limit $3
                                 offset $2	) as tab1
					
                      ) as row ) '
               
	into v_assetjsonarr
     using p_entityrolemapid, v_offset, v_limit,v_asset_list_id_arr;
     
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
   --  	raise notice 'p_assetcount: %',v_assetcount;
     p_assetjson  := v_json::jsonb;
	-- raise notice 'p_assetjson: %',p_assetjson;										
     p_assetcount := v_assetcount;
											
          
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

 

$_$;


--
