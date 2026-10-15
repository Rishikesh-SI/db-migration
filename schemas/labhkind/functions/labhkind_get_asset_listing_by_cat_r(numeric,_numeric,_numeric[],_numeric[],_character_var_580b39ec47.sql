-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_asset_listing_by_cat_r(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labhkind_get_asset_listing_by_cat_r(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_asset_listing_by_cat_r(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_asset_count refcursor, p_asset_cur refcursor, p_category_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

 

declare
	
    v_createdbyquery varchar(50) := ' ';
    
    v_searchkeyword varchar(4000) := p_searchkeyword;
    v_entitysearchquery varchar(4000) := ' ';
    v_playerentitysearchquery varchar(4000) := ' ';
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
    v_assettypeidcount numeric;
    v_assettypequery varchar(4000) := ' ';
    v_entityrolemapidquery varchar(4000) := ' ';
    v_qry_str varchar(100000);
	v_language_id numeric;
	v_lang_master_id numeric;
  v_cat_name varchar(20) := 'Category Type';
  p_lang_array numeric[];
  v_entityrolemapidquery1 text:= ' ';
  v_cat_array numeric[];
  v_entityrole_mapid numeric[];
  v_entityrole_mapid1 numeric[];
  v_array_length numeric;
  v_ent numeric ;
  v_str_query text :=' ';
begin
    v_sysdate:= current_timestamp at time zone 'utc';
   
    v_cat_name := ''''||v_cat_name||'''';
    select array_length(p_entityrole_mapid, 1) into v_array_length;
   --  raise notice '%',v_cat_name;
   -- select 1/0;
     
     
	 
	 if v_array_length > 1 then 
      v_entityrole_mapid:=p_entityrole_mapid;
      v_entityrole_mapid1:=p_entityrole_mapid;
	  
	  select entity_role_mapid into v_ent
	    from unnest(p_entityrole_mapid) u(entity_role_mapid)
	    where entity_role_mapid in (222,333);
		if v_ent is not null then 
		v_str_query:=' and waf_tour_master_id=$6 ';
		else 
		v_str_query:=' and 1=2 ';
		
		end if ;
		
     else 
     v_entityrole_mapid:=array[22,23,24,25];
     v_entityrole_mapid1:=array[26,27,28,29];
     end if ;
     
	 
	  
	 
	 
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
	 
     
    
	  -- changes done by rakesh bhatkar date 23/03/2017----
	 select labhkind.labhkind_get_entity_language_from_entities(p_entityrole_mapid) into v_language_id;
	 
     --raise notice '%',v_language_id;
     -- select 1/0;
	 
	 select entity_master_id
      into v_lang_master_id
      from labhkind.labhkind_entity_role_map
      where entity_role_map_id = v_language_id;
      
      if v_ent_count = 1 then
      	select array(
      	select entity_role_map_id
		from labhkind.labhkind_entity_role_map
		where entity_role_id in(select entity_role_id 
                                from labhkind.labhkind_entity_category 
                                where category_name='Category Type')
		and is_active = 1
		and priority > 0)
        into v_cat_array;
      elsif v_ent_count > 1 then
      	select array(
        select entity_role_map_id
		from labhkind.labhkind_entity_role_map
		where entity_role_id in(select entity_role_id 
                                from labhkind.labhkind_entity_category 
                                where category_name='Category Type')
		and entity_role_map_id in(select entity_role_map_id from unnest(p_entityrole_mapid) u(entity_role_map_id))
		and is_active = 1
		and priority > 0)
        into v_cat_array;
      end if;
	  
     -- changes done by rakesh bhatkar date 23/03/2017----
    if v_ent_count > 0 then
    	
     v_entityrolemapidquery := 'and    exists (select 1
                   from   labhkind.labhkind_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in (select entity_role_mapid
							 from unnest($2) u(entity_role_mapid))
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_ent_count ||')';
                        
	v_entityrolemapidquery1 := 'and    exists (select 1
                   from   labhkind.labhkind_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in (select entity_role_mapid
							 from unnest($2) u(entity_role_mapid))
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)=1)';
     
    end if;
    
    
   v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if v_searchkeyword is not null then
    			-- v_searchkeyword := replace(v_searchkeyword,'''','''''');
                
                v_searchkeyword:=  regexp_replace(v_searchkeyword, '([''!$()*+.:<=>?[\\\]^{|}-])', '\\\1', 'g');        
        
        		 v_searchkeyword:=replace(v_searchkeyword,'''','''''');
                
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
										
				--v_playerentitysearchquery:='and ( to_tsvector( entity_name) @@@ to_tsquery( '''||v_searchkeyword||''') 
                 --                        or to_tsvector( entity_display_name) @@@ to_tsquery( '''||v_searchkeyword||'''))';
				 v_playerentitysearchquery:='and  lower(entity_name) like ''%'||lower(p_searchkeyword)||'%''';
                
     end if;
     
    select count(asset_type_id)
	into   v_assettypeidcount
	from   unnest(p_asset_type_id) u(asset_type_id);
    
    if v_assettypeidcount > 0 then
    		
          v_assettypequery := 'and sl.asset_type_id in(select asset_type_id from unnest($1) u(asset_type_id))';
          
    end if;
    

     v_qry_str:= 'select distinct * from (select   count(1) cnt,
      eamc.entity_role_map_id as sentid    
    			   from   labhkind.labhkind_asset_list sl
             join   labhkind.labhkind_entity_role_map erm
             on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
             join   labhkind.labhkind_asset_entity_map eamc
             on     eamc.asset_id = sl.asset_id
             and    eamc.asset_type_id = sl.asset_type_id
             and    eamc.entity_role_map_id in (select entid from unnest($3) u(entid))
                  where  sl.is_active=1
                  and    sl.is_deleted=0
                  and    sl.is_published=1
                  and    sl.published_date<='''||v_sysdate||'''
                  and    sl.asset_type_id in (1,2,4,5,6) 
                  and    erm.priority>0  '
                  ||v_assettypequery
             
    			   ||v_entityrolemapidquery
                  ||v_entitysearchquery || '
                  group by eamc.entity_role_map_id 
				
				union all 
				select sum(cnt) as cnt,entid from ( select  count(1) cnt , entity_role_id,
				case when entity_role_id=22 then 222
                           when entity_role_id=23 then 222 
						   when entity_role_id=24 then 222
						   when entity_role_id=25 then 222  end 
						   entid
				from labhkind.labhkind_entity_master a
               join labhkind.labhkind_entity_role_map b on a.entity_master_id=b.entity_master_id
               where entity_role_id in (select entity_role_map_id from unnest(array[22,23,24,25]) u(entity_role_map_id))
			   and source_object_id !=''''
               -- added by Dipnil on dated 20181207 
            
               '
			 ||v_playerentitysearchquery||v_str_query||
			  'group by entity_role_id
			 ) a group by entid
			
			union all 
			select sum(cnt) as cnt,entid from (
			select count(1) cnt , entity_role_id,
			case when entity_role_id=26 then 333
                           when entity_role_id=27 then 333 
						   when entity_role_id=28 then 333
						   when entity_role_id=29 then 333  end 
						   entid 
				from labhkind.labhkind_entity_master a
               join labhkind.labhkind_entity_role_map b on a.entity_master_id=b.entity_master_id
               where entity_role_id in (select entity_role_map_id from unnest(array[26,27,28,29]) u(entity_role_map_id))
			   and source_object_id !=''''
               -- added by Dipnil on dated 20181207 
             '
			 ||v_playerentitysearchquery||v_str_query||'group by entity_role_id
			 )a group by entid
			
			)tab
            order by sentid desc
			 ' ;
			 
			--raise notice '%',p_entityrole_mapid;
    --select 1/0;
                
    open p_asset_count for 
    execute  v_qry_str
    using  p_asset_type_id,p_entityrole_mapid, v_cat_array,v_entityrole_mapid,v_entityrole_mapid1,v_ent;
    
   
   
   v_qry_str:= 'select * from (
   select * from(select asset_list_id, asset_id, 
   asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, 
						primary_entity_role_map_id,
						secondary_entity_role_map_id,
						total_assets,
                          image_file_name, image_path, duration, show_in_web,
                          show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, 
                          sl.updated_date, sl.created_by,
                          sl.updated_by,
                          sl.is_active, sl.is_deleted, 
                          sl.is_published, published_date, 
                          asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , 
             rank()over (partition by secondary_entity_role_map_id order by sl.asset_type_id, sl.published_date desc) as rno,
              labhkind.labhkind_get_user_display_name(sl.author_id) display_name,
             (select user_name from labhkind.labhkind_user where user_id=sl.author_id) as user_name,
            (select full_name from labhkind.labhkind_user where user_id=sl.author_id) as full_name,
             emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name,
             erms.priority sent_priority,3 as srno
            from labhkind.labhkind_asset_list sl
--                          left join labhkind.labhkind_user u
--                          on u.user_id = sl.author_id
                          /*join labhkind.labhkind_entity_role_map erm
                          on erm.entity_role_map_id = primary_entity_role_map_id
                          join labhkind.labhkind_entity_master em
                          on em.entity_master_id = erm.entity_master_id*/
                          join   labhkind.labhkind_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   labhkind.labhkind_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   labhkind.labhkind_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   labhkind.labhkind_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
              where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
              and    sl.published_date<='''||v_sysdate||'''
              and    sl.asset_type_id in (1,2,4,5,14)
              and    erms.priority>0 '
    ||v_assettypequery||
 
                                v_entityrolemapidquery
                   ||v_entitysearchquery||           
                   '
         ) as tab2
         
		
	   union all 
	   
	   select a.entity_master_id, b.source_object_id ::numeric,
	   0 asset_type_id, entity_name as entity_name, canonical_url  as canonical_url, null,
                          null, null, 6, 222, null,
                          a.player_image_path, ''images/players/small/'', 
						  null, 1, 1, 1,
                          1, 0, a.created_date, a.updated_date, a.created_by, a.updated_by,
                          a.is_active, a.is_deleted, 1 , current_timestamp as published_date, null, null, null,
                          null, null
             , 
             rank()over ( order by b.source_object_id  desc) as rno,
              null,
             null,
            null,
             ''Players'' primary_entity_name,
             ''Players'' secondary_entity_name,
              null,2 as srno
			
				from labhkind.labhkind_entity_master a
               join labhkind.labhkind_entity_role_map b on a.entity_master_id=b.entity_master_id
               where entity_role_id in (select entity_role_map_id from unnest(array[22,23,24,25]) u(entity_role_map_id))
              and source_object_id !=''''
               
               '
			 ||v_playerentitysearchquery||v_str_query||'
			
			union all 
			
			select a.entity_master_id, b.source_object_id ::numeric, 0 asset_type_id, entity_name, canonical_url as canonical_url, null,
                          null, null, 6, 333, null,
                          a.player_image_path, ''images/Coach/small/'', 
						  null, 1, 1, 1,
                          1, 0, a.created_date, a.updated_date, a.created_by, a.updated_by,
                          a.is_active, a.is_deleted,1, current_timestamp as published_date,null, null, null,
                          null, null
             , 
             rank()over ( order by b.source_object_id  desc) as rno,
              null,
             null,
            null,
             ''Coach'' primary_entity_name,
             ''Coach'' secondary_entity_name,
              null,1 as srno
			
				from labhkind.labhkind_entity_master a
               join labhkind.labhkind_entity_role_map b on a.entity_master_id=b.entity_master_id
               where entity_role_id in (select entity_role_map_id from unnest(array[26,27,28,29]) u(entity_role_map_id))
               and source_object_id !='''' '
			 ||v_playerentitysearchquery||v_str_query||'
			
			  )  as tab1
        where rno between '||v_fromrownumber||' and '||v_torownumber||'
		order by srno, rno
        ';
      
      open  p_asset_cur for
      execute v_qry_str
      using   p_asset_type_id,p_entityrole_mapid,v_entityrole_mapid,v_entityrole_mapid1,null,v_ent;
     
     select array(
     select erm.entity_role_map_id
     from labhkind.labhkind_entity_category ec
     join labhkind.labhkind_entity_role_map erm
     on erm.entity_role_id = ec.entity_role_id
     and ec.category_name = 'Language'
     where erm.entity_role_map_id in(
     select entity_role_map_id
     from unnest(p_entityrole_mapid)u(entity_role_map_id)))
     into p_lang_array;
     
      
    
    open p_category_cur for
   execute ' select * from (with tab(cnt, entid) as
(
select count(1) cnt, eamc.entity_role_map_id as entid
from   labhkind.labhkind_asset_list sl
join   labhkind.labhkind_entity_role_map erm
on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
join   labhkind.labhkind_asset_entity_map eamc
on     eamc.asset_id = sl.asset_id
and    eamc.asset_type_id = sl.asset_type_id
and    eamc.entity_role_map_id in (select entity_role_map_id
                                   from   labhkind.labhkind_entity_role_map
                                   where  entity_role_id in(select entity_role_id
                                                            from labhkind.labhkind_entity_category
                                                            where category_name = '||v_cat_name||')
                                   and    is_active = 1
                                   and    priority > 0)
where  sl.is_active = 1
and    sl.is_deleted = 0
and    sl.is_published = 1
and    sl.published_date <= '''||v_sysdate||'''
and    sl.asset_type_id in (1,2,4,5,6) 
and    erm.priority > 0 '
||v_entityrolemapidquery1
||v_entitysearchquery
||' group by eamc.entity_role_map_id 
)
select t.cnt, t.entid, coalesce(elm.entity_display_name, em.entity_display_name)entity_name, 
em.entity_display_name entity_eng_name
from tab t
join labhkind.labhkind_entity_role_map erm
on erm.entity_role_map_id = t.entid
join labhkind.labhkind_entity_master em
on em.entity_master_id = erm.entity_master_id
left join labhkind.labhkind_entity_language_map elm
on elm.entity_master_id = em.entity_master_id
and    elm.entity_master_id = '||v_lang_master_id
|| '
union all 
select sum(cnt) as cnt,entid ,
''Players'' as  entity_name ,''Players''  entity_eng_name
from ( select  count(1) cnt , entity_role_id,
				case when entity_role_id=22 then 222
                           when entity_role_id=23 then 222 
						   when entity_role_id=24 then 222
						   when entity_role_id=25 then 222  end 
						   entid
				from labhkind.labhkind_entity_master a
               join labhkind.labhkind_entity_role_map b on a.entity_master_id=b.entity_master_id
               where entity_role_id in (select entity_role_map_id from unnest(array[22,23,24,25]) u(entity_role_map_id))
			   and source_object_id !=''''
               -- added by Dipnil on dated 20181207 
            
               '
			 ||v_playerentitysearchquery||'group by entity_role_id
			 ) a group by entid
			 
			
union all 
select sum(cnt) as cnt,entid ,
''Coach'' as  entity_name ,''Coach''  entity_eng_name from (
select  count(1) cnt , entity_role_id,case when entity_role_id=26 then 333
                           when entity_role_id=27 then 333 
						   when entity_role_id=28 then 333
						   when entity_role_id=29 then 333  end 
						   entid
						   from labhkind.labhkind_entity_master a
 join labhkind.labhkind_entity_role_map b on a.entity_master_id=b.entity_master_id
 where entity_role_id in (26,27,28,29)
 and source_object_id !='''' '
||v_playerentitysearchquery||'group by entity_role_id
	) a group by entid 		
			)  row order by case when entity_eng_name=''Players'' then 1
			                    when entity_eng_name=''Coach'' then 1  else 0 end'

using null,p_lang_array,v_entityrole_mapid,v_entityrole_mapid1,null,v_ent;
     
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

 

$_$;


--
