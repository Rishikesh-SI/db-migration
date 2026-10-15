-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_page_data_rtest(character varying, text, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labyho_get_page_data_rtest(character varying, text, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_page_data_rtest(p_url character varying, p_is_mob text, p_page_cur refcursor, p_page_ent_cur refcursor, p_tempt_cur refcursor, p_tc_cur refcursor, p_tc_ent_cur refcursor, p_mast_tempt_cur refcursor, p_mast_tc_cur refcursor, p_mast_tc_ent_cur refcursor, p_redirect_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

DECLARE
	
    v_page_id numeric;
    v_page_asset_type_id numeric:=11;
    v_tc_asset_type_id numeric:=13;
    v_template_id numeric;
    v_mast_template_id numeric;
    v_count int;
    v_loop_count int;
    v_url VARCHAR(10000);
    v_is_detail numeric:=0;
    v_asset_alias varchar(10000);
    v_asset_id numeric;
    v_asset_type_id numeric;
    v_published_version_number numeric;
    -- variables for details
    v_par_page_id numeric;
    v_new_asset_alias varchar(10000);
    v_content_filter_exists numeric;
	-- Declare a cursor variable
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
    v_length numeric;
	
	v_id numeric;
    v_type_name text;
	v_temp_id numeric;
BEGIN
	
    v_url := p_url;
    
	select page_id into v_page_id 
	from labyho.labyho_page 
	where alias = v_url
  and is_deleted=0
  and is_amp=0
  ;
	
     IF  v_page_id IS NULL THEN
              select page_id 
                into v_page_id 
              from labyho.labyho_page where  v_url   ~ concat('^',alias,'$')
              and alias<>'';
           END IF;
           
    select * into v_count from labyho.REGEXP_COUNT(p_url, '/');
	
	v_org_count := v_count;
	raise notice 'v_page_id0 % ' ,  v_page_id;
    IF v_page_id IS NULL THEN
    	
         raise notice 'v_page_id1 % ' ,  v_page_id;
         
        v_asset_alias := lower(split_part(p_url, '/', (v_count+1)));
        
        SELECT ASSET_ID, ASSET_TYPE_ID, published_version_number
        INTO   v_asset_id, v_asset_type_id, v_published_version_number
		FROM   labyho.labyho_asset_list a
        where  lower(title_alias) = v_asset_alias
        and    asset_type_id not in (14)
		and    is_published = 1;
       
	END IF;
           
           /*IF v_asset_id IS NULL and v_page_id IS NULL THEN
              select page_id 
                into v_page_id 
              from labyho.labyho_page where  v_url   ~ concat('^',alias,'$')
              and alias<>'';
           END IF;*/
           
		  
		   
           IF v_page_id IS NULL THEN
              
              v_is_detail:=1;
              RAISE NOTICE 't1 %',v_length;
         --     v_asset_alias :=   split_part(p_url, '/', (v_count+1))  ;
              
--              SELECT ASSET_ID,ASSET_TYPE_ID ,published_version_number
--              INTO v_asset_id,v_asset_type_id,v_published_version_number
--              
--              FROM labyho.labyho_asset_list a
--              where lower(title_alias)=v_asset_alias;
            
              
              /*select lower(rtrim(p_url,
                           split_part(p_url, '/', (v_count+1)) || '/'
                           )) into v_url; */
                     
                     select char_length(p_url)-char_length(split_part(p_url, '/', (v_count+1)) || '/') 
                     into v_length;
                     
		/*SELECT SUBSTRING(p_url
                 FROM '^.{'||char_length(p_url)-
                 char_length(split_part(p_url, '/', (v_count+1)) || '/')||'}')into v_url;*/
                 
                 RAISE NOTICE 't1 %',v_length;
                 
                 select SUBSTRING(p_url from '^.{'||v_length||'}') into v_url; 
                 -- select substring(p_url,v_length) into v_url;                                 
                 
             if v_url is not null
                 then 
              select * into v_count from labyho.REGEXP_COUNT(v_url, '/');
              end if;
               v_count:=v_count+1;
               
               v_loop_count:=v_count;
               -- v_url:= p_url;
               
              --  RAISE NOTICE 't2  %',v_count;
             --  if v_count >0 then 
               FOR I IN 1..v_count
               LOOP
               
                --   RAISE NOTICE 'text: 1 %',v_url;
                             
                   select page_id into v_par_page_id from labyho.labyho_page
                     where alias=v_url
                     and is_deleted=0
					and is_amp=0;
                     
                   /*select rtrim(v_url,
                                 split_part(v_url, '/', v_loop_count) || '/'
                                 ) into v_url; */
					
                 SELECT SUBSTRING(v_url
                 FROM '^.{'||char_length(v_url)-
                 char_length(split_part(v_url, '/', (v_loop_count)) || '/')||'}')into v_url;
                    
                   RAISE NOTICE '%',v_url;
                   RAISE NOTICE '%',v_page_id;
                 --  if v_page_id is not null and v_loop_count<v_count then
                      
              --     end if;
                   
                   if v_par_page_id is not null then
                      
                      SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   labyho.labyho_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id
                      and is_active = 1 
                      and is_deleted = 0
					   and is_amp=0 ;
                      
                      exit;
                   end if;           
                   v_loop_count:=v_loop_count-1;
               
               END LOOP;
              -- end if ;
           END IF;
           
           IF v_page_id IS NULL AND v_asset_id IS NOT NULL THEN
           	raise notice 't3 : % ' ,v_asset_type_id;
              select page_id into v_par_page_id from labyho.labyho_page
                     where alias='' and is_deleted=0;
                     
              SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   labyho.labyho_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=(case v_asset_type_id when 5 then 1 else v_asset_type_id end)
                      and  is_active = 1 
      					and is_deleted = 0
						and is_amp=0;
                      
					-- raise notice '% check % test ',v_par_page_id ,v_page_id;
					 -- select 1/0;
					  
					  
           ELSIF  v_page_id IS NULL AND v_asset_id IS  NULL THEN
                SELECT labyho.labyho_get_new_url(v_asset_alias) INTO v_new_asset_alias;
                
                SELECT ASSET_ID,ASSET_TYPE_ID ,published_version_number
                INTO v_asset_id,v_asset_type_id,v_published_version_number
                
                FROM labyho.labyho_asset_list a
                where title_alias=v_new_asset_alias
                and is_published=1;
                
           END IF;
           
           IF v_asset_id IS NOT NULL AND v_asset_type_id IS NOT NULL THEN
            SELECT labyho.labyho_check_asset_ent_by_cat('Content Filters',v_asset_id,v_asset_type_id)
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
            
             
             select canonical_url
              into  v_lang_canonical_url
              from   labyho.labyho_entity_master
              where  entity_master_id in(select entity_master_id
                                           from   labyho.labyho_entity_role_map
                                           where  entity_role_id = (select entity_role_id
                                                                    from   labyho.labyho_entity_category
                                                                    where  category_name = 'Language'))
              and canonical_url=v_lang_check;
             
             if v_lang_canonical_url is not null then
             
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
              	
             end if;
             
             select canonical_url
             into  v_lang_canonical_url_actual
             from   labyho.labyho_entity_master
             where  entity_master_id in(select entity_master_id
                                        from   labyho.labyho_entity_role_map erm
                                        join   labyho.labyho_asset_entity_map aem
                                        on     aem.entity_role_map_id = erm.entity_role_map_id
                                        and    aem.asset_id = v_asset_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        where  entity_role_id = (select entity_role_id
                                                                 from   labyho.labyho_entity_category
                                                                 where  category_name = 'Language'));
             
             select  replace(lower(em.entity_name),' ','')
           -- replace(lower(em1.entity_name||'/'||em.entity_name),' ','-')  -- ppp added 
             into   v_new_entity_path
             from   labyho.labyho_asset_list al
             join   labyho.labyho_entity_role_map erm
             on     erm.entity_role_map_id = secondary_entity_role_map_id
             join   labyho.labyho_entity_master em
             on     em.entity_master_id = erm.entity_master_id
             join   labyho.labyho_entity_role_map erm1
             on     erm1.entity_role_map_id = primary_entity_role_map_id
             join   labyho.labyho_entity_master em1
             on     em1.entity_master_id = erm1.entity_master_id
             where  lower(title_alias) = coalesce(v_new_asset_alias, v_asset_alias);
             
            if ((v_old_entity_path <> v_new_entity_path)
                or (coalesce(v_lang_canonical_url_actual,' ') 
                    <> coalesce(v_lang_canonical_url,' ') )) then
            	
            	v_lang_canonical_url = v_lang_canonical_url_actual;
                
                
            	v_is_redirect := 1;
            end if;
            
              
           END IF;
           
           -- =============================
           select '/'||split_part(lower(p_url), '/', (1))
             into v_lang_check_1;
                          
 -- raise no--tice '%1222',v_lang_check_1;
                --  select 1/0;
             
             select canonical_url
              into  v_lang_canonical_url_1
              from   labyho.labyho_entity_master
              where  entity_master_id in(select entity_master_id
                                           from   labyho.labyho_entity_role_map
                                           where  entity_role_id = (select entity_role_id
                                                                    from   labyho.labyho_entity_category
                                                                    where  category_name = 'Language'))
              and canonical_url=v_lang_check_1;
             
             if v_lang_canonical_url_1 is not null then
             
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
             	
                
               -- raise notice '% 1212',v_lang_canonical_url_1;
               --   select 1/0 ;
             	select erm.entity_role_map_id, em.canonical_url
              	into  v_lang_entity_role_map_id
              	from   labyho.labyho_entity_master em
              	join   labyho.labyho_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
              	join  labyho.labyho_entity_category ec
              	on ec.entity_role_id = erm.entity_role_id
              	and  ec.category_name = 'Language'
              	and canonical_url=v_lang_canonical_url_1;
              	
             else
             	
                select erm.entity_role_map_id 
              	into  v_lang_entity_role_map_id
              	from   labyho.labyho_entity_master em
              	join   labyho.labyho_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
              	join  labyho.labyho_entity_category ec
              	on ec.entity_role_id = erm.entity_role_id
              	and  ec.category_name = 'Language'
              	and canonical_url is null;
             	
             end if;
           -- =============================
           
           ---raise notice '% test11',v_page_id;
           -- raise notice '% test12 ',v_template_id;
          -- select 1/0;
           
           select t.parent_id into v_template_id
           from labyho.labyho_template t where page_id=v_page_id;
           
		  
         
		  select   SUBSTRING(p_url,'[a-z0-9-]+-(\d+)$')
		  into v_id ;
		  
		  
		   if v_id is not null then 	  
				   select c.entity_type_name into v_type_name
				   from labyho.labyho_entity_role_map a
				   join labyho.labyho_entity_role  b on a.entity_role_id=b.entity_type_id
				   join labyho.labyho_entity_type c on b.entity_type_id=c.entity_type_id
				   join labyho.labyho_entity_master d on d.entity_master_id=a.entity_master_id
				   where b.entity_role_id=8
				   and canonical_url='/'||p_url
				   and tour_id=v_id::text; 

		   
		
		     if v_type_name='BilateralSeries' then 
		    
		     select template_id into v_temp_id 
			 from labyho.labyho_template
			 where template_name='BilateralSeries';
			   
			--   raise notice '%',v_temp_id ;
		   --select 1/0;
			 
		     end if;
		   end if;
		   
		   v_template_id:=coalesce (v_temp_id,v_template_id);
		 
		 
		 
		 /* select l.master_template_id
           into v_mast_template_id
           from labyho.labyho_template t 
           join labyho.labyho_layout l
           on t.layout_id=l.layout_id
           where template_id=v_template_id;
           */
           
           select  t.layout_id
           into v_mast_template_id
           from labyho.labyho_template t 
           -- join labyho.labyho_template tl
           -- on t.template_id=tl.template_id
           where t.template_id=v_template_id;
           
           
          -- raise notice '% temp',v_template_id;
          -- raise notice '% masttemp',v_mast_template_id;
           --  select 1/0;
           
      OPEN p_page_cur FOR  
    	select v_is_detail is_detail,p.* ,sd.meta_info, v_lang_entity_role_map_id lang_erm_id,
         (select labyho.labyho_get_entity_name(v_lang_entity_role_map_id)) as lang_name,
		v_lang_canonical_url_1 lang_can_url
      from labyho.labyho_page p 
      left join labyho.labyho_seo_data  sd on sd.asset_id=p.page_id and sd.asset_type_id=v_page_asset_type_id
      where page_id=v_page_id 
      and p.is_active = 1 
      and p.is_deleted = 0 ;

      
      OPEN p_page_ent_cur FOR  
     select a.*, em.entity_name,em.canonical_url, et.entity_type_name,erm.source_object_id,erm.tour_id
	 from labyho.labyho_asset_entity_map a
	 join labyho.labyho_entity_role_map erm
	 on erm.entity_role_map_id = a.entity_role_map_id
	 join labyho.labyho_entity_master em
	 on em.entity_master_id = erm.entity_master_id
	 join labyho.labyho_entity_role er
	 on er.entity_role_id = erm.entity_role_id
	 join labyho.labyho_entity_type et
	 on et.entity_type_id = er.entity_type_id
	 where a.asset_id =v_page_id
	 and asset_type_id=v_page_asset_type_id
	 and is_published=1 and a.is_active=1 and a.is_deleted=0;
	  
	  
	  
	  
      
      OPEN p_tempt_cur FOR  
      select t.template_id,(case when p_is_mob::numeric=1 then coalesce(t.mobile_html,t.template_html)
	  							when p_is_mob::numeric=0 then t.template_html
								else null end ) as template_html  from labyho.labyho_template t 
      where template_id=v_template_id
      and is_active = 1 
      and is_deleted = 0;   
      
	  begin 
      OPEN p_tc_cur FOR  
      /*select tc.* from labyho.labyho_template_component_map tc where template_id=v_template_id
      and is_deleted=0 and is_active=1
      order by tc.template_component_map_id;  */
	  
	  with test as (
 select *
	  from labyho.labyho_template_component_map tc
	  where template_id=v_template_id
      and is_deleted=0 
	  and is_active=1
      order by tc.template_component_map_id	  
)
select 	coalesce((case when b.show_in_mobile=1 then b.parent_container_id else 
		b.template_component_map_id end )::numeric,b.template_component_map_id) as 
        template_component_map_id ,
		b.template_id,b.component_id,b.title,b.display_title,b.title_mobile,b.title_app,b.show_in_mobile,b.show_in_app,b.show_in_web,b.fetch_from,
		b.created_date,b.updated_date,b.created_by,b.updated_by,b.is_active,
		b.is_deleted,b.is_published,b.tcmap_guid,
		b.parent_container_id,b.parent_tcmap_id,b.meta_info
		
from test b
left join (select * from labyho.labyho_template_component_map where parent_container_id !=null)a 
on a.parent_container_id=b.template_component_map_id;
    exception when others then 
	 OPEN p_tc_cur FOR   select tc.* from labyho.labyho_template_component_map tc where template_id=v_template_id
      and is_deleted=0 and is_active=1
      order by tc.template_component_map_id;
	end ;
	
	
      OPEN p_tc_ent_cur FOR  
     /* select a.* from labyho.labyho_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from labyho.labyho_template_component_map tc 
                  where template_id=v_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id
	  and is_published=1 and is_active=1 and is_deleted=0;
      */
	   select a.*, em.entity_name,em.canonical_url, et.entity_type_name,erm.source_object_id,erm.tour_id
	 from labyho.labyho_asset_entity_map a
	 join labyho.labyho_entity_role_map erm
	 on erm.entity_role_map_id = a.entity_role_map_id
	 join labyho.labyho_entity_master em
	 on em.entity_master_id = erm.entity_master_id
	 join labyho.labyho_entity_role er
	 on er.entity_role_id = erm.entity_role_id
	 join labyho.labyho_entity_type et
	 on et.entity_type_id = er.entity_type_id
	 where asset_id in (select tc.template_component_map_id from labyho.labyho_template_component_map tc 
                  where template_id=v_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id
	  and is_published=1 and a.is_active=1 and a.is_deleted=0;
	  
	  
      OPEN p_mast_tempt_cur FOR  
      select t.template_id,(case when p_is_mob::numeric=1 then coalesce(t.mobile_html,t.template_html)
	  							when p_is_mob::numeric=0 then t.template_html
								else null end ) as template_html  from labyho.labyho_template t
      where template_id=v_mast_template_id
      and is_active = 1 
      and is_deleted = 0;   
      
      OPEN p_mast_tc_cur FOR  
      select tc.* from labyho.labyho_template_component_map tc where template_id=v_mast_template_id
      and is_deleted=0 and is_active=1
      order by tc.template_component_map_id;  
      
      OPEN p_mast_tc_ent_cur FOR  
     /* select a.* from labyho.labyho_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from labyho.labyho_template_component_map tc 
                  where template_id=v_mast_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id
	  and is_published=1 and is_active=1 and is_deleted=0;
      */
	 select a.*, em.entity_name, et.entity_type_name,erm.source_object_id
	 from labyho.labyho_asset_entity_map a
	 join labyho.labyho_entity_role_map erm
	 on erm.entity_role_map_id = a.entity_role_map_id
	 join labyho.labyho_entity_master em
	 on em.entity_master_id = erm.entity_master_id
	 join labyho.labyho_entity_role er
	 on er.entity_role_id = erm.entity_role_id
	 join labyho.labyho_entity_type et
	 on et.entity_type_id = er.entity_type_id
	 where asset_id in (select tc.template_component_map_id from labyho.labyho_template_component_map tc 
                  where template_id=v_mast_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id
	  and is_published=1 and a.is_active=1 and a.is_deleted=0;
      
      -- changes done by rakesh 230317-----
	  
	   v_split := '/';
    
	select labyho.REGEXP_COUNT(lower(p_url), v_split)
    into v_slashcount;
	
	    select split_part(lower(p_url::text),v_split::text,(v_slashcount+1)::int)
      into v_texttobereplaced;
	  
	   v_new_asset_alias := replace(lower(p_url),v_texttobereplaced,v_new_asset_alias);
	  
	  -- changes done by rakesh 230317----------
      
      
      
      /*OPEN p_redirect_cur FOR 
      SELECT v_new_asset_alias AS new_asset_alias,
      case when v_new_asset_alias is not null then 1
      	   when v_is_redirect = 1 then 1
      else 0 end as is_redirect
      , v_show_ads as show_ads, case when v_new_entity_path<>v_old_entity_path then v_new_entity_path else null end  as new_ent_path;*/
      /*OPEN p_redirect_cur FOR 
      SELECT v_new_asset_alias AS new_asset_alias,
      		 case when v_new_asset_alias is not null then 1
      	   	 	  when v_is_redirect = 1 then 1
      		 	  else 0
			 end as is_redirect,
             v_show_ads as show_ads,
             case when v_new_entity_path <> v_old_entity_path then
             	  	case v_lang_canonical_url when null then v_new_entity_path else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path end 
             	  else null
			 end as new_ent_path;*/
      
      OPEN p_redirect_cur FOR 
      SELECT  case when (v_is_redirect = 1 and v_new_asset_alias is null) then v_asset_alias else v_new_asset_alias end AS new_asset_alias,
      		 case when v_new_asset_alias is not null then 1
      	   	 	  when v_is_redirect = 1 then 1
      		 	  else 0
			 end as is_redirect,
            v_show_ads as show_ads,
            
             case when v_is_redirect = 1 then
             	  	
                 case when(v_lang_canonical_url is null) then v_new_entity_path
                 else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path
                 end
             	  else null
			 end as new_ent_path
             ;
                                                          
    END;
    

$_$;


--
