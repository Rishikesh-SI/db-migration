-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_get_press_realease_listing_r(numeric, numeric, numeric, numeric[], numeric[], character varying, numeric[])
-- Type: FUNCTION

-- Name: labwpl_get_press_realease_listing_r(numeric, numeric, numeric, numeric[], numeric[], character varying, numeric[]); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl.labwpl_get_press_realease_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_searchkeyword character varying, p_exclude_ent_id numeric[], OUT p_result numeric, OUT p_press_release_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare
    v_createdbyquery varchar(50) := ' ';
	p_asset_type_id numeric :=20;
    
    v_searchkeyword varchar(4000) := p_searchkeyword;
    v_entitysearchquery varchar(4000) := ' ';
     
    v_searchdraftquery varchar(200) := ' ';
    v_searchassetquery varchar(200) := ' ';
    v_sysdate timestamp;
    
    v_anyentityrolemapidquery varchar(4000) := ' ';
	v_excentityrolemapidquery varchar(4000):=' ';
    v_any_ent_count numeric;
	v_exc_ent_count numeric;
    
   
	v_pagination jsonb;
	v_limit smallint := case p_pagenumber when 1 then p_page1_size else p_itemnumber end;
	v_offset smallint := case p_pagenumber when 1 then 0 else (p_page1_size + (((p_pagenumber - 1) * p_itemnumber) - p_itemnumber)) end;
	v_press_release_id_arr numeric[];
	p_assetcount numeric;
	
begin

select array_length(p_any_entityrole_mapid,1) into v_any_ent_count;
select array_length(p_exclude_ent_id,1) into v_exc_ent_count;

     v_sysdate:= current_timestamp at time zone 'utc';
     
	
    
    if v_searchkeyword is not null then
     	
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
     
    if v_any_ent_count > 0 then
    	
     v_anyentityrolemapidquery := ' and tagged_entity && $4';
     
    end if;
	
	if v_exc_ent_count > 0 then 
	
	v_excentityrolemapidquery := ' and not tagged_entity && $3';
	
	end if;
	
	
	execute 'select array(select press_release_id
                 from
                 (
                     select press_release_id
                     from labwpl.labwpl_press_release_master
                     where status = 1 and is_trashed = 0
					 '||v_excentityrolemapidquery||' '
					  ||v_anyentityrolemapidquery||  ' '
					  ||v_entitysearchquery|| '
	                  and tagged_entity @> $2
					  order by published_date desc
	                  limit $5
	                  offset $6
                 )a)'
	into v_press_release_id_arr
	using  p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset;
	
	raise notice '% p_entityrole_mapid=',p_entityrole_mapid;
	raise notice '% v_limit=',v_limit;
	raise notice '% v_offset=',v_offset;
	
	execute 'select (''{"items":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
	from(
        select prmaster.title,prmaster.zip_id,prmaster.zip_name,
        		prmaster.zip_path,prmaster.zip_size,prmaster.published_date,
         prmaster.updated_date,prmaster.guid,
        		prmaster.press_release_json->''data''->''image'' image,
        		(
                select array_to_json(array_agg(a))
                    from(select prmap.press_release_id,prmap.title,prmap.short_title,prmap.description,prmap.lang_id,prmap.lang_name,
					prmap.lang_id,prmap.lang_name,prmap.attachments
                         from labwpl.labwpl_press_release_map prmap
                         where prmap.press_release_id = prmaster.press_release_id
						 and is_active=1 and is_published=1
						 )a)attachment
        from labwpl.labwpl_press_release_master prmaster
        where  prmaster.press_release_id in(select press_release_id from 
                                         unnest($1) u(press_release_id))
										 and status = 1 and is_trashed = 0
         order by prmaster.published_date desc
    )row'
    into p_press_release_json
	using v_press_release_id_arr;
	
	raise notice '% v_press_release_id_arr=',v_press_release_id_arr;
	
	execute 'select count(1)
                     from labwpl.labwpl_press_release_master
                     where status = 1 and is_trashed = 0
					 '||v_excentityrolemapidquery||' '
					  ||v_anyentityrolemapidquery||  ' '
					  ||v_entitysearchquery|| '
	                  and tagged_entity @> $2
					  
                 
              '
	into p_assetcount
	using  p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset;
	
	    
		 
 if p_press_release_json is null then 
 p_press_release_json:='{"items":null}';

 end if;
 
 v_pagination:='{"total":'||p_assetcount||',
 				 "current_page":'||coalesce(p_pagenumber,0)||'	
				 }';

  p_press_release_json:=	jsonb_set(p_press_release_json,'{pagination}',v_pagination,true);
  p_result:=1;
 

end;
$_$;


--
