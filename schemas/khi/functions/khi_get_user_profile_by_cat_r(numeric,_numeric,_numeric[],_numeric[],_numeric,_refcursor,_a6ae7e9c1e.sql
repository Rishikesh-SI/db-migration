-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_user_profile_by_cat_r(numeric, numeric, numeric[], numeric[], numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: khi_get_user_profile_by_cat_r(numeric, numeric, numeric[], numeric[], numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_user_profile_by_cat_r(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_othentrole_mapid numeric[], p_web_user_id numeric, p_asset_count refcursor, p_asset_cur refcursor, p_web_user_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_createdbyquery varchar(50) := ' ';
    
  -- v_searchkeyword varchar(4000) := p_searchkeyword;
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
    v_othent_count numeric;
    v_assettypeidcount numeric;
    v_assettypequery varchar(4000) := ' ';
    v_entityrolemapidquery varchar(4000) := ' ';
    v_qry_str varchar(100000);
	  v_language_id numeric ;
    v_language_id1 numeric[] ;
	  v_lang_master_id numeric;
    v_cat_name varchar(20) := 'Category Type';
    p_lang_array numeric[];
    v_entityrolemapidquery1 text:= ' ';
    v_cat_array numeric[];
  
    v_entityrole_mapid numeric[];
    v_entityrole_mapid1 numeric[];
    v_language_mast_id numeric;
begin
 
  v_sysdate:= current_timestamp at time zone 'utc';
 v_cat_name := ''''||v_cat_name||'''';
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
	 
   
    select count(1)
     into   v_othent_count
     from   unnest(p_othentrole_mapid)entity_id;
   
   raise notice '%',v_othent_count;
   -- select 1/0 ;
   
   if v_othent_count >=1
   then 
   
    v_entityrolemapidquery := 'and    exists (select 1
                   from   khi.khi_asset_entity_map eam
                   where  eam.asset_id= b.asset_id
                   and    eam.asset_type_id = b.asset_type_id 
                   and    eam.entity_role_map_id in (select entity_role_mapid
							 from unnest($3) u(entity_role_mapid))
                        group by eam.asset_id,eam.asset_type_id  )';
end if ;
   
   
      
   if v_ent_count >1 then
   --   p_entityrole_mapid:= array[0];
    --  end if;
   
	  -- changes done by rakesh bhatkar date 23/03/2017----
	
	 -- select array( select khi.khi_get_entity_language_from_entities(array[7926,7695])) into v_language_id;
   --  raise notice '%',v_language_id;
    -- select 1/0;
	
  
 
  
  select entity_role_map_id into v_language_id
		from khi.khi_entity_role_map
		where entity_role_id in(select entity_role_id 
                                from khi.khi_entity_category 
                                where category_name='Language')
		and entity_role_map_id in(select entity_role_map_id from unnest(p_entityrole_mapid) u(entity_role_map_id))
		and is_active = 1
		and priority > 0;
   
    raise notice '%',v_language_id;
    -- select 1/0;
    
    
     select array(select *
     from   unnest(p_entityrole_mapid)entity_id
     where entity_id !=v_language_id
     ) into v_entityrole_mapid1
     ; 
  
  -- raise notice '%',v_entityrole_mapid1;
   -- select 1/0;
    
  select array(
        select entity_role_map_id
		    from khi.khi_entity_role_map
		    where entity_role_id in(select entity_role_id 
                                from khi.khi_entity_category 
                                where category_name='Language')
        and entity_role_map_id in(select entity_role_map_id from unnest(p_entityrole_mapid) u(entity_role_map_id))
		    and is_active = 1
		    and priority > 0
    )   into v_entityrole_mapid;
    
    
    SELECT  ERM.entity_master_id 
    into v_language_mast_id 
    FROM khi.khi_ENTITY_ROLE_MAP ERM 
    where ERM.ENTITY_ROLE_MAP_ID = (v_language_id)
    ;

   
   
	 select entity_master_id
       into v_lang_master_id
      from khi.khi_entity_role_map
      where entity_role_map_id = v_language_id;
      
     -- if v_ent_count = 1 then
      	select array(
      	select entity_role_map_id
		from khi.khi_entity_role_map
		where entity_role_id in(select entity_role_id 
                                from khi.khi_entity_category 
                                where category_name='Category Type')
		and is_active = 1
		and priority > 0
    )
        into v_cat_array;
     /*   
      --elsif v_ent_count > 1 then
      	select array(
        select entity_role_map_id
		from khi.khi_entity_role_map
		where entity_role_id in(select entity_role_id 
                                from khi.khi_entity_category 
                                where category_name='Category Type')
		and entity_role_map_id in(select entity_role_map_id from unnest(p_entityrole_mapid) u(entity_role_map_id))
		and is_active = 1
		and priority > 0)
        into v_cat_array;
     -- end if;
 */
 
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    
  -- if v_ent_count > 0 then
    	
    --  v_entityrolemapidquery := 'and    exists (select 1
               --    from   khi.khi_asset_entity_map eam
               --    where  eam.asset_id= sl.asset_id
                --   and    eam.asset_type_id = sl.asset_type_id 
                 --  and    eam.entity_role_map_id in (select entity_role_mapid
							-- from unnest($1) u(entity_role_mapid))
                    --    group by eam.asset_id,eam.asset_type_id  )';
                        
--	v_entityrolemapidquery1 := 'and    exists (select 1
          --         from   khi.khi_asset_entity_map eam
             --      where  eam.asset_id= sl.asset_id
              --     and    eam.asset_type_id = sl.asset_type_id 
               --    and    eam.entity_role_map_id in (select entity_role_mapid
							-- from unnest($2) u(entity_role_mapid))
                   --     group by eam.asset_id,eam.asset_type_id
                   --     having count(1)=1)';
     
    --end if;
 
 
 
 v_qry_str :='
select count(*),
       sentid,
       coalesce(elm.entity_display_name,em.entity_display_name) disp_name
   from (
        select   a.asset_id ,a.asset_type_id,
                a.sentid 
   from ( select  
             sl.asset_id ,sl.asset_type_id,
             eamc.entity_role_map_id as sentid    
    			   from   khi.khi_asset_list sl
             join   khi.khi_entity_role_map erm
             on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
             join   khi.khi_asset_entity_map eamc
             on     eamc.asset_id = sl.asset_id
             and    eamc.asset_type_id = sl.asset_type_id
             and    eamc.entity_role_map_id 
             in 
                                           (select entity_role_map_id
                                            from   khi.khi_entity_role_map
                                            where  entity_role_id in(select entity_role_id
                                                            from khi.khi_entity_category
                                                            where category_name = '||v_cat_name||')
                                   and    is_active = 1
                                   and    priority > 0) 
                                   
                  where  sl.is_active=1
                  and    sl.is_deleted=0
                  and    sl.is_published=1
                 and    sl.published_date<='''||v_sysdate||'''
                  and    sl.asset_type_id in (1,2,4,5,6) 
                  and    erm.priority>0
                  )a
                  where  exists (select 1
                                            from   khi.khi_asset_entity_map eam
                                           where  eam.asset_id= a.asset_id
                                            and    eam.asset_type_id = a.asset_type_id 
                                           and    eam.entity_role_map_id =ANY ($1::numeric[])
                           
                                       GROUP BY eam.asset_id,eam.asset_type_id
                  )
                  )b
                  join khi.khi_entity_role_map erm
                  on erm.entity_role_map_id = b.sentid
                  join khi.khi_entity_master em
                  on em.entity_master_id = erm.entity_master_id
                  left join khi.khi_entity_language_map elm
                  on elm.entity_master_id=em.entity_master_id
                  and elm.language_master_id ='''||v_language_mast_id||'''
                  where exists (select 1
                                          from   khi.khi_asset_entity_map eam
                                          where  eam.asset_id=b.asset_id
                                            and    eam.asset_type_id = b.asset_type_id 
                                          and    eam.entity_role_map_id =ANY ($2::numeric[])
                                      GROUP BY eam.asset_id,eam.asset_type_id
               )
                    group by sentid,
                  em.entity_display_name,
                  elm.entity_display_name
                   '
                  ;               
 open  p_asset_count for
      execute v_qry_str
      using v_entityrole_mapid,v_entityrole_mapid1
      ;
 
v_qry_str := 'select  * from (select a.*,
                      row_number()over (order by a.published_date desc) as rno
                    from (  SELECT            
                                asset_list_id,  
                                asset_id,
                                asset_type_id,  
                                asset_title, 
                                title_alias, 
                                author_id,
                                short_desc, 
                                tags, 
                                primary_entity_role_map_id, 
                                secondary_entity_role_map_id,
                                total_assets,
                                image_file_name, image_path, 
                                duration,
                                published_version_number,  
                                sl.created_date, 
                                sl.updated_date, 
                                sl.created_by, 
                                sl.updated_by, 
                                published_date, 
                                asset_guid, 
                                show_copyright,
                                order_number,
                                image_file_name, 
                                image_path, 
                                u.display_name display_name,
                                u.user_name user_name,
                                u.full_name full_name,
                                emp.entity_name primary_entity_name,
                                ems.entity_name secondary_entity_name,
                                COALESCE(pel.entity_display_name,emp.entity_display_name) pri_ent_disp_name,
                                COALESCE(sel.entity_display_name,ems.entity_display_name) sec_ent_disp_name  
                          FROM khi.khi_asset_list sl
                          left join khi.khi_user u
                          on u.user_id = sl.author_id 
                          join   khi.khi_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   khi.khi_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   khi.khi_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          left join khi.khi_entity_language_map pel
                          on     emp.entity_master_id=pel.entity_master_id
                          and    pel.language_master_id ='''||v_language_mast_id||'''
                          join   khi.khi_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
                          left join khi.khi_entity_language_map sel
                          on     ems.entity_master_id=sel.entity_master_id
                          and    sel.language_master_id ='''||v_language_mast_id||'''
                          where sl.is_active=1
       		              and sl.is_deleted=0
                          and    sl.is_published=1
                        and    sl.published_date<='''||v_sysdate||'''
                          and    sl.asset_type_id in (1,2,4,5)
                          and    EXISTS (select 1
                                            from   khi.khi_asset_entity_map eam
                                            where  eam.asset_id= sl.asset_id
                                            and    eam.asset_type_id = sl.asset_type_id 
                                            and    eam.entity_role_map_id =ANY ($2::numeric[])
                                            GROUP BY eam.asset_id,eam.asset_type_id
                       
                                        )
                        ) a
 where exists (
                            select 1
                            from   khi.khi_asset_entity_map eam
                            where  eam.asset_id= a.asset_id
                            and    eam.asset_type_id = a.asset_type_id 
                            and    eam.entity_role_map_id =ANY ($1::numeric[])
                            GROUP BY eam.asset_id,eam.asset_type_id
               ) 
               )b
 where rno between '||v_fromrownumber||' and '||v_torownumber || v_entityrolemapidquery ||'

 
 '
 ;

-- raise notice '% ',v_qry_str;
-- select 1/0;

 

open  p_asset_cur for
      execute v_qry_str
      using v_entityrole_mapid1,v_entityrole_mapid,p_othentrole_mapid
      ;
 

  
else 
 
 open  p_asset_count for
    select 1 as count ,null as sent_id ,3 disp_name from khi.khi_asset_list
    where 1=2 ;
   
 open  p_asset_cur for select 
                                null asset_list_id,  
                                null asset_id,
                                null asset_type_id,  
                                null asset_title, 
                                null title_alias, 
                                null author_id,
                                null short_desc, 
                                null tags, 
                                null  primary_entity_role_map_id, 
                                null secondary_entity_role_map_id,
                                null total_assets,
                                null image_file_name,
                                null image_path, 
                                null duration,
                                null published_version_number,  
                                null created_date, 
                                null updated_date, 
                                null created_by, 
                                null updated_by, 
                                null published_date, 
                                null asset_guid, 
                                null show_copyright,
                                null order_number,
                                null image_file_name, 
                                null image_path, 
                                null  as rno,
                                null display_name,
                                null user_name,
                                null full_name,
                                null primary_entity_name,
                                null secondary_entity_name,
                                null  pri_ent_disp_name,
                                null sec_ent_disp_name
 
 from khi.khi_asset_list
    where 1=2 ;
   

end if ;
open  p_web_user_cur for

select 
user_id,
user_full_name,
social_user_name,
user_bio,
email_id,
gender,
dob,
profile_picture_url ,
b.timeline_info
from khi.khi_web_user a 
left join khi.khi_web_user_timeline b on a.user_id=b.web_user_id
where user_id= p_web_user_id;
end;

$_$;


--
