-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_asset_listing_by_cat_json_r(numeric, numeric, numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: labbsc_dev_get_asset_listing_by_cat_json_r(numeric, numeric, numeric[], numeric[], character varying); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_asset_listing_by_cat_json_r(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$ 

declare
	
    v_createdbyquery varchar(50) := ' ';
    v_searchkeyword varchar(4000) := p_searchkeyword;
    v_entitysearchquery varchar(4000) := ' ';
    v_searchdraftquery varchar(200) := ' ';
    v_searchassetquery varchar(200) := ' ';
    v_drafassetcount numeric := 0;
    v_assetdraftidarr numeric[];
    v_assetdraftid numeric;
    v_titlealias json;
    v_entityjson json;
    v_entity json;
    v_entitymasterid numeric;
    v_priority numeric;
    v_assetcount numeric := 0;
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_count numeric;
    v_assetjsonarr jsonb[];
    v_assetjson jsonb;
    v_asset_count numeric:=0;
    v_asset_type_id numeric := 2;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_assettypeidcount numeric;
    v_assettypequery varchar(4000) := ' ';
    v_entityrolemapidquery varchar(4000) := ' ';
    v_qry_str varchar(100000);
	v_language_id numeric;
	v_lang_master_id numeric;
    v_asset_count_json jsonb;
    v_asset_cur_json jsonb;
    v_category_cur_json jsonb;
    v_data_json jsonb;
    v_json text;
    
begin
	
    v_sysdate:= current_timestamp at time zone 'utc';
    
    select count(1)
    into   v_ent_count
    from   unnest(p_entityrole_mapid)entity_id;
    
	select labbsc_dev.labbsc_dev_get_entity_language_from_entities(p_entityrole_mapid) into v_language_id;
    
    select entity_master_id into v_lang_master_id from labbsc_dev.labbsc_dev_entity_role_map where entity_role_map_id = v_language_id;
    
    if v_ent_count > 0 then
    	
        v_entityrolemapidquery := 'and exists (select 1
        						   from labbsc_dev.labbsc_dev_asset_entity_map eam
                                   where eam.asset_id = sl.asset_id
                                   and eam.asset_type_id = sl.asset_type_id
                                   and eam.entity_role_map_id in (select entity_role_mapid
                                   								  from unnest($2) u(entity_role_mapid))
								   group by eam.asset_id,eam.asset_type_id
                                   having count(1)='||v_ent_count ||')';
		
    end if;
    
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if v_searchkeyword is not null then
		
        v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
        v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
		
	end if;
    
    select count(asset_type_id) into v_assettypeidcount from unnest(p_asset_type_id) u(asset_type_id);
    
    if v_assettypeidcount > 0 then
    	
        v_assettypequery := 'and sl.asset_type_id in(select asset_type_id from unnest($1) u(asset_type_id))';
        
    end if;
    
    v_qry_str:= 'select array_to_json(array_agg(row_to_json(t)))
     from (select  count(1) cnt, eamc.entity_role_map_id as sentid
                 from   labbsc_dev.labbsc_dev_asset_list sl
                 join   labbsc_dev.labbsc_dev_entity_role_map erm
                 on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
                 join   labbsc_dev.labbsc_dev_asset_entity_map eamc
                 on     eamc.asset_id = sl.asset_id
                 and    eamc.asset_type_id = sl.asset_type_id
                 and    eamc.entity_role_map_id in (select em.entity_role_map_id   
                 									from labbsc_dev.labbsc_dev_entity_role_map em
                                                    join labbsc_dev.labbsc_dev_entity_master e
                                                    on e.entity_master_id=em.entity_master_id
                                                    where entity_role_id in(select entity_role_id 
                                                    						from labbsc_dev.labbsc_dev_entity_category 
                                                                            where category_name='||'''category type'''||' )
													and e.is_active=1
                                                    and    em.priority>0)
				 where  sl.is_active=1
                 and    sl.is_deleted=0
                 and    sl.is_published=1
                 and    sl.published_date<='''||v_sysdate||'''
                 and    sl.asset_type_id in (1,2,4,5,6) 
                 and    erm.priority>0  '
                 ||v_assettypequery
                 ||v_entityrolemapidquery
                 ||v_entitysearchquery
                 ||' group by eamc.entity_role_map_id 
                 order by eamc.entity_role_map_id)t' ;
	
    execute  v_qry_str
    into v_asset_count_json
    using  p_asset_type_id,p_entityrole_mapid ;
	
    v_qry_str:= 'select array_to_json(array_agg(row_to_json(t)))
     from (select * from (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
                                    primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration,
                                show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, sl.created_date, sl.updated_date,
                                sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid,
                                show_copyright, order_number, image_file_name, image_path,
                                rank()over (partition by secondary_entity_role_map_id order by sl.published_date desc) as rno,
                                labbsc_dev.labbsc_dev_get_user_display_name(sl.author_id) user_name,emp.entity_name primary_entity_name,
                                ems.entity_name secondary_entity_name,erms.priority sent_priority
                                from labbsc_dev.labbsc_dev_asset_list sl
                                join   labbsc_dev.labbsc_dev_entity_role_map ermp
                                on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                                join   labbsc_dev.labbsc_dev_entity_role_map erms
                                on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                                join   labbsc_dev.labbsc_dev_entity_master emp
                                on     emp.entity_master_id = ermp.entity_master_id
                                join   labbsc_dev.labbsc_dev_entity_master ems
                                on     ems.entity_master_id = erms.entity_master_id
                                where sl.is_active=1
                                and sl.is_deleted=0
                                and    sl.is_published=1
                                and    sl.published_date<='''||v_sysdate||'''
                                and    sl.asset_type_id in (1,2,4,5,14)
                                and    erms.priority>0 '
                                ||v_assettypequery
                                ||v_entityrolemapidquery
                                ||v_entitysearchquery
                                ||')  as tab1
                                where rno between '||v_fromrownumber||' and '||v_torownumber||'
                                order by sent_priority,rno)t';
	
    execute v_qry_str
    into v_asset_cur_json
    using   p_asset_type_id,p_entityrole_mapid;
    
    select array_to_json(array_agg(row_to_json(t)))
     from (
    select em.entity_role_map_id entid,coalesce(elm.entity_display_name, e.entity_display_name) as entity_name, e.entity_display_name entity_eng_name
    from labbsc_dev.labbsc_dev_entity_role_map em
    join labbsc_dev.labbsc_dev_entity_master e
    on e.entity_master_id=em.entity_master_id
	left join labbsc_dev.labbsc_dev_entity_language_map elm
    on elm.entity_master_id = e.entity_master_id
    and elm.language_master_id = v_lang_master_id
	where entity_role_id in (select entity_role_id from labbsc_dev.labbsc_dev_entity_category where category_name='category type')
    and e.is_active=1 
    and    em.priority>0)t
    into v_category_cur_json;
    
    select '{"data":'||array_to_json(array_agg(row_to_json(t)))||'}'
    from (
        	select current_timestamp at time zone 'utc' today_date, entity_name as name, cnt as count,
        		   (select array_to_json(array_agg(c))
                    from   (select *
                            from (select (json_array_elements(v_asset_cur_json::json)->>'asset_list_id')::numeric,
                                  		 (json_array_elements(v_asset_cur_json::json)->>'asset_id')::numeric,
                                  		 (json_array_elements(v_asset_cur_json::json)->>'asset_type_id')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'asset_title'),
                                  		 (json_array_elements(v_asset_cur_json::json)->>'title_alias'),
                                  		 (json_array_elements(v_asset_cur_json::json)->>'author_id')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'short_desc'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'tags'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'primary_entity_role_map_id')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'secondary_entity_role_map_id')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'total_assets')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'image_file_name'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'image_path'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'duration'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'show_in_web')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'show_in_mobile')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'show_in_app')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'published_version_number')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'is_trashed')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'created_date')::varchar,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'updated_date')::varchar,
                            	   	  	 (json_array_elements(v_asset_cur_json::json)->>'created_by')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'updated_by')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'is_active')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'is_deleted')::numeric,
                            	   	  	 (json_array_elements(v_asset_cur_json::json)->>'is_published')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'published_date')::varchar,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'asset_guid')::varchar,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'show_copyright')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'order_number')::numeric,
                            	   	     (json_array_elements(v_asset_cur_json::json)->>'image_file_name'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'image_path'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'rno')::numeric,
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'user_name'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'primary_entity_name'),
                            	   		 (json_array_elements(v_asset_cur_json::json)->>'secondary_entity_name'),
                            	   	  	 (json_array_elements(v_asset_cur_json::json)->>'sent_priority')::numeric
                                 ) d(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
                                     primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration,
                                     show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, updated_date,
                                     created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid, show_copyright,
                                     order_number, image_file_name, image_path, rno, user_name, primary_entity_name, secondary_entity_name,
                                     sent_priority)
                            where d.secondary_entity_role_map_id = a.sentid
                           )c
                   )asset_data
        	from (select (json_array_elements(v_asset_count_json::json)->>'sentid')::numeric,
                  	     (json_array_elements(v_asset_count_json::json)->>'cnt')::numeric) a(sentid, cnt)
			left join (select (json_array_elements(v_category_cur_json::json)->>'entity_name'),
                  	     	  (json_array_elements(v_category_cur_json::json)->>'entid')::numeric) b(entity_name,entid)
		   	on b.entid = a.sentid
    	 )t
    into v_data_json;
    
    v_json := '{"content" : {'||trim(trailing '}' from trim(leading '{' from v_data_json::text))||',
    						 "cat_data" : '||trim(trailing '}' from trim(leading '{' from v_category_cur_json::text))||'},
				"imagesdata" : null,
                "authordata" : null,
                "nextprev" : null,
                "entitydata" : null
                }';
	
    p_json := v_json::jsonb;
    
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

 $_$;


--
