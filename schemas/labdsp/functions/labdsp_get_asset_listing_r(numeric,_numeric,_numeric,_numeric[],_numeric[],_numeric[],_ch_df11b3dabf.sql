-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[])
-- Type: FUNCTION

-- Name: labdsp_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[]); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_get_asset_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_exclude_ent_id numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$
 

declare
	/*
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=10;
	p_page1_size numeric:=10;
	p_entityrole_mapid numeric[]:=array[1,4];
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
    v_language_id numeric;
    v_language_mast_id numeric;
    
    v_anyentityrolemapidquery varchar(4000) := ' ';
    v_any_ent_count numeric;
    
    v_arr_asset_list_id numeric[];
    v_str_arr_asset_list_id varchar(1000000);
    
    v_str_entityrole_mapid varchar(1000000);
    v_allentityjson jsonb ; 
	v_season_json jsonb;
	
	v_entity_master_id numeric;
    v_ent_role_map_id numeric[];
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
    /*pagination logic */
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
   
   
    select labdsp.labdsp_get_entity_language_from_entities(p_entityrole_mapid)
    into v_language_id;
																					 
    select  erm.entity_master_id into v_language_mast_id 
    from labdsp.labdsp_entity_role_map erm 
    where erm.entity_role_map_id =(v_language_id);
	
	select a.entity_master_id into v_entity_master_id
	from labdsp.labdsp_entity_master a
	join labdsp.labdsp_entity_role_map b on a.entity_master_id=b.entity_master_id
	join labdsp.labdsp_entity_category c on c.entity_role_id=b.entity_role_id
	where c.category_name='All Sports'
	and b.entity_role_map_id in (select ent_id from unnest(p_entityrole_mapid) as ent_id);
	
	select array(select entity_role_map_id from  labdsp.labdsp_entity_master a
	join labdsp.labdsp_entity_role_map b on a.entity_master_id=b.entity_master_id
	where a.parent_entity_id=v_entity_master_id order by comp_type asc ) into v_ent_role_map_id;
    
    v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
    
    if v_searchkeyword is not null then
     	
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
     
    if v_any_ent_count > 0 then
    	
     v_anyentityrolemapidquery := ' and    exists (select 1
                                         from   labdsp.labdsp_asset_entity_map eam
                                         where  eam.asset_id= sl.asset_id
                                         and    eam.asset_type_id = sl.asset_type_id 
                                         and    eam.entity_role_map_id in 
                                          (select any_entity_role_mapid 
                                          from unnest($4) u(any_entity_role_mapid))
                                         ) ';
     
    end if;
     if v_entity_master_id is null then 
    execute 'select cnt ,''{"items":[''||string_agg(web_listing_json::text,'','')||'']}'' from (select count(1)over() as cnt ,
					row_number()over (order by sl.published_date desc) as rno,
					asset_list_id,web_listing_json
    from   labdsp.labdsp_asset_list sl
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
                   from   labdsp.labdsp_asset_entity_map eam
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
    else 
	
	
	execute 'select cnt ,''{"items":[''||string_agg(web_listing_json::text,'','')||'']}''
	from (
	select  count(1)over() as cnt,asset_list_id ,web_listing_json,published_date,entity_name from (
select *,
    ROW_NUMBER() OVER (partition by entity_role_map_id 
                      ORDER BY published_date desc)  as rno
from (
    select asset_list_id ,web_listing_json,published_date,
    (jsonb_array_elements((web_listing_json->>''entity_map'')::jsonb)->>''entity_role_map_id'')::numeric as entity_role_map_id,
    jsonb_array_elements((web_listing_json->>''entity_map'')::jsonb)->>''entity_type_name'' as entity_type_name   
    from   labdsp.labdsp_asset_list sl
	where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
     and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (1,2,4,5) 
    and   sl.language_entity_role_map_id is not null
    and    sl.asset_type_id in 
                    (case when $1 is not null then
                    (select asset_type_id from unnest($1) u(asset_type_id))
                    else sl.asset_type_id
                    end )  
	
  )tab
    where
	entity_role_map_id::numeric =any($5)
   )row 
    left join labdsp.labdsp_entity_role_map a on a.entity_role_map_id=row.entity_role_map_id
    left join labdsp.labdsp_entity_master b on a.entity_master_id=b.entity_master_id
   where rno <=3
	order by comp_type asc ,rno
    ) tab
	group by cnt'
	into   p_assetcount,p_assetjson
    using  p_asset_type_id,v_str_entityrole_mapid ,	p_any_entityrole_mapid ,p_any_entityrole_mapid ,v_ent_role_map_id;
	end if ;
		
		
	
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
  */
end;

 

$_$;


--
