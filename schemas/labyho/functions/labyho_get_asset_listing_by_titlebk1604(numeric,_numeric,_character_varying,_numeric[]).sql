-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_asset_listing_by_titlebk1604(numeric, numeric, character varying, numeric[])
-- Type: FUNCTION

-- Name: labyho_get_asset_listing_by_titlebk1604(numeric, numeric, character varying, numeric[]); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_asset_listing_by_titlebk1604(p_pagenumber numeric, p_itemnumber numeric, p_searchwords character varying, p_entityrolemapid numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
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
         /* v_searchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchwords||''') 
          					or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchwords||'''))';
		*/
		v_searchquery :=' and sl.tvs @@ to_tsquery( '''||v_searchwords||''')';
     end if;
	--raise notice '%',v_searchquery;
	--select 1/0;
     select count(1)
	into   v_entitycount
	from   (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
	
	if v_entitycount > 0 then
     	
          v_assetfilterquery := 'and tagged_entity @> $1 ';
			
	end if;
     
     execute'select count(1)
             from   labyho.labyho_asset_list sl
             where  1=1'
             ||v_searchquery
             ||v_assetfilterquery
	into   v_assetcount 
     using p_entityrolemapid::int[];
     
     execute 'select (''{"items":''||json_agg(row)::text||''}'')::jsonb
                  from ( select * from (select 
                        	  sl.asset_id, 
							  sl.asset_type_id, 
                              asset_title,
                              sl.title_alias, 
							  sl.author_id,
                              short_desc, 
                              image_file_name, 
							  image_path, 
                              rank() over (order by sl.asset_id) as rno,
                              u.user_name, 
                              sl.language_id l_entity_id                 
                              from labyho.labyho_asset_list sl
                              join labyho.labyho_user u
                              on u.user_id = sl.author_id
                              and sl.is_active = 1
                              and sl.is_deleted = 0
                              and  sl.is_published=1
							  and sl.asset_type_id in (1,5)'
                              ||v_searchquery
                              ||' '||
                              'where  sl.is_published=1'
                              ||v_assetfilterquery||
                              ' order by published_date desc 
							  ) as tab1
					where rno between '||'$2'||' and '||'$3'||'
                     ) row
                 '
	into p_assetjson
     using p_entityrolemapid::int[], v_fromrownumber, v_torownumber;
     
     p_assetcount := v_assetcount;
          
exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
     
end;

 $_$;


--
