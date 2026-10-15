-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_get_download_listing_r(numeric, numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: labmsg_get_download_listing_r(numeric, numeric, numeric, numeric[]); Type: FUNCTION; Schema: labmsg; Owner: -
--

CREATE FUNCTION labmsg.labmsg_get_download_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page_size numeric, p_entityrole_mapid numeric[], OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

--do
--$$
declare
/*
p_pagenumber numeric :=1;
	p_itemnumber numeric:=10;
	p_page_size numeric:=10;
	p_entityrole_mapid numeric[]:= array[932,936,4];
p_assetjson jsonb ;
	*/    
	v_json text := '{"items":[';

  	  	v_asset_type_id numeric:=27;
    	v_sysdate timestamp;
    	v_ent_count numeric;
		v_entityrolemapidquery text=' ';
		v_fromrownumber numeric;
        v_torownumber numeric;
		v_sec_ent_id numeric;
		v_pri_ent_id numeric;
		v_lang_id numeric;
		v_pri_filter_sql text :=' ';
		v_sec_filter_sql text:=' ';
begin

/*-- new changes Done By Rakesh Bhatkar
 add username and full_name
 Date :-15112017 
-- End--
*/
    v_sysdate:= current_timestamp at time zone 'utc';

	select count(distinct entity_id)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;

     raise notice '%',p_entityrole_mapid;
	 
	 select entity_role_map_id into v_pri_ent_id
	 from labmsg.labmsg_entity_category a
	 join labmsg.labmsg_entity_role_map b on a.entity_role_id=b.entity_role_id
	 where category_name='Social'
	 and entity_role_map_id in (SELECT any_entity_role_mapid 
                                          FROM UNNEST(p_entityrole_mapid) U(any_entity_role_mapid))
                                          ;
	 
	---   raise notice '%',v_pri_ent_id;
	  
	  
	 select entity_role_map_id into v_sec_ent_id
	 from labmsg.labmsg_entity_category a
	 join labmsg.labmsg_entity_role_map b on a.entity_role_id=b.entity_role_id
	 where category_name='Tags'
	 and entity_role_map_id in (SELECT any_entity_role_mapid 
                                          FROM UNNEST(p_entityrole_mapid) U(any_entity_role_mapid))
                                          ;
	select entity_role_map_id into v_lang_id
	 from labmsg.labmsg_entity_category a
	 join labmsg.labmsg_entity_role_map b on a.entity_role_id=b.entity_role_id
	 where category_name='Language'
	 and entity_role_map_id in (SELECT any_entity_role_mapid 
                                          FROM UNNEST(p_entityrole_mapid) U(any_entity_role_mapid))
                                          ;
	 raise notice '%', v_sec_ent_id;
	 
	 if v_pri_ent_id is not null then 
	 v_pri_filter_sql := 'and c.primary_ent_id in ($4)';
	 
	 end if ;
	 
	  if v_sec_ent_id is not null then 
	 v_sec_filter_sql := 'and a.secondary_ent_id in ($5)';
	 
	 end if ;
	
     if p_page_size is null 
     then 
              v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
              v_torownumber   := (p_pagenumber * p_itemnumber);
      else 
          if (p_pagenumber=1) then 
          v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          v_fromrownumber := p_page_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
           end if;
   		  v_torownumber   := p_page_size + ( (p_pagenumber-1) * p_itemnumber);
     end if;

	 if v_ent_count > 0 then

     v_entityrolemapidquery := ' and    exists (select 1
                                         from   labmsg.labmsg_asset_entity_map eam
                                         where  eam.asset_id= a.download_map_id
                                         and    eam.asset_type_id = 27
                                         and    eam.entity_role_map_id in 
                                          ($6) 
                                         ) ';

      end if;

	 execute 'select ''{"data":[''||string_agg(row_to_json(tab1)::text,'','')||'']}'' from (
with tab as(
select distinct primary_ent_id ,
primary_ent_name
from labmsg.labmsg_download_map c
where primary_ent_id is not null
'||v_pri_filter_sql||'
group by c.primary_ent_id,c.primary_ent_name
)
select 
tab.* ,
(
select array_to_json(array_agg(tab2)) from (
select
cnt,
secondary_ent_name as name,
secondary_ent_id ,
array_to_json(array_agg(row.*))  as items
from 
(
select 
count(1) over(partition by secondary_ent_id) as cnt,
a.download_map_id as download_id,
a.title as download_title,
a.description as download_description,
a.file_id as download_file_id,
a.file_name as download_file_name,
a.file_path as download_file_path,
a.img_height as download_img_height,
a.img_width as download_img_width,
a.file_type as download_file_type,
a.primary_ent_id,
a.secondary_ent_name,
a.secondary_ent_id ,
a.title,  
b.title as asset_title,
b.description as asset_description,
b.image_id as asset_file_id,
b.image_path as asset_file_path,
b.image_name as asset_file_name,
row_number() over (partition by secondary_ent_id order by secondary_ent_id asc) as rn 
from labmsg.labmsg_download_map a
join labmsg.labmsg_download_master b on b.download_master_id=a.download_id
where primary_ent_id=tab.primary_ent_id
and b.is_published=1
and b.is_trashed=0
and b.is_deleted=0
and b.is_active=1
and a.is_active=1
'|| v_sec_filter_sql
	||v_entityrolemapidquery||'
)row
where rn between $2 and $3
group by secondary_ent_name,secondary_ent_id,cnt
)tab2
) as items

from tab
) tab1'
 into p_assetjson
using p_entityrole_mapid,v_fromrownumber,v_torownumber,v_pri_ent_id,v_sec_ent_id,v_lang_id
;

	raise notice '% json ',p_assetjson;
end;
--$$;

$_$;


--
