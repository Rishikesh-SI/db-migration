-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[])
-- Type: FUNCTION

-- Name: labstrd_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[]); Type: FUNCTION; Schema: labstrd; Owner: -
--

CREATE FUNCTION labstrd.labstrd_get_asset_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_exclude_ent_id numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$
 

declare
	/*
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=2;
	p_page1_size numeric:=2;
	p_entityrole_mapid numeric[]:=array[5,3];
	p_any_entityrole_mapid numeric[]:=null;
	p_asset_type_id numeric[]:=null;
	p_searchkeyword character varying:=null;
	p_assetcount numeric;
	p_assetjson jsonb;
	*/
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
	v_ent_count1 numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
    
    v_anyentityrolemapidquery varchar(4000) := ' ';
    v_any_ent_count numeric;
    v_entityrole_mapid numeric[];
    v_arr_asset_list_id numeric[];
    v_str_arr_asset_list_id varchar(1000000);
    
    v_str_entityrole_mapid varchar(1000000);
    v_allentityjson jsonb ; 
	v_season_json jsonb;
	v_cat_json jsonb;
	v_str text;
	v_ent_name text;
	v_role_id numeric;
begin

/*-- new changes done by rakesh bhatkar
 add username and full_name
 date :-15112017 
-- end--
*/

     v_sysdate:= current_timestamp at time zone 'utc';
     
	 select count(distinct entity_id)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     select count(1)
     into   v_any_ent_count
     from   unnest(p_any_entityrole_mapid)entity_id;
     
     -- changes done by rakesh b date :-20-04-2017--
     
     
     if p_page1_size is null 
     then 
              v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
              v_torownumber   := (p_pagenumber * p_itemnumber);
      else 
          if (p_pagenumber=1) then 
          v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          v_fromrownumber := p_page1_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
           end if;
   v_torownumber   := p_page1_size + ( (p_pagenumber-1) * p_itemnumber);
end if;
   
   
    select labstrd.labstrd_get_entity_language_from_entities(p_entityrole_mapid)
    into v_language_id;
    
    
    select  erm.entity_master_id into v_language_mast_id 
    from labstrd.labstrd_entity_role_map erm 
    where erm.entity_role_map_id =(v_language_id);
    
    v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
    
    if v_searchkeyword is not null then
     	
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
     
    if v_any_ent_count > 0 then
    	
     v_anyentityrolemapidquery := ' and    exists (select 1
                                         from   labstrd.labstrd_asset_entity_map eam
                                         where  eam.asset_id= sl.asset_id
                                         and    eam.asset_type_id = sl.asset_type_id 
                                         and    eam.entity_role_map_id in 
                                          (select any_entity_role_mapid 
                                          from unnest($4) u(any_entity_role_mapid))
                                         ) ';
     
    end if;
     
    execute 'select cnt ,''{"items":[''||string_agg(web_listing_json::text,'','')||'']}'' from (select count(1)over() as cnt ,
					row_number()over (order by sl.published_date desc) as rno,
					asset_list_id,web_listing_json
    from   labstrd.labstrd_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (1,2,4,5) 
    and    sl.asset_type_id in 
                    (case when $1 is not null then
                    (select asset_type_id from unnest($1) u(asset_type_id))
                    else sl.asset_type_id
                    end )
    and    exists (select 1
                   from   labstrd.labstrd_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id =any ($2::numeric[])
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_ent_count ||') '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery||              
                   '
    )tab
	where rno between '||v_fromrownumber||' and '||v_torownumber||'
                        group by cnt
    '
    into   p_assetcount,p_assetjson
    using  p_asset_type_id,v_str_entityrole_mapid ,	p_any_entityrole_mapid ,p_any_entityrole_mapid ;
    		
			
			
		select array(select id from unnest(p_entityrole_mapid) as id
where id not in (select a.entity_role_map_id from labstrd.labstrd_entity_role_map a
join labstrd.labstrd_entity_master b on a.entity_master_id=b.entity_master_id
where entity_role_id=10)) into  v_entityrole_mapid 
;

select count(distinct entity_id)
     into   v_ent_count1
     from   unnest(v_entityrole_mapid)entity_id;
     

select array_to_json(array_agg(a)) from (
select distinct entity_name,a.entity_role_map_id,count(1) from labstrd.labstrd_entity_role_map a
join labstrd.labstrd_asset_entity_map c on c.entity_role_map_id=a.entity_role_map_id
join labstrd.labstrd_entity_master b on a.entity_master_id=b.entity_master_id
where entity_role_id=10
and    exists (select 1 from   labstrd.labstrd_asset_entity_map eam
                                         where  eam.asset_id= c.asset_id
                                         and    eam.asset_type_id = c.asset_type_id 
                                         and    eam.entity_role_map_id in 
                                          (select any_entity_role_mapid 
                                          from unnest(v_entityrole_mapid) u(any_entity_role_mapid))
                                          having count(1) =v_ent_count1
                                         )
group by entity_name,a.entity_role_map_id order by 1
) a
 into  v_season_json;
  --execute v_str
   
 --  using 10,p_any_entityrole_mapid,v_ent_count;
  
-- raise notice '% json',v_season_json;
 p_assetjson:= jsonb_set(p_assetjson,'{sesoan}', coalesce(v_season_json::jsonb,'[]'), true);
 
select  entity_name into v_ent_name from (
select entity_name
from labstrd.labstrd_entity_role_map a
-- join labstrd.labstrd_asset_entity_map c on c.entity_role_map_id=a.entity_role_map_id
join labstrd.labstrd_entity_master b on a.entity_master_id=b.entity_master_id
join labstrd.labstrd_entity_role c on a.entity_role_id=c.entity_role_id
where entity_role_map_id = any (p_entityrole_mapid) 
and c.entity_role_id=1
)aa
;

if v_ent_name='News' then 
v_role_id:=14;
ELSIF  v_ent_name='Photos' then 
v_role_id:=15;
ELSIF  v_ent_name='Videos' then 
v_role_id:=16;
end if ;
 -- raise notice '% json',p_assetjson;

select array_to_json(array_agg(a)) from (
select distinct entity_name,a.entity_role_map_id,count(1) from labstrd.labstrd_entity_role_map a
join labstrd.labstrd_asset_entity_map c on c.entity_role_map_id=a.entity_role_map_id
join labstrd.labstrd_entity_master b on a.entity_master_id=b.entity_master_id
where entity_role_id=v_role_id
and    exists (select 1 from   labstrd.labstrd_asset_entity_map eam
                                         where  eam.asset_id= c.asset_id
                                         and    eam.asset_type_id = c.asset_type_id 
                                         and    eam.entity_role_map_id in 
                                          (select any_entity_role_mapid 
                                          from unnest(p_entityrole_mapid) u(any_entity_role_mapid))
                                          having count(1) =v_ent_count
                                         )
group by entity_name,a.entity_role_map_id order by 1
) a
 into  v_cat_json;
 p_assetjson:= jsonb_set(p_assetjson,'{sub_Category}', coalesce(v_cat_json::jsonb,'[]'), true);

-- raise notice '% json',p_assetjson;
exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
 
end;

$_$;


--
