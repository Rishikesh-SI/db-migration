-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_get_page_data_r_ak_11052017(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: pbl_get_page_data_r_ak_11052017(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_get_page_data_r_ak_11052017(p_url character varying, p_page_cur refcursor, p_page_ent_cur refcursor, p_tempt_cur refcursor, p_tc_cur refcursor, p_tc_ent_cur refcursor, p_mast_tempt_cur refcursor, p_mast_tc_cur refcursor, p_mast_tc_ent_cur refcursor, p_asset_detail_cur refcursor, p_asset_ent_cur refcursor, p_asset_map_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$  

    DECLARE
      -- ref refcursor;  
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
      
      -- Declare a cursor variable
    BEGIN   
            v_url :=p_url;
            
           select page_id 
           into v_page_id from pbl.pbl_page
           where alias=v_url;
           
           select * into v_count from pbl.REGEXP_COUNT(p_url, '/');
           
           IF v_page_id IS NULL THEN
              
              v_is_detail:=1;
              
              v_asset_alias :=   split_part(p_url, '/', (v_count+1))  ;
              
              SELECT ASSET_ID,ASSET_TYPE_ID ,published_version_number
              INTO v_asset_id,v_asset_type_id,v_published_version_number
              
              FROM pbl.pbl_asset_list a
              where title_alias=v_asset_alias;
              
              
              select rtrim(p_url,
                           split_part(p_url, '/', (v_count+1)) || '/'
                           ) into v_url; 
                                 
              select * into v_count from pbl.REGEXP_COUNT(v_url, '/');
               v_count:=v_count+1;
               
               v_loop_count:=v_count;
               -- v_url:= p_url;
               
               FOR I IN 1..v_count
               LOOP
               
                   RAISE NOTICE '%',v_url;
                             
                   select page_id into v_par_page_id from pbl.pbl_page
                     where alias=v_url;
                     
                   select rtrim(v_url,
                                 split_part(v_url, '/', v_loop_count) || '/'
                                 ) into v_url; 
                                 
                   RAISE NOTICE '%',v_url;
                   RAISE NOTICE '%',v_page_id;
                 --  if v_page_id is not null and v_loop_count<v_count then
                      
              --     end if;
                   
                   if v_par_page_id is not null then
                      
                      SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   pbl.pbl_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id;
                      
                      exit;
                   end if;           
                   v_loop_count:=v_loop_count-1;
               
               END LOOP;
           END IF;
           
           IF v_page_id IS NULL THEN
              select page_id into v_par_page_id from pbl.pbl_page
                     where alias='';
              SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   pbl.pbl_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id;
                      
           END IF;
           
           
           
           
           select t.parent_id into v_template_id from pbl.pbl_template t where page_id=v_page_id;
           
           select l.master_template_id
           into v_mast_template_id
           from pbl.pbl_template t 
           join pbl.pbl_layout l
           on t.layout_id=l.layout_id
           where template_id=v_template_id;
           
      OPEN p_page_cur FOR  
      select v_is_detail is_detail,p.* from pbl.pbl_page p where page_id=v_page_id;   
      
      OPEN p_page_ent_cur FOR  
      select a.* from pbl.pbl_asset_entity_map a where asset_id=v_page_id and asset_type_id=v_page_asset_type_id;   
      
      OPEN p_tempt_cur FOR  
      select t.* from pbl.pbl_template t where template_id=v_template_id;   
      
      OPEN p_tc_cur FOR  
      select tc.* from pbl.pbl_template_component_map tc where template_id=v_template_id
      and is_deleted=0 and is_active=1;  
      
      OPEN p_tc_ent_cur FOR  
      select a.* from pbl.pbl_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from pbl.pbl_template_component_map tc 
                  where template_id=v_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id;
      
      OPEN p_mast_tempt_cur FOR  
      select t.* from pbl.pbl_template t where template_id=v_mast_template_id;   
      
      OPEN p_mast_tc_cur FOR  
      select tc.* from pbl.pbl_template_component_map tc where template_id=v_mast_template_id
      and is_deleted=0 and is_active=1;  
      
      OPEN p_mast_tc_ent_cur FOR  
      select a.* from pbl.pbl_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from pbl.pbl_template_component_map tc 
                  where template_id=v_mast_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id;
      
      if v_is_detail = 1 then 
        
        
        
        
         OPEN p_asset_detail_cur FOR
         SELECT * FROM pbl.pbl_ASSET_DRAFT
         WHERE asset_id=v_asset_id and asset_type_id=v_asset_type_id 
         and version_number=v_published_version_number
         and is_deleted=0 and is_active=1;
         
         OPEN p_asset_ent_cur FOR
         SELECT * FROM pbl.pbl_asset_entity_map
         WHERE asset_id=v_asset_id and asset_type_id=v_asset_type_id
         and is_deleted=0 and is_active=1;
         
         IF v_asset_type_id= 1 then
           -- article
           OPEN p_asset_map_cur FOR
           SELECT * FROM pbl.pbl_article where article_id=v_asset_id
           and is_deleted=0 and is_active=1;
           
         ELSIF v_asset_type_id= 2 then
           -- album
           OPEN p_asset_map_cur FOR
           SELECT * FROM pbl.pbl_album where album_id=v_asset_id
           and is_deleted=0 and is_active=1;
           
         ELSIF v_asset_type_id= 4 then
           -- album
           OPEN p_asset_map_cur FOR
           SELECT * FROM pbl.pbl_video where video_id=v_asset_id
           and is_deleted=0 and is_active=1;  
         end if;
         
      end if;
      
      
     -- RETURN next ref;                                                       
    END;
    

  $$;


--
