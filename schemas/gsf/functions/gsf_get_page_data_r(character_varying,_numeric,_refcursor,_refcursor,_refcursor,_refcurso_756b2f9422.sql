-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_get_page_data_r(character varying, numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gsf_get_page_data_r(character varying, numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: gsf; Owner: -
--

CREATE FUNCTION gsf.gsf_get_page_data_r(p_url character varying, p_is_amp numeric, p_page_cur refcursor, p_page_ent_cur refcursor, p_tempt_cur refcursor, p_tc_cur refcursor, p_tc_ent_cur refcursor, p_mast_tempt_cur refcursor, p_mast_tc_cur refcursor, p_mast_tc_ent_cur refcursor, p_redirect_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$ 

declare
	
    v_page_id numeric;
    v_page_asset_type_id numeric:=11;
    v_tc_asset_type_id numeric:=13;
    v_template_id numeric;
    v_mast_template_id numeric;
    v_count int;
    v_loop_count int;
    v_url varchar(10000);
    v_is_detail numeric:=0;
    v_asset_alias varchar(10000);
    v_asset_id numeric;
    v_asset_type_id numeric;
    v_published_version_number numeric;
    -- variables for details
    v_par_page_id numeric;
    v_new_asset_alias varchar(10000);
    v_content_filter_exists numeric;
	-- declare a cursor variable
    v_show_ads numeric:=1;
    -- changes by rakesh 230317--
    v_split char(1);
    v_slashcount numeric; 
    v_texttobereplaced varchar(4000);
    -- changes by rakesh 230317--3
    v_c_asset_alias varchar(10000);
    v_old_entity_path varchar(1000);
    v_new_entity_path varchar(1000);
    v_is_redirect numeric;
    v_org_count int;
	  v_lang_canonical_url varchar(4000) := '';
      
      v_lang_canonical_url_1 varchar(4000) := '';
      
      v_lang_canonical_url_actual  varchar(4000);
    v_lang_check varchar(2000);
    v_lang_check_1 varchar(2000);
    v_lang_entity_role_map_id numeric;
    
begin
	
    v_url := p_url;
    
	select page_id into v_page_id 
	from gsf.gsf_page 
	where alias = v_url
  and is_deleted=0
  ;
	
     if  v_page_id is null then
              select page_id 
                into v_page_id 
              from gsf.gsf_page where  v_url   ~ concat('^',alias,'$')
              and alias<>'';
           end if;
           
    select * into v_count from gsf.regexp_count(p_url, '/');
	
	v_org_count := v_count;
	
    if v_page_id is null then
    	
        v_asset_alias := split_part(p_url, '/', (v_count+1));
        
        select asset_id, asset_type_id, published_version_number
        into   v_asset_id, v_asset_type_id, v_published_version_number
		from   gsf.gsf_asset_list a
        where  lower(title_alias) = v_asset_alias
        and    asset_type_id not in (14)
		and    is_published = 1;
        
	end if;
           
           /*if v_asset_id is null and v_page_id is null then
              select page_id 
                into v_page_id 
              from gsf.gsf_page where  v_url   ~ concat('^',alias,'$')
              and alias<>'';
           end if;*/
           
           
           if v_page_id is null then
              
              v_is_detail:=1;
              
         --     v_asset_alias :=   split_part(p_url, '/', (v_count+1))  ;
              
--              select asset_id,asset_type_id ,published_version_number
--              into v_asset_id,v_asset_type_id,v_published_version_number
--              
--              from gsf.gsf_asset_list a
--              where lower(title_alias)=v_asset_alias;
            
              
              select rtrim(p_url,
                           split_part(p_url, '/', (v_count+1)) || '/'
                           ) into v_url; 
                           
		/*select substring(p_url
                 from '^.{'||char_length(p_url)-
                 char_length(split_part(p_url, '/', (1+1)) || '/')||'}')into v_url;*/
                                 
              select * into v_count from gsf.regexp_count(v_url, '/');
               v_count:=v_count+1;
               
               v_loop_count:=v_count;
               -- v_url:= p_url;
               
               for i in 1..v_count
               loop
               
                   raise notice '%',v_url;
                             
                   select page_id into v_par_page_id from gsf.gsf_page
                     where alias=v_url
                     and is_deleted=0;
                     
                   select rtrim(v_url,
                                 split_part(v_url, '/', v_loop_count) || '/'
                                 ) into v_url; 
                                 
                   raise notice '%',v_url;
                   raise notice '%',v_page_id;
                 --  if v_page_id is not null and v_loop_count<v_count then
                      
              --     end if;
                   
                   if v_par_page_id is not null then
                      
                      select page_id
                      into   v_page_id
                      from   gsf.gsf_page
                      where  parent_id=v_par_page_id
                      and    asset_type_id=v_asset_type_id
                      and is_active = 1 
                      and is_deleted = 0 
                      and    coalesce(is_amp,0) = coalesce(p_is_amp,0);
                      
                      exit;
                   end if;           
                   v_loop_count:=v_loop_count-1;
               
               end loop;
           end if;
           
           if v_page_id is null and v_asset_id is not null then
              select page_id into v_par_page_id from gsf.gsf_page
                     where alias='';
              select page_id
                      into   v_page_id
                      from   gsf.gsf_page
                      where  parent_id=v_par_page_id
                      and    asset_type_id=v_asset_type_id
                      and  is_active = 1 
      					and is_deleted = 0
                and    coalesce(is_amp,0) = coalesce(p_is_amp,0);
                      
                      
           elsif  v_page_id is null and v_asset_id is  null then
                select gsf.gsf_get_new_url(v_asset_alias) into v_new_asset_alias;
                
                select asset_id,asset_type_id ,published_version_number
                into v_asset_id,v_asset_type_id,v_published_version_number
                
                from gsf.gsf_asset_list a
                where title_alias=v_new_asset_alias
                and is_published=1;
                
           end if;
           
           if v_asset_id is not null and v_asset_type_id is not null then
            select gsf.gsf_check_asset_ent_by_cat('content filters',v_asset_id,v_asset_type_id)
            into v_content_filter_exists;
            
              if v_content_filter_exists= 1 then
                  v_show_ads:=0;
              else
                  v_show_ads:=1;
              end if;
             
             select replace(p_url, '/'||split_part(p_url, '/', (v_org_count+1)), '')
             into   v_old_entity_path;
             
             select '/'||split_part(p_url, '/', (1))
             into v_lang_check;
            
            raise notice '%1',v_lang_check;
                     --   select 1/0;
             
             select canonical_url
              into  v_lang_canonical_url
              from   gsf.gsf_entity_master
              where  entity_master_id in(select entity_master_id
                                           from   gsf.gsf_entity_role_map
                                           where  entity_role_id = (select entity_role_id
                                                                    from   gsf.gsf_entity_category
                                                                    where  category_name = 'Language'))
              and canonical_url=v_lang_check;
             
             if v_lang_canonical_url is not null then
             
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
              	
             end if;
             
             -- raise notice '% test 1',v_asset_id;
--  raise notice '% test 2',v_asset_type_id;
              -- select 1/0;
             
             select canonical_url
             into  v_lang_canonical_url_actual
             from   gsf.gsf_entity_master
             where  entity_master_id in(select entity_master_id
                                        from   gsf.gsf_entity_role_map erm
                                        join   gsf.gsf_asset_entity_map aem
                                        on     aem.entity_role_map_id = erm.entity_role_map_id
                                        and    aem.asset_id = v_asset_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        where  entity_role_id = (select entity_role_id
                                                                 from   gsf.gsf_entity_category
                                                                 where  category_name = 'Language'));
             
             select  replace(lower(em.entity_name),' ','')
             --replace(lower(em1.entity_name||'/'||em.entity_name),' ','-')  -- ppp added 
             into   v_new_entity_path
             from   gsf.gsf_asset_list al
             join   gsf.gsf_entity_role_map erm
             on     erm.entity_role_map_id = secondary_entity_role_map_id
             join   gsf.gsf_entity_master em
             on     em.entity_master_id = erm.entity_master_id
             join   gsf.gsf_entity_role_map erm1
             on     erm1.entity_role_map_id = primary_entity_role_map_id
             join   gsf.gsf_entity_master em1
             on     em1.entity_master_id = erm1.entity_master_id
             where  title_alias = coalesce(v_new_asset_alias, v_asset_alias);
             
             raise notice '% test 1',v_new_asset_alias;
              raise notice '% test 2',v_asset_alias; 
           --    select 1/0;
             
            if ((v_old_entity_path <> v_new_entity_path)
                or (coalesce(v_lang_canonical_url_actual,' ') 
                    <> coalesce(v_lang_canonical_url,' ') )) then
            	
            	v_lang_canonical_url = v_lang_canonical_url_actual;
                
                
            	v_is_redirect := 1;
            end if;
            
              
           end if;
           
           -- =============================
           select '/'||split_part(p_url, '/', (1))
             into v_lang_check_1;
                          
 -- raise no--tice '%1222',v_lang_check_1;
                --  select 1/0;
             
             select canonical_url
              into  v_lang_canonical_url_1
              from   gsf.gsf_entity_master
              where  entity_master_id in(select entity_master_id
                                           from   gsf.gsf_entity_role_map
                                           where  entity_role_id = (select entity_role_id
                                                                    from   gsf.gsf_entity_category
                                                                    where  category_name = 'Language'))
              and canonical_url=v_lang_check_1;
             
             if v_lang_canonical_url_1 is not null then
             
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
             	
                
                raise notice '% 1212',v_lang_canonical_url_1;
               --   select 1/0 ;
             	select erm.entity_role_map_id
              	into  v_lang_entity_role_map_id
              	from   gsf.gsf_entity_master em
              	join   gsf.gsf_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
              	join  gsf.gsf_entity_category ec
              	on ec.entity_role_id = erm.entity_role_id
              	and  ec.category_name = 'Language'
              	and canonical_url=v_lang_canonical_url_1;
              	
             else
             	
                select erm.entity_role_map_id
              	into  v_lang_entity_role_map_id
              	from   gsf.gsf_entity_master em
              	join   gsf.gsf_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
              	join  gsf.gsf_entity_category ec
              	on ec.entity_role_id = erm.entity_role_id
              	and  ec.category_name = 'Language'
              	and canonical_url is null;
             	
             end if;
           -- =============================
           
           raise notice '% test11',v_page_id;
            raise notice '% test12 ',v_template_id;
          -- select 1/0;
           
           select t.parent_id into v_template_id
           from gsf.gsf_template t where page_id=v_page_id;
           
          /* select l.master_template_id
           into v_mast_template_id
           from gsf.gsf_template t 
           join gsf.gsf_layout l
           on t.layout_id=l.layout_id
           where template_id=v_template_id;
           */
           
           select  t.layout_id
           into v_mast_template_id
           from gsf.gsf_template t 
           -- join gsf.gsf_template tl
           -- on t.template_id=tl.template_id
           where t.template_id=v_template_id;
           
           
           raise notice '% temp 12',v_template_id;
          --  raise notice '% masttemp',v_mast_template_id;
           -- select 1/0;
           
      open p_page_cur for  
      select v_is_detail is_detail,p.* ,sd.meta_info, v_lang_entity_role_map_id lang_erm_id,
       (select gsf.gsf_get_entity_name(v_lang_entity_role_map_id)) as lang_name
      from gsf.gsf_page p 
      left join gsf.gsf_seo_data  sd on sd.asset_id=p.page_id and sd.asset_type_id=v_page_asset_type_id
      where page_id=v_page_id 
      and p.is_active = 1 
      and p.is_deleted = 0 ;

      
      open p_page_ent_cur for  
      select a.* from gsf.gsf_asset_entity_map a 
      where asset_id=v_page_id and asset_type_id=v_page_asset_type_id 
      and is_published=1 and is_active=1 and is_deleted=0 ;   
      
      open p_tempt_cur for  
      select t.* from gsf.gsf_template t 
      where template_id=v_template_id
      and is_active = 1 
      and is_deleted = 0;   
      
      open p_tc_cur for  
      select tc.* from gsf.gsf_template_component_map tc where template_id=v_template_id
      and is_deleted=0 and is_active=1
      order by tc.template_component_map_id;  
      
      open p_tc_ent_cur for  
      select a.* from gsf.gsf_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from gsf.gsf_template_component_map tc 
                  where template_id=v_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id
	  and is_published=1 and is_active=1 and is_deleted=0;
      
      open p_mast_tempt_cur for  
      select t.* from gsf.gsf_template t
      where template_id=v_mast_template_id
      and is_active = 1 
      and is_deleted = 0;   
      
      open p_mast_tc_cur for  
      select tc.* from gsf.gsf_template_component_map tc where template_id=v_mast_template_id
      and is_deleted=0 and is_active=1
      order by tc.template_component_map_id;  
      
      open p_mast_tc_ent_cur for  
      select a.* from gsf.gsf_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from gsf.gsf_template_component_map tc 
                  where template_id=v_mast_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id
	  and is_published=1 and is_active=1 and is_deleted=0;
      
      -- changes done by rakesh 230317-----
	  
	   v_split := '/';
    
	select gsf.regexp_count(p_url, v_split)
    into v_slashcount;
	
	    select split_part(p_url::text,v_split::text,(v_slashcount+1)::int)
      into v_texttobereplaced;
	  
     --  raise notice '% alia',v_new_asset_alias;
     -- select 1/0;
      
	   v_new_asset_alias := replace(p_url,v_texttobereplaced,v_new_asset_alias);
       
       
	  
	  -- changes done by rakesh 230317----------
      
      
      
      /*open p_redirect_cur for 
      select v_new_asset_alias as new_asset_alias,
      case when v_new_asset_alias is not null then 1
      	   when v_is_redirect = 1 then 1
      else 0 end as is_redirect
      , v_show_ads as show_ads, case when v_new_entity_path<>v_old_entity_path then v_new_entity_path else null end  as new_ent_path;*/
      /*open p_redirect_cur for 
      select v_new_asset_alias as new_asset_alias,
      		 case when v_new_asset_alias is not null then 1
      	   	 	  when v_is_redirect = 1 then 1
      		 	  else 0
			 end as is_redirect,
             v_show_ads as show_ads,
             case when v_new_entity_path <> v_old_entity_path then
             	  	case v_lang_canonical_url when null then v_new_entity_path else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path end 
             	  else null
			 end as new_ent_path;*/
      
      open p_redirect_cur for 
      select  case when (v_is_redirect = 1 and v_new_asset_alias is null) then v_asset_alias else v_new_asset_alias end as new_asset_alias,
      		 case when v_new_asset_alias is not null then 1
      	   	 	  when v_is_redirect = 1 then 1
      		 	  else 0
			 end as is_redirect,
             -- ,v_is_redirect,v_old_entity_path,v_new_entity_path,v_lang_canonical_url_actual, v_lang_canonical_url, 
             v_show_ads as show_ads,
             /*case when (v_new_entity_path <> v_old_entity_path) and v_is_redirect <> 1 then
             	  	case v_lang_canonical_url when null then v_new_entity_path else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path end
                  when (v_new_entity_path <> v_old_entity_path) and v_is_redirect = 1 then 
                 case when(v_lang_canonical_url is null) then v_new_entity_path
                 else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path
                 end
                 when  v_is_redirect = 1 then 
                 case when(v_lang_canonical_url is null) then v_new_entity_path
                 else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path
                 end
             	  else null
			 end as new_ent_path*/
              case when p_is_amp=1 then 'amp'||'/'||(
            case when v_is_redirect = 1 then
             	  	
                 case when(v_lang_canonical_url is null) then v_new_entity_path
                 else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path
                 end
             	  else null
			 end )
             else 
             ( case when v_is_redirect = 1 then
             	  	
                 case when(v_lang_canonical_url is null) then v_new_entity_path
                 else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path
                 end
             	  else null
			 end)
             end
             
            as new_ent_path
             ;
      
--      if v_is_detail = 1 then 
-- 
-- 
-- 
-- 
--         open p_asset_detail_cur for
--         select * from gsf.gsf_asset_draft
--         where asset_id=v_asset_id and asset_type_id=v_asset_type_id 
--         and version_number=v_published_version_number
--         and is_deleted=0 and is_active=1;
-- 
--         open p_asset_ent_cur for
--         select * from gsf.gsf_asset_entity_map
--         where asset_id=v_asset_id and asset_type_id=v_asset_type_id
--         and is_deleted=0 and is_active=1;
-- 
--         if v_asset_type_id= 1 then
--           -- article
--           open p_asset_map_cur for
--           select * from gsf.gsf_article where article_id=v_asset_id
--           and is_deleted=0 and is_active=1;
-- 
--         elsif v_asset_type_id= 2 then
--           -- album
--           open p_asset_map_cur for
--           select * from gsf.gsf_album where album_id=v_asset_id
--           and is_deleted=0 and is_active=1;
-- 
--         elsif v_asset_type_id= 4 then
--           -- album
--           open p_asset_map_cur for
--           select * from gsf.gsf_video where video_id=v_asset_id
--           and is_deleted=0 and is_active=1;  
--         end if;
--      else
--      	open p_asset_detail_cur for
--         select 1  as cnt;
-- 
--         open p_asset_ent_cur for
--         select 1  as cnt;
-- 
-- 		 open p_asset_map_cur for
--         select 1  as cnt;
--      end if;
-- 
      
     -- return next ref;                                                       
    end;
    

 $_$;


--
