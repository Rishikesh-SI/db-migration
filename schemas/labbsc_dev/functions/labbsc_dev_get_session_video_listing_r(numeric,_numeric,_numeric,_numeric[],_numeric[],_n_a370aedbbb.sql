-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_session_video_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[], text, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_get_session_video_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[], text, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_session_video_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_exclude_ent_id numeric[], p_user_guid text, p_session_id numeric, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
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
	v_user_id numeric;
	v_sql text;
	v_partner_name text;
	v_code text;
begin
 

     v_sysdate:= current_timestamp at time zone 'utc';
     
	 select count(distinct entity_id)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     select count(1)
     into   v_any_ent_count
     from   unnest(p_any_entityrole_mapid)entity_id;
     
     -- changes done by rakesh b date :-20-04-2017--
     
	 if p_user_guid is not null
	 then
	 begin
	 select user_id,partner_name,university_code 
	 from labbsc_dev.labbsc_dev_web_user
	 where user_guid=p_user_guid
	 into v_user_id,v_partner_name,v_code;
	 exception when no_data_found then
	 v_user_id:=null;
	 end;
	 
	 end if;
     
    -- if p_page1_size is null 
    --- then 
              v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
              v_torownumber   := (p_pagenumber * p_itemnumber);
     /* else 
          if (p_pagenumber=1) then 
          v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          v_fromrownumber := p_page1_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
           end if;
   v_torownumber   := p_page1_size + ( (p_pagenumber-1) * p_itemnumber);*/
---end if;
   
   
    select labbsc_dev.labbsc_dev_get_entity_language_from_entities(p_entityrole_mapid)
    into v_language_id;
    
    
    select  erm.entity_master_id into v_language_mast_id 
    from labbsc_dev.labbsc_dev_entity_role_map erm 
    where erm.entity_role_map_id =(v_language_id);
    
    v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
    
    if v_searchkeyword is not null then
     	
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
     
    if v_any_ent_count > 0 then
    	
     v_anyentityrolemapidquery := ' and    exists (select 1
                                         from   labbsc_dev.labbsc_dev_asset_entity_map eam
                                         where  eam.asset_id= sl.asset_id
                                         and    eam.asset_type_id = sl.asset_type_id 
                                         and    eam.entity_role_map_id in 
                                          (select any_entity_role_mapid 
                                          from unnest($4) u(any_entity_role_mapid))
                                         group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_any_ent_count ||') ';
     
    end if;
	
 
    /* 
	  execute 'select cnt ,''{"items":[''||string_agg(web_listing_json::text,'','')||'']}'' from (select count(1)over() as cnt ,
					row_number()over (order by sl.published_date desc) as rno,
					asset_list_id,web_listing_json,
					case when vd.session_id is not null then 1 else 0 end as is_recommended
    from   labbsc_dev.labbsc_dev_asset_list sl
	left join labbsc_dev.labbsc_dev_session_video_detail vd
	on vd.video_id=sl.asset_id
	and vd.session_id=coalesce($5, vd.session_id)
	and vd.user_id=coalesce($6,vd.user_id)
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (4) 
    and    sl.asset_type_id in 
                    (case when $1 is not null then
                    (select asset_type_id from unnest($1) u(asset_type_id))
                    else sl.asset_type_id
                    end )
    and    exists (select 1
                   from   labbsc_dev.labbsc_dev_asset_entity_map eam
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
    using  p_asset_type_id,v_str_entityrole_mapid ,	p_any_entityrole_mapid ,p_any_entityrole_mapid,p_session_id,v_user_id ;
    */	
	
	---raise notice '%',p_any_entityrole_mapid;
	
    execute 'select cnt ,
	''{"items":[''||string_agg(web_listing_json::text,'','')||'']}''
	from(select  count(1)over() as cnt ,row_number()over (order by published_date desc) as rno,
	   replace(web_listing_json,''"is_recommended": "0"'',''"is_recommended":''||rn.is_recommended||'', "is_purchased":''||rn.is_purchased) ::jsonb as web_listing_json
	from(select distinct 
					sl.published_date,
					sl.asset_list_id,
					 web_listing_json::text,
					 case when $5 is null and vd.user_id=$6 then 1
					when $5 is not null and vd.session_id=$5 then 1
					else 0 end as is_recommended,
				 case when c.status=2 then 1 else 0 end as is_purchased,
				 coalesce($7,'''') as partner_name,
				 coalesce($8,'''') as code
	   from   labbsc_dev.labbsc_dev_asset_list sl
	left join labbsc_dev.labbsc_dev_session_video_detail vd
	on vd.video_id=sl.asset_id
	and vd.session_id=coalesce($5, vd.session_id)
	and vd.user_id=coalesce($6,vd.user_id)
	left join labbsc_dev.labbsc_dev_cart c
	on c.video_id=sl.asset_id
	and coalesce(c.user_id,1)=coalesce($6,0)
	and c.status=2
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (4) 
	 and    exists (select 1
                   from   labbsc_dev.labbsc_dev_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id =any ($2::numeric[])
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_ent_count ||')
    '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery||              
                   ') as rn
				   order by is_recommended desc
    )tab
	where rno between '||v_fromrownumber||' and '||v_torownumber||'
                        group by cnt
    '
    into   p_assetcount,p_assetjson
    using  p_asset_type_id,v_str_entityrole_mapid ,	p_any_entityrole_mapid ,p_any_entityrole_mapid,p_session_id,v_user_id,v_partner_name,v_code ;
    		
	---	*/	
			
		
/*
exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
 
end;
$_$;


--
