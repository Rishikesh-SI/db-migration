-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_get_audio_listing_r(text, numeric, numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: labstmp_get_audio_listing_r(text, numeric, numeric, numeric, numeric[]); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_get_audio_listing_r(p_alias text, p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$
declare 
/*p_alias text :='testing-stumped-1';
p_pagenumber numeric:=1;
p_itemnumber numeric:=10;
p_page1_size numeric:=10;
p_entityrole_mapid numeric[]:=array[4,7];
p_assetcount numeric;
p_assetjson jsonb;
----------
*/
v_sysdate timestamp;
v_ent_count numeric;
v_str_entityrole_mapid varchar(1000000);
v_fromrownumber numeric;
v_torownumber numeric;
v_str text :=' ';
begin 

 v_sysdate:= current_timestamp at time zone 'utc';
     
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

v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
     
	 select count(distinct entity_id)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
	 
	 if p_alias is not null then 
	 
	 v_str='and   sl.title_alias !=$3';
	 end if;
	 

execute 'select cnt ,''{"items":[''||string_agg(web_listing_json::text,'','')||'']}''
         from (	select count(1)over() as cnt ,tab.title_alias,
		 row_number()over (order by case when tab.title_alias=$3 then 0 else 1 end ,
						tab.published_date desc) as rno,
		 tab.asset_list_id,tab.web_listing_json,asset_type_id
		from (
	select asset_list_id,title_alias,asset_id,asset_type_id,web_listing_json,published_date
	from   labstmp.labstmp_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
	and    sl.asset_type_id in (29)
	'||v_str||'
	union all
	select asset_list_id,title_alias,asset_id,asset_type_id,web_listing_json,published_date
	from   labstmp.labstmp_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
	and  title_alias=$3
	and    sl.asset_type_id in (29)
    )tab
    where    exists (select 1
                   from   labstmp.labstmp_asset_entity_map eam
                   where  eam.asset_id= tab.asset_id
                   and    eam.asset_type_id = tab.asset_type_id 
                   and    eam.entity_role_map_id =any ($2::numeric[])
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_ent_count ||')
						
   )row
	where rno between '||v_fromrownumber||' and '||v_torownumber||'
                        group by cnt'
    into   p_assetcount,p_assetjson
    using  null,v_str_entityrole_mapid ,p_alias ;
   
-- raise notice '% check ',p_assetjson;

end;

$_$;


--
