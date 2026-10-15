-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_page_data_r_20171025(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: isl_get_page_data_r_20171025(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_page_data_r_20171025(p_url character varying, p_page_cur refcursor, p_page_ent_cur refcursor, p_tempt_cur refcursor, p_tc_cur refcursor, p_tc_ent_cur refcursor, p_mast_tempt_cur refcursor, p_mast_tc_cur refcursor, p_mast_tc_ent_cur refcursor, p_redirect_cur refcursor) RETURNS SETOF refcursor
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
	v_lang_canonical_url varchar(4000);
	v_lang_canonical_url_actual  varchar(4000);
    v_lang_check varchar(2000);
	v_lang_canonical_url_1 varchar(4000) := '';
    v_lang_check_1 varchar(2000);
    v_lang_entity_role_map_id numeric;
    v_page_asset_typeid numeric;
	v_page_entity_role_id numeric;
    v_source_object_id varchar(10);
    v_page_entity_role_map_id numeric;
	v_lang_entity_name varchar(100);
    
BEGIN
	
    v_url := p_url;
    
	select page_id into v_page_id from isl.isl_page where alias = v_url;
	
       
    
    IF  v_page_id IS NULL THEN
    	
		select page_id into v_page_id from isl.isl_page where  v_url ~ concat('^', alias, '$') and alias <> '';
        
    END IF;
    
          
    select * into v_count from upp.REGEXP_COUNT(p_url, '/');
	
	v_org_count := v_count;
    
    
    IF v_page_id IS NULL THEN
    	
        v_asset_alias := split_part(p_url, '/', (v_count + 1));
        
        SELECT ASSET_ID, ASSET_TYPE_ID, published_version_number
        INTO   v_asset_id, v_asset_type_id, v_published_version_number
		FROM   isl.isl_asset_list a
        where  lower(title_alias) = v_asset_alias
        and    asset_type_id <> 14
		and    is_published = 1;
		
        if p_url like 'clubs/%' then
        	v_asset_type_id := 24;
        end if;
        
	END IF;
    
    IF v_page_id IS NULL THEN
    	
        v_is_detail := 1;
        
		SELECT SUBSTRING(p_url FROM '^.{'||char_length(p_url) - char_length(split_part(p_url, '/', (v_count + 1))||'/')||'}') into v_url;
        
        select * into v_count from upp.REGEXP_COUNT(v_url, '/');
        
        v_count := v_count + 1;
        
        v_loop_count := v_count;
        
        FOR I IN 1..v_count
        LOOP
        	
            select page_id into v_par_page_id from isl.isl_page where alias = v_url;            
            
            select rtrim(v_url, split_part(v_url, '/', v_loop_count)||'/') into v_url;
            
            -- raise notice 'page_id %',  v_par_page_id;
            
         
            
            if v_par_page_id is not null then
            	
                SELECT PAGE_ID
                INTO   v_page_id
                FROM   isl.isl_PAGE
                WHERE  PARENT_ID = v_par_page_id
                AND    ASSET_TYPE_ID = v_asset_type_id;
                
                raise notice 'page_id 1 %',  v_page_id;
                select 1 / 0 ;
                exit;
                
			end if;         
            
            v_loop_count := v_loop_count - 1;
            
		END LOOP;
        
	END IF;
	
    IF v_page_id IS NULL AND v_asset_id IS NOT NULL THEN
    	
        select page_id into v_par_page_id from isl.isl_page where alias = '';
        
        SELECT PAGE_ID INTO v_page_id FROM isl.isl_PAGE WHERE PARENT_ID = v_par_page_id AND ASSET_TYPE_ID = v_asset_type_id;
                      
	ELSIF v_page_id IS NULL AND v_asset_id IS  NULL THEN
    	
        SELECT isl.isl_get_new_url(v_asset_alias) INTO v_new_asset_alias;
        
        SELECT ASSET_ID,ASSET_TYPE_ID, published_version_number
        INTO   v_asset_id, v_asset_type_id, v_published_version_number
        FROM   isl.isl_asset_list a
        where  title_alias = v_new_asset_alias
        and    is_published = 1;
        
	END IF;
	
    IF v_asset_id IS NOT NULL AND v_asset_type_id IS NOT NULL THEN
    	
        SELECT isl.isl_check_asset_ent_by_cat('Content Filters', v_asset_id, v_asset_type_id) into v_content_filter_exists;
        
        if v_content_filter_exists = 1 then
        	v_show_ads := 0;
		else
        	v_show_ads := 1;
		end if;
        
        select replace(p_url, '/'||split_part(p_url, '/', (v_org_count + 1)), '') into v_old_entity_path;
        
        select '/'||split_part(p_url, '/', 1) into v_lang_check;
		
        select canonical_url
        into   v_lang_canonical_url
        from   isl.isl_entity_master
        where  entity_master_id in(select entity_master_id
                                   from   isl.isl_entity_role_map
                                   where  entity_role_id = (select entity_role_id
                                                            from   isl.isl_entity_category
                                                            where  category_name = 'Language'))
		and canonical_url = v_lang_check;
        
        if v_lang_canonical_url is not null then
        	
            select replace(v_old_entity_path, split_part(v_old_entity_path, '/', 1)||'/', '') into v_old_entity_path;
            
		end if;
		
        select canonical_url
        into  v_lang_canonical_url_actual
        from   isl.isl_entity_master
        where  entity_master_id in(select entity_master_id
                                   from   isl.isl_entity_role_map erm
                                   join   isl.isl_asset_entity_map aem
                                   on     aem.entity_role_map_id = erm.entity_role_map_id
                                   and    aem.asset_id = v_asset_id
                                   and    aem.asset_type_id = v_asset_type_id
                                   where  entity_role_id = (select entity_role_id
                                                            from   isl.isl_entity_category
                                                            where  category_name = 'Language'));
		
        select asset_type_id into v_page_asset_typeid from isl.isl_page where page_id = v_page_id;
        
        if v_page_asset_typeid = 24 then
        	
            select substring(p_url, 1, position('profile' in p_url) + 6)||'/'||replace(lower(em.entity_name), ' ' , '-')
            into   v_new_entity_path
            from   isl.isl_asset_list al
            join   isl.isl_entity_role_map erm
            on     erm.entity_role_map_id = secondary_entity_role_map_id
            join   isl.isl_entity_master em
            on     em.entity_master_id = erm.entity_master_id
            where  title_alias = coalesce(v_new_asset_alias, v_asset_alias);
            
        else
        	
            if (select 1 from isl.isl_asset_list where title_alias = coalesce(v_new_asset_alias, v_asset_alias) and primary_entity_role_map_id = 684) then
				
                select replace(lower(em.entity_name), ' ' , '-')
        		into   v_new_entity_path
        		from   isl.isl_asset_list al
        		join   isl.isl_entity_role_map erm
        		on     erm.entity_role_map_id = secondary_entity_role_map_id
        		join   isl.isl_entity_master em
        		on     em.entity_master_id = erm.entity_master_id
        		join   isl.isl_entity_role_map erm1
        		on     erm1.entity_role_map_id = primary_entity_role_map_id
        		join   isl.isl_entity_master em1
        		on     em1.entity_master_id = erm1.entity_master_id
        		where  title_alias = coalesce(v_new_asset_alias, v_asset_alias);
                
			else
            	
                select replace(lower(em1.entity_name), ' ' , '-')||'/'||replace(lower(em.entity_name), ' ' , '-')
        		into   v_new_entity_path
        		from   isl.isl_asset_list al
        		join   isl.isl_entity_role_map erm
        		on     erm.entity_role_map_id = secondary_entity_role_map_id
        		join   isl.isl_entity_master em
        		on     em.entity_master_id = erm.entity_master_id
        		join   isl.isl_entity_role_map erm1
        		on     erm1.entity_role_map_id = primary_entity_role_map_id
        		join   isl.isl_entity_master em1
        		on     em1.entity_master_id = erm1.entity_master_id
        		where  title_alias = coalesce(v_new_asset_alias, v_asset_alias);
                
            end if;
            
        end if;
        
		
        
        if ((v_old_entity_path <> v_new_entity_path) or (coalesce(v_lang_canonical_url_actual, ' ') <> coalesce(v_lang_canonical_url, ' '))) then
        	
            v_lang_canonical_url := v_lang_canonical_url_actual;
            v_is_redirect := 1;
            
		end if;
        
	END IF;
    
    select t.parent_id into v_template_id from isl.isl_template t where page_id = v_page_id;
    
    select l.master_template_id
    into   v_mast_template_id
    from   isl.isl_template t
    join   isl.isl_layout l
    on     t.layout_id = l.layout_id
    where  template_id = v_template_id;
    
    select '/'||split_part(p_url, '/', 1) into v_lang_check_1;
	
    select canonical_url
    into  v_lang_canonical_url_1
    from   isl.isl_entity_master
    where  entity_master_id in(select entity_master_id
                               from   isl.isl_entity_role_map
                               where  entity_role_id = (select entity_role_id
                                                        from   isl.isl_entity_category
                                                        where  category_name = 'Language'))
	and canonical_url = v_lang_check_1;
    
	if v_lang_canonical_url_1 is not null then
		
        select replace(v_old_entity_path, split_part(v_old_entity_path, '/', 1)||'/', '-') into v_old_entity_path;
		
        select erm.entity_role_map_id, em.entity_name
        into   v_lang_entity_role_map_id, v_lang_entity_name
        from   isl.isl_entity_master em
        join   isl.isl_entity_role_map erm
        on     erm.entity_master_id = em.entity_master_id
        join   isl.isl_entity_category ec
        on     ec.entity_role_id = erm.entity_role_id
        and    ec.category_name = 'Language'
        and    canonical_url = v_lang_canonical_url_1;
        
	else
    	
        select erm.entity_role_map_id, em.entity_name
        into   v_lang_entity_role_map_id, v_lang_entity_name
        from   isl.isl_entity_master em
        join   isl.isl_entity_role_map erm
        on     erm.entity_master_id = em.entity_master_id
        join   isl.isl_entity_category ec
        on     ec.entity_role_id = erm.entity_role_id
        and    ec.category_name = 'Language'
        and    canonical_url is null;
		
	end if;
    
    OPEN p_page_cur FOR
    select v_is_detail is_detail, p.*, sd.meta_info, v_page_entity_role_map_id asset_entity_role_map_id, v_lang_entity_role_map_id lang_erm_id,
    		parent_id, v_lang_entity_name lang_name
	from   isl.isl_page p
    left join isl.isl_seo_data sd
    on     sd.asset_id = p.page_id
    and    sd.asset_type_id = v_page_asset_type_id
    where  page_id = v_page_id;
    
    OPEN p_page_ent_cur FOR
    select a.*
    from   isl.isl_asset_entity_map a
    where  asset_id = v_page_id
    and    asset_type_id = v_page_asset_type_id
    and    is_published = 1
    and    is_active = 1
    and    is_deleted = 0;
    
    OPEN p_tempt_cur FOR
    select t.* from isl.isl_template t where template_id = v_template_id;
    
    OPEN p_tc_cur FOR
    select tc.* from isl.isl_template_component_map tc where template_id = v_template_id and is_deleted = 0 and is_active = 1 
    order by tc.template_component_map_id;
    
    OPEN p_tc_ent_cur FOR
    select a.*
    from   isl.isl_asset_entity_map a
    where  asset_id in(select tc.template_component_map_id
                       from   isl.isl_template_component_map tc
                       where  template_id = v_template_id
                       and    tc.is_deleted = 0
                       and    tc.is_active = 1)
	and    asset_type_id = v_tc_asset_type_id
    and    is_published = 1
    and    is_active = 1
    and    is_deleted = 0;
    
	OPEN p_mast_tempt_cur FOR
    select t.* from isl.isl_template t where template_id = v_mast_template_id;
    
    OPEN p_mast_tc_cur FOR
    select tc.* from isl.isl_template_component_map tc where template_id = v_mast_template_id and is_deleted = 0 and is_active = 1 
    order by tc.template_component_map_id;
    
	OPEN p_mast_tc_ent_cur FOR
    select a.*
    from   isl.isl_asset_entity_map a
    where  asset_id in(select tc.template_component_map_id
                       from   isl.isl_template_component_map tc
                       where  template_id = v_mast_template_id
                       and    tc.is_deleted = 0
                       and    tc.is_active = 1)
	and    asset_type_id = v_tc_asset_type_id
    and    is_published = 1
    and    is_active = 1
    and    is_deleted = 0;
	
	v_split := '/';
    
	select isl.REGEXP_COUNT(p_url, v_split) into v_slashcount;
	
    select split_part(p_url::text, v_split::text, (v_slashcount+1)::int) into v_texttobereplaced;
    
    v_new_asset_alias := replace(p_url, v_texttobereplaced, v_new_asset_alias);
    
    OPEN p_redirect_cur FOR
    SELECT case when (v_is_redirect = 1 and v_new_asset_alias is null) then v_asset_alias else v_new_asset_alias end AS new_asset_alias,
    		case when v_new_asset_alias is not null then 1 when v_is_redirect = 1 then 1 else 0 end as is_redirect, v_show_ads as show_ads,
            case when v_is_redirect = 1 then 
            	case when(v_lang_canonical_url is null) then v_new_entity_path else replace(v_lang_canonical_url, '/', '')||'/'||v_new_entity_path end
			else null end as new_ent_path;
	               
END;

$_$;


--
