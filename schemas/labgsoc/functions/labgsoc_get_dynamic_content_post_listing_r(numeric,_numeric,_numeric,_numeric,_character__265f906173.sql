-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_get_dynamic_content_post_listing_r(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric)
-- Type: FUNCTION

-- Name: labgsoc_get_dynamic_content_post_listing_r(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_get_dynamic_content_post_listing_r(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, p_createdby numeric, p_content_type_id numeric, OUT p_dynamiccount numeric, OUT p_dynamicjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
declare
    p_schema_prefix text :='labgsoc';
	/*
	p_status numeric:=1;
	p_authorid numeric:=null;
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=10;
	p_searchkeyword character varying :='sa';
	p_entityrolemapid numeric[]:=array[7925];
	p_from_date timestamp without time zone:=null;
	p_to_date timestamp without time zone:=null;
	p_createdby numeric:=null;
	p_content_source_id numeric :=null;
    p_dynamicjson jsonb;
    p_dynamiccount numeric;
	*/
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_column_name text;
	v_authorquery text := ' ';
	v_draftcreatedbyquery text := ' ';
    v_articlecreatedbyquery text := ' ';
	v_searchdraftquery text := ' ';
    v_searchdynamicquery text := ' ';
	v_fromtodatequery text:= ' ';
	v_contentsourcequery text := ' ';
	v_entitycount numeric;
	v_assetidarr numeric[];
	v_assetfilterquery text := ' ';
	v_searchkeyword text := upper(p_searchkeyword);
	v_dynamic_json json;
	v_sorting_column text;
	v_assets_json json;
	v_fromtodatedraftquery text :=' ';
    v_arraycontenttype numeric[];
    v_content_type_id text := ' ';
	
begin
        v_arraycontenttype:= array_append(v_arraycontenttype,p_content_type_id);
        
		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    	v_torownumber   := (p_pagenumber * p_itemnumber);
		        raise notice'v_arraycontenttype:%',v_arraycontenttype;
                
        if p_content_type_id is null then

		select array_agg(asset_type_id)     
        from labgsoc.labgsoc_asset_type where is_content_type=1
        into v_arraycontenttype;
        raise notice'v_arraycontenttype2:%',v_arraycontenttype;
        end if;
	 
		select count(1) into v_entitycount from (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
		
		if p_authorid is not null then 
		  if p_status=0 then 
		   v_column_name := 'asd.asset_id';
		  else
		 v_column_name := ' dc.dynamic_content_type_data_id';
		 end if;
		  v_authorquery := ' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_author_action aa
											where aa.asset_id = '||v_column_name||' and aa.action_id = 4 
											and aa.asset_type_id in (select * from unnest($9) as asset_type_id)  
                                            and aa.author_id = $2) '; 
			
		end if;
        
        
		
		  if p_createdby is not null then
			 v_draftcreatedbyquery := ' and (asd.asset_data->''data''->>''created_by'')::numeric = $3';
     		 v_articlecreatedbyquery := ' and dc.created_by = $3';
  		  end if;
		
		if v_searchkeyword is not null then
		 v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
			--- v_searchdraftquery := ' and upper(ad.asset_data->''data''->>''title'') like ''%'||v_searchkeyword||'%'' ';
			
          -- v_searchdynamicquery :=   ' and upper(ad.title) like ''%'||v_searchkeyword||'%'' ';
		    v_searchdraftquery := '  and to_tsvector(ad.asset_data->''data''->>''title'') @@@ to_tsquery('''||v_searchkeyword||''')';
			  
			
			 v_searchdynamicquery:= ' and to_tsvector(dc.title) @@@ to_tsquery(quote_literal('''||v_searchkeyword||'''))';
		end if;
      
		
		  --raise notice '% search',v_searchdynamicquery;
		
		if v_entitycount >0 then 
		
		if p_status = 0 then
				
				execute 'with entitydata(t_json)
							as (select (asset_data->''data''->>''entitydata'')::json, asset_draft_id
								from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
								where asset_type_id in (select * from unnest($9) as asset_type_id
								and version_number = (select max(version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft adi
														where adi.asset_id = ad.asset_id and adi.asset_type_id = ad.asset_type_id)
								and (asset_data->''data''->>''entitydata'') is not null
								order by ad.updated_date desc)
							select array(select asset_draft_id
							from(select obj->>''entity_role_map_id'', asset_draft_id
									from entitydata ci, json_array_elements(ci.t_json#>''{}'') obj
									where (obj->>''entity_role_map_id'')::numeric in 
									(select entityid from unnest($2) u(entityid)))jd
							group by asset_draft_id
							having count(1) = $3)'
				into v_assetidarr
				using p_schema_prefix, p_entityrolemapid, v_entitycount;
				
				v_assetfilterquery := ' and ad.asset_draft_id in(select asset_draft_id from unnest($8) u(asset_draft_id))';
				else 
		  v_assetfilterquery:=' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map eam
													where eam.asset_id = dc.dynamic_content_type_data_id
													and eam.asset_type_id in (select * from unnest($9) as asset_type_id)
													and eam.entity_role_map_id in (select entityid from unnest($1) u(entityid))
													group by eam.asset_id
													having count(1) = $8)';
													
													end if;
		end if;										
		
		
		
		if p_from_date is not null and p_to_date is not null then
			--if p_status = 1 then
			--	v_column_name := 'ad.published_date';
			--else
			--	v_column_name := 'ad.updated_date';
			--end if;
			v_fromtodatequery := ' and ad.published_date between $4 and $5 ';
			
			v_fromtodatedraftquery := ' and ad.updated_date between $4 and $5 ';
		end if;
	
		--raise notice '% check count',v_fromtodatequery;
	
	if p_status in(1, 2) then 
	  
	  
	  
     	raise notice 'v_fromrownumber:%',v_fromrownumber;
     raise notice 'v_torownumber:%',v_torownumber;
     
     execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
	  SELECT * FROM (
	  select count(1) over() as cnt,*  from (														
	  select 
	  dc.dynamic_content_type_data_id,
	  dc.title,
	  dc.title_alias,
	  dc.created_date,
	  dc.updated_date,
	  dc.published_date ,
	  dc.created_by as created_by,
	  dc.updated_by as edited_by,
	  a.display_name created_by_name,
	  b.display_name edited_by_name,
	  dc.published_version_number as version_number,
	  dc.ct_guid as guid,
      asd.asset_type_id as asset_type_id,
	  row_number() over(order by case '||p_status||' when 1 then dc.published_date else dc.updated_date end desc) slno
	  from '||p_schema_prefix||'.'||p_schema_prefix||'_dynamic_content_type_data	dc
	  join '||p_schema_prefix||'.'||p_schema_prefix||'_user a on dc.created_by=a.user_id
	  join '||p_schema_prefix||'.'||p_schema_prefix||'_user b on dc.updated_by=b.user_id
      join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft asd on asd.asset_id=dc.dynamic_content_type_data_id
	  where dc.is_published= case '||p_status||' when 1 then 1 else 0 end 
	  and dc.is_trashed = case '||p_status||' when 1 then 0 else 1 end
	  and asd.asset_type_id in (select * from unnest($9) as asset_type_id)
	  and asd.version_number in (select max(version_number) 
								from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft asd
								where asd.asset_id=dc.dynamic_content_type_data_id
								and asd.asset_type_id in (select * from unnest($9) as asset_type_id))
	  '
	   ||v_searchdynamicquery
	   ||v_fromtodatequery
       ||v_articlecreatedbyquery
       ||v_authorquery
       ||v_assetfilterquery
	   ||'
	  )tab
	  order by published_date desc
	  )TAB2
	  where slno between $6 and $7
      )TAB3
	  group by cnt
	  '
	  
	  into p_dynamiccount,p_dynamicjson 
	  using p_entityrolemapid ,p_authorid,p_createdby,p_from_date,p_to_date,v_fromrownumber,v_torownumber,v_entitycount,v_arraycontenttype;
      
      raise notice'p_authorid:%',p_authorid;
     
     
     
     
     
     
	 else 
	 
	    
	   
	  
	  execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
	    SELECT * FROM (
         select count(1) over() as cnt,*  from(
         select ad.asset_id article_id,
      (asset_data->''data''->>''title'') title,
	  (asset_data->''data''->>''guid'') article_guid,
	  (asset_data->''data''->>''status'') is_published, 
	  ad.created_date, 
	  ad.created_by as created_by,
	  ad.updated_by as edited_by,
	  ad.updated_date as  modified_date,
	  ad.version_number,
	  ad.asset_type_id as asset_type_id,
	  (asset_data->''data''->>''guid'') as guid,
	 
	 (asset_data->''data''->>''slug_url'') title_alias,
		row_number() over(order by ad.updated_date  desc) slno
		from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
		where  ad.asset_type_id in (select * from unnest($9) as asset_type_id) and
        ad.version_number = (select max(ad1.version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad1
															where ad1.asset_id = ad.asset_id
															and ad1.asset_type_id = ad.asset_type_id)
         and ((exists (select dc.dynamic_content_type_data_id from '||p_schema_prefix||'.'||p_schema_prefix||'_dynamic_content_type_data dc
			  where dc.dynamic_content_type_data_id = ad.asset_id and dc.is_published = 0 and dc.is_trashed = 0 ))
		or (ad.version_number > (select max(dc.published_version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_dynamic_content_type_data dc
								where dc.dynamic_content_type_data_id = ad.asset_id  )))
		'
		||v_searchdraftquery
		||v_assetfilterquery
        ||v_authorquery
        ||v_draftcreatedbyquery
		||'
	)tab
	order by modified_date desc
   )TAB2
 where slno between $6 and $7
)TAB3
group by cnt'
into p_dynamiccount,p_dynamicjson 
using null,p_authorid,p_createdby,p_from_date,p_to_date,v_fromrownumber,v_torownumber,v_assetidarr,v_arraycontenttype
;
 
	end if ; 
	
	
	if p_dynamiccount is null then 
	p_dynamicjson :='{ "items": []}';
	p_dynamiccount:=0;
	end if;
	----raise notice '% check count',p_dynamiccount;
	-- --raise notice '% json ',p_dynamicjson;
end;
$_$;


--
