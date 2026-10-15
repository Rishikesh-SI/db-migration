-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_get_page_data_r_ak(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: jafc_get_page_data_r_ak(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_get_page_data_r_ak(p_url character varying, p_page_cur refcursor, p_page_ent_cur refcursor, p_tempt_cur refcursor, p_tc_cur refcursor, p_tc_ent_cur refcursor, p_mast_tempt_cur refcursor, p_mast_tc_cur refcursor, p_mast_tc_ent_cur refcursor, p_redirect_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

    declare
      -- ref refcursor;  
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
      
      -- declare a cursor variable
    begin   
            v_url :=p_url;
            
           select page_id 
           into v_page_id from jafc.jafc_page
           where alias=v_url;
           
           if v_page_id is null then
              select page_id 
                into v_page_id 
              from jafc.jafc_page where v_url ~ concat(alias,'$')
              and alias<>'';
           end if;
           
           select * into v_count from jafc.regexp_count(p_url, '/');
           
           if v_page_id is null then
              
              v_is_detail:=1;
              
              v_asset_alias :=   split_part(p_url, '/', (v_count+1))  ;
              
              select asset_id,asset_type_id ,published_version_number
              into v_asset_id,v_asset_type_id,v_published_version_number
              
              from jafc.jafc_asset_list a
              where title_alias=v_asset_alias;
            
              
              select rtrim(p_url,
                           split_part(p_url, '/', (v_count+1)) || '/'
                           ) into v_url; 
                                 
              select * into v_count from jafc.regexp_count(v_url, '/');
               v_count:=v_count+1;
               
               v_loop_count:=v_count;
               -- v_url:= p_url;
               
               for i in 1..v_count
               loop
               
                   raise notice '%',v_url;
                             
                   select page_id into v_par_page_id from jafc.jafc_page
                     where alias=v_url;
                     
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
                      from   jafc.jafc_page
                      where  parent_id=v_par_page_id
                      and    asset_type_id=v_asset_type_id;
                      
                      exit;
                   end if;           
                   v_loop_count:=v_loop_count-1;
               
               end loop;
           end if;
           
           if v_page_id is null and v_asset_id is not null then
              select page_id into v_par_page_id from jafc.jafc_page
                     where alias='';
              select page_id
                      into   v_page_id
                      from   jafc.jafc_page
                      where  parent_id=v_par_page_id
                      and    asset_type_id=v_asset_type_id;
                      
           elsif  v_page_id is null and v_asset_id is  null then
                select jafc.jafc_get_new_url(v_asset_alias) into v_new_asset_alias;
                
           end if;
          
           select t.parent_id into v_template_id from jafc.jafc_template t where page_id=v_page_id;
           
           select l.master_template_id
           into v_mast_template_id
           from jafc.jafc_template t 
           join jafc.jafc_layout l
           on t.layout_id=l.layout_id
           where template_id=v_template_id;
           
      open p_page_cur for  
      select v_is_detail is_detail,p.* from jafc.jafc_page p where page_id=v_page_id;   
      
      open p_page_ent_cur for  
      select a.* from jafc.jafc_asset_entity_map a where asset_id=v_page_id and asset_type_id=v_page_asset_type_id;   
      
      open p_tempt_cur for  
      select t.* from jafc.jafc_template t where template_id=v_template_id;   
      
      open p_tc_cur for  
      select tc.* from jafc.jafc_template_component_map tc where template_id=v_template_id
      and is_deleted=0 and is_active=1;  
      
      open p_tc_ent_cur for  
      select a.* from jafc.jafc_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from jafc.jafc_template_component_map tc 
                  where template_id=v_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id;
      
      open p_mast_tempt_cur for  
      select t.* from jafc.jafc_template t where template_id=v_mast_template_id;   
      
      open p_mast_tc_cur for  
      select tc.* from jafc.jafc_template_component_map tc where template_id=v_mast_template_id
      and is_deleted=0 and is_active=1;  
      
      open p_mast_tc_ent_cur for  
      select a.* from jafc.jafc_asset_entity_map a where 
      asset_id in (select tc.template_component_map_id from jafc.jafc_template_component_map tc 
                  where template_id=v_mast_template_id and tc.is_deleted=0 and tc.is_active=1)
      and asset_type_id=v_tc_asset_type_id;
      
      open p_redirect_cur for 
      select v_new_asset_alias as new_asset_alias, case when v_new_asset_alias is not null  then 1  else 0 end as is_redirect;
      
      
      
--      if v_is_detail = 1 then 
--        
--        
--        
--        
--         open p_asset_detail_cur for
--         select * from jafc.jafc_asset_draft
--         where asset_id=v_asset_id and asset_type_id=v_asset_type_id 
--         and version_number=v_published_version_number
--         and is_deleted=0 and is_active=1;
--         
--         open p_asset_ent_cur for
--         select * from jafc.jafc_asset_entity_map
--         where asset_id=v_asset_id and asset_type_id=v_asset_type_id
--         and is_deleted=0 and is_active=1;
--         
--         if v_asset_type_id= 1 then
--           -- article
--           open p_asset_map_cur for
--           select * from jafc.jafc_article where article_id=v_asset_id
--           and is_deleted=0 and is_active=1;
--           
--         elsif v_asset_type_id= 2 then
--           -- album
--           open p_asset_map_cur for
--           select * from jafc.jafc_album where album_id=v_asset_id
--           and is_deleted=0 and is_active=1;
--           
--         elsif v_asset_type_id= 4 then
--           -- album
--           open p_asset_map_cur for
--           select * from jafc.jafc_video where video_id=v_asset_id
--           and is_deleted=0 and is_active=1;  
--         end if;
--      else
--      	open p_asset_detail_cur for
--         select 1  as cnt;
--         
--         open p_asset_ent_cur for
--         select 1  as cnt;
--
--		 open p_asset_map_cur for
--         select 1  as cnt;
--      end if;
--      
      
     -- return next ref;                                                       
    end;
    

$_$;


--
