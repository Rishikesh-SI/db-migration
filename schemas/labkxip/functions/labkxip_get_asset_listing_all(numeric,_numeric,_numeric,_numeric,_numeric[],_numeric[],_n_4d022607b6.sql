-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_get_asset_listing_all(numeric, numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: labkxip_get_asset_listing_all(numeric, numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_get_asset_listing_all(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
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
    v_json text := '{"items":[';
    v_asset_count numeric:=0;
    v_asset_type_id numeric:=2;
    v_sysdate timestamp;
    v_ent_count numeric;
    
    v_draftcreatedbyquery   varchar(500) := ' ';
     v_assetcreatedbyquery varchar(500) := ' ';
     v_assetfilterquery varchar(4000) := ' ';
     v_assettypefilterquery varchar(4000) := ' ';  
     v_anyentfilterquery varchar(4000) := ' ';  
     v_any_ent_count numeric;
     v_asset_type_count numeric;
     
     
begin
    v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     select count(1)
     into   v_any_ent_count
     from   unnest(p_any_entityrole_mapid)entity_id;
     
     select count(1)
     into   v_asset_type_count
     from   unnest(p_asset_type_id)entity_id;
     
   v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
   create temp table if not exists t_allassetdata
     (
         asset_id numeric,
         asset_type_id numeric         
     );
   create temp table if not exists t_anyassetdata
     (
         asset_id numeric,
         asset_type_id numeric         
     );
    if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and (ad.asset_id,ad.asset_type_id) 
                                        in(select asset_id,asset_type_id
                                        from labkxip.labkxip_author_action
                                               where action_id = 4 
                                               and author_id = $2) ';
		
     	v_assetcreatedbyquery := ' and (sl.asset_id,sl.asset_type_id) 
                                    in(select asset_id,asset_type_id
                                        from labkxip.labkxip_author_action
                                             where action_id = 4 
                                             and author_id = $5) ';
		
  	end if;
    
    if v_searchkeyword is not null then
     	
--              v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( '||'$1'||')';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
              
--              v_entitysearchquery := ' and ( to_tsvector( al.asset_title) @@@ to_tsquery( '||'$1'||') 
--                                        or   to_tsvector( al.short_desc) @@@ to_tsquery( '||'$1'||'))';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
          if p_status = 0 then
          		v_searchkeyword := replace(v_searchkeyword,'''','''''');
                v_searchkeyword := replace(v_searchkeyword,':','');
                
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                
                v_entitysearchquery := ' and ( to_tsvector( asset_data->''data''->>''title'') @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( asset_data->''data''->>''intro_text'') @@@ to_tsquery( '''||v_searchkeyword||''')
                                        or   to_tsvector( asset_data->''data''->>''desc'') @@@ to_tsquery( '''||v_searchkeyword||''')
                                        or   to_tsvector( asset_data->''data''->>''album_desc'') @@@ to_tsquery( '''||v_searchkeyword||''')
                                        )';
          elsif p_status in (1,2) then
          		v_searchkeyword := replace(v_searchkeyword,'''','''''');
                v_searchkeyword := replace(v_searchkeyword,':','');
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
          end if;
          
     end if;
    
    
    if v_ent_count > 0 and p_status = 0 then
       
          execute ' with entitydata(t_json)
          as(select ((asset_data->''data''->>''entitydata'')::json), asset_id, asset_type_id
              from labkxip.labkxip_asset_draft ad
              where 1=1
              -- asset_type_id = '||v_asset_type_id||'
              ' || v_entitysearchquery || '
              and version_number=(select max(version_number)
                                  from labkxip.labkxip_asset_draft adi
                                  where adi.asset_id=ad.asset_id
                                  and   adi.asset_type_id=ad.asset_type_id)
			and (asset_data->''data''->''entitydata'') is not null
               and (asset_data->''data''->>''entitydata'')  like ''%[%''
            )
         insert into t_allassetdata
         select asset_id, asset_type_id
         from (
                 select  obj->>''entity_role_map_id'' , asset_id, asset_type_id
                 from   entitydata ci, json_array_elements(ci.t_json#>''{}'') obj
                 where  (obj->>''entity_role_map_id'')::numeric in 
                       (select entityid from unnest($1) u(entityid)) 
               ) jd
               group by asset_id, asset_type_id
               having count(1) = '||v_ent_count||' '
         using p_entityrole_mapid; 
            
            if exists (select 1 from t_allassetdata) then
            	
            	v_assetfilterquery := ' and (ad.asset_id,ad.asset_type_id) 
                                    in (select aad.asset_id,aad.asset_type_id from t_allassetdata aad) ';
            	
            end if;
    
    end if;
    if v_any_ent_count > 0 and p_status = 0 then
       
          execute 'with entitydata(t_json)
          as(select (asset_data->''data''->>''entitydata'')::json,asset_id,asset_type_id
              from labkxip.labkxip_asset_draft ad
             -- where asset_type_id = '||v_asset_type_id||'
              and version_number=(select max(version_number)
                                  from labkxip.labkxip_asset_draft adi
                                  where adi.asset_id=ad.asset_id
                                  and   adi.asset_type_id=ad.asset_type_id)
			and (asset_data->''data''->''entitydata'') is not null
               and (asset_data->''data''->>''entitydata'')  like ''%[%''
            )
         insert into t_anyassetdata
         select distinct asset_id,asset_type_id
         from (
         select  obj->>''entity_role_map_id'' , asset_id, asset_type_id
         from   entitydata ci, json_array_elements(ci.t_json#>''{}'') obj
         where  (obj->>''entity_role_map_id'')::numeric in 
               (select entityid from unnest($1) u(entityid))) jd '
         using v_any_ent_count;
      
            
            if exists (select 1 from t_anyassetdata) then 
            	
            	v_assetfilterquery := ' and (ad.asset_id,ad.asset_type_id) 
                                    in (select anyd.asset_id,anyd.asset_type_id from t_anyassetdata anyd ) ';
            	
            end if;
    
    end if;
    if  v_asset_type_count > 0 and p_status in (1,2) then
    v_assettypefilterquery:=' and    sl.asset_type_id in  
                    (select asset_type_id from unnest($1) u(asset_type_id)) ';
    elsif v_asset_type_count > 0 and p_status in (0) then
    v_assettypefilterquery:=' and    ad.asset_type_id in  
                    (select asset_type_id from unnest($1) u(asset_type_id)) ';
    end if;
    
    if v_any_ent_count > 0 and p_status in (1,2) then
    v_anyentfilterquery:=' and    exists (select 1
                   from   labkxip.labkxip_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in  
                    (select any_entity_role_mapid from unnest($4) u(any_entity_role_mapid))
                    ) ';
        
     end if;
    
    if p_status in (1,2) then          
        execute 'select count(1)
        
        from   labkxip.labkxip_asset_list sl
        where  sl.is_active=1
        and    sl.is_deleted=0 
        and    sl.is_published=case when '||p_status ||' = 1 then 1
                                    when '||p_status ||' = 2 then 0
                                    else -1
                                        end 
        and    sl.is_trashed=case when '||p_status ||' = 1 then 0
                                    when '||p_status ||' = 2 then 1
                                    else -1
                                        end                                 
        and    sl.published_date<= case when '||p_status ||' = 1 then '''||v_sysdate||'''
                                        else sl.published_date 
                                        end 
        and    sl.asset_type_id in (1,2,4,5,6)  
        '||v_assettypefilterquery||'
        and    exists (select 1
                       from   labkxip.labkxip_asset_entity_map eam
                       where  eam.asset_id= sl.asset_id
                       and    eam.asset_type_id = sl.asset_type_id 
                       and    eam.entity_role_map_id in (select entity_role_mapid
                   from unnest($2) u(entity_role_mapid))
                            group by eam.asset_id,eam.asset_type_id
                            having count(1)='||v_ent_count ||')
         '||v_anyentfilterquery||'
                       '
         ||v_entitysearchquery||      ' ' 
          ||v_assetcreatedbyquery|| 
                       '
        
        '
        into   v_assetcount
        using  p_asset_type_id,p_entityrole_mapid ,	p_any_entityrole_mapid ,p_any_entityrole_mapid,p_authorid ;
        
       execute '
       select array(select row_to_json(row) as jsonrow  
       from   (select * from (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                              short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                              image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                              published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                              sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                              image_file_name, image_path
                 , rank()over (order by sl.updated_date desc) as rno,u.user_name,emp.entity_name primary_entity_name,
                 ems.entity_name secondary_entity_name
                from labkxip.labkxip_asset_list sl
                              left join labkxip.labkxip_user u
                              on u.user_id = sl.author_id
                              /*join labkxip.labkxip_entity_role_map erm
                              on erm.entity_role_map_id = primary_entity_role_map_id
                              join labkxip.labkxip_entity_master em
                              on em.entity_master_id = erm.entity_master_id*/
                              join   labkxip.labkxip_entity_role_map ermp
                              on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                              join   labkxip.labkxip_entity_role_map erms
                              on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                              join   labkxip.labkxip_entity_master emp
                              on     emp.entity_master_id = ermp.entity_master_id
                              join   labkxip.labkxip_entity_master ems
                              on     ems.entity_master_id = erms.entity_master_id
                 where sl.is_active=1
                and sl.is_deleted=0 
                  and    sl.is_published=case when '||p_status ||' = 1 then 1
                                    when '||p_status ||' = 2 then 0
                                    else -1
                                        end
                  and    sl.is_trashed=case when '||p_status ||' = 1 then 0
                                    when '||p_status ||' = 2 then 1
                                    else -1
                                        end                         
                  and    sl.published_date<= case when '||p_status ||' = 1 then '''||v_sysdate||'''
                                                  else sl.published_date 
                                                  end 
                  and    sl.asset_type_id in (1,2,4,5,6)
                  '||v_assettypefilterquery||'  
                  and exists (select 1 from   labkxip.labkxip_asset_entity_map eam
                      where eam.asset_id= sl.asset_id
                      and eam.asset_type_id = sl.asset_type_id 
                        and eam.entity_role_map_id in (select  entity_role_mapid
                        from    unnest($2) u(entity_role_mapid) )
                         group by eam.asset_id,eam.asset_type_id
                                    having count(1)='||v_ent_count ||'           
                                    )
               '||v_anyentfilterquery||'
                       '
                       ||v_entitysearchquery||  ' '
                       ||v_assetcreatedbyquery||
                       '
                 )  as tab1
            where rno between '||v_fromrownumber||' and '||v_torownumber||') row) 
            '
            into v_assetjsonarr  
            using p_asset_type_id,p_entityrole_mapid,p_any_entityrole_mapid,p_any_entityrole_mapid,p_authorid
      ;
     elsif p_status = 0 then
        execute 'select count(1) 
                from   labkxip.labkxip_asset_draft as ad
                where  1 = 1
                
                and (ad.version_number,ad.asset_id,ad.asset_type_id) 
                                          in (select max(ad1.version_number),ad1.asset_id,ad1.asset_type_id
                                         from   labkxip.labkxip_asset_draft as ad1
                                         where  ad1.asset_id = ad.asset_id
                                         and    ad1.asset_type_id = ad.asset_type_id
                                         group by ad1.asset_id,ad1.asset_type_id)
                
                and ((exists (select 1
                              from   labkxip.labkxip_asset_list a
                              where  a.asset_id = ad.asset_id
                              and    a.asset_type_id=ad.asset_type_id
                              and    a.is_published = 0
                              and    a.is_trashed = 0))
                     or (ad.version_number > (select max(published_version_number)
                                              from   labkxip.labkxip_asset_list ai
                                              where  ai.asset_id = ad.asset_id
                                          and    ai.asset_type_id=ad.asset_type_id)))
                     ' || v_assetfilterquery || '   
                     '||v_anyentfilterquery||'
                     '||v_assettypefilterquery||'
                     '||v_draftcreatedbyquery||'
                     
                                          '
              into   v_assetcount
              using p_asset_type_id,p_authorid;
        execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select * from (select     row_number() over(order by ad.created_date desc) as rno, 
                                ad.asset_id, ad.asset_type_id,
                                asset_data->''data''->>''title'' asset_title,asset_data->''data''->>''guid''  as guid,
                                asset_data->''data''->>''status'' status, ad.created_date,
                                ad.updated_date modified_date 
                                , ad.version_number,ad.created_by created_by,
                                labkxip.labkxip_get_user_name ( ad.created_by )   created_by_name,
                                asset_data->''data''->>''duration'' duration , 
                                asset_data->''data''->>''slug_url'' title_alias, 
                                labkxip.labkxip_get_entity_name_by_asset (   ad.asset_type_id ,   ad.asset_id ,
                                                    ad.version_number   )  entity_name	
                           	   from       labkxip.labkxip_asset_draft as ad  
                                where asset_type_id in (1,2,4,5,6) 
                                and (ad.version_number,ad.asset_id,ad.asset_type_id) 
                                          in (select max(ad1.version_number),ad1.asset_id,ad1.asset_type_id
                                         from   labkxip.labkxip_asset_draft as ad1
                                         where  ad1.asset_id = ad.asset_id
                                         and    ad1.asset_type_id = ad.asset_type_id
                                         group by ad1.asset_id,ad1.asset_type_id)
                
                                and ((exists (select 1
                                              from   labkxip.labkxip_asset_list a
                                              where  a.asset_id = ad.asset_id
                                              and    a.asset_type_id=ad.asset_type_id
                                              and    a.is_published = 0
                                              and    a.is_trashed = 0))
                                     or (ad.version_number > (select max(published_version_number)
                                                              from   labkxip.labkxip_asset_list ai
                                                              where  ai.asset_id = ad.asset_id
                                                          and    ai.asset_type_id=ad.asset_type_id)))
                                     ' || v_assetfilterquery || '   
                                     '||v_anyentfilterquery||'
                                     '||v_assettypefilterquery||'
                                     '||v_draftcreatedbyquery||'
                                     
                 )  as tab1
                      		where rno between '||v_fromrownumber||' and '||v_torownumber||'   ) row
                		 )
                     
                     '
                     into v_assetjsonarr  
                     using p_asset_type_id,p_authorid;
     end if;
     raise notice '%',v_assetjson;
     if v_assetjsonarr is not null then
        foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
     end if;
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
     
  drop table t_allassetdata;
  drop table t_anyassetdata;   
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

 $_$;


--
