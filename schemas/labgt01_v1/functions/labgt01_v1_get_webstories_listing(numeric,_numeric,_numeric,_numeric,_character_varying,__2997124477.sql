-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_webstories_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric)
-- Type: FUNCTION

-- Name: labgt01_v1_get_webstories_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_webstories_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, p_createdby numeric, p_content_source_id numeric, OUT p_webstorycount numeric, OUT p_webstoryjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$
declare
 /* --  p_schema_prefix text :='labgt01_v1';
	p_status numeric:=1;
	p_authorid numeric:=null;
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=10;
	p_searchkeyword character varying :=null;
	p_entityrolemapid numeric[]:=array[5];
	p_from_date timestamp without time zone:=null;
	p_to_date timestamp without time zone:=null;
	p_createdby numeric:=null;
	p_content_source_id numeric :=null;
    p_webstoryjson jsonb;
    p_webstorycount numeric;
	*/
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_column_name text;
	v_authorquery text := ' ';
	v_draftcreatedbyquery text := ' ';
    v_albumcreatedbyquery text := ' ';
	v_searchdraftquery text := ' ';
    v_searchalbumquery text := ' ';
	v_fromtodatequery text:= ' ';
	v_contentsourcequery text := ' ';
	v_entitycount numeric;
	v_assetidarr numeric[];
	v_assetfilterquery text := ' ';
	v_searchkeyword text := upper(p_searchkeyword);
	v_album_json json;
	v_sorting_column text;
	v_assets_json json;
	v_fromtodatedraftquery text :=' ';
	v_error_check text ;
	err_msg text;
	p_schema_prefix text:='labgt01_v1';
	v_entityfilterquery text:= ' ';
begin

		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    	v_torownumber   := (p_pagenumber * p_itemnumber);
		
		
	 
		select count(1) into v_entitycount
		from (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
		--raise notice 'v_entitycount %',v_entitycount;
		if p_authorid is not null then 
		  if p_status=0 then 
		   v_column_name := 'ad.asset_id';
		  else
		 v_column_name := ' ad.webstory_id';
		 end if;
		  v_authorquery := ' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_author_action aa
											where aa.asset_id = '||v_column_name||' and aa.action_id = 4 
											and aa.asset_type_id = 2 and aa.author_id = $2) ';
			
		end if;
		
		  if p_createdby is not null then
			 v_draftcreatedbyquery := ' and (ad.asset_data->''data''->>''created_by'')::numeric = $3';
     		 v_albumcreatedbyquery := ' and ad.created_by = $3';
  		  end if;

	if v_searchkeyword = '' then
			v_searchkeyword:= null;
		end if;

		if v_searchkeyword is not null then
		 v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
			--- v_searchdraftquery := ' and upper(ad.asset_data->''data''->>''title'') like ''%'||v_searchkeyword||'%'' ';
			
          -- v_searchalbumquery :=   ' and upper(ad.title) like ''%'||v_searchkeyword||'%'' ';
		    v_searchdraftquery := '  and to_tsvector(ad.asset_data->''data''->>''title'') @@@ to_tsquery('''||v_searchkeyword||''')';
			  
			
			 v_searchalbumquery:= ' and to_tsvector(ad.title) @@@ to_tsquery(quote_literal('''||v_searchkeyword||'''))';
		end if;
		
		 -- raise notice '% search',v_searchalbumquery;
		
		if p_entityrolemapid is not null then
		
			v_entityfilterquery:= 'and al.tagged_entity @> $1';
			
		end if;
		if v_entitycount >0 then 
		
		if p_status = 0 then
				
				execute 'with entitydata(t_json)
							as (select (asset_data->''data''->>''entitydata'')::json, asset_draft_id
								from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
								where asset_type_id = 142
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
													where eam.asset_id = ad.webstory_id
													and eam.asset_type_id = 2
													and eam.entity_role_map_id in (select entityid from unnest($1) u(entityid))
													group by eam.asset_id
													having count(1) = $8)';
				
			  --raise notice '% search',v_assetfilterquery;	
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
		
	--	raise notice '% check count',v_fromtodatequery;
	
	if p_status in(1, 2) then 
	  
	  
	  execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
	  SELECT * FROM (
	  select count(1) over() as cnt,tab.webstory_id,tab.title,tab.is_published,tab.is_trashed,tab.published_date,tab.title_alias,tab.slno,tab.webstory_guid,tab.created_by,tab.edited_by,tab.created_by_name,tab.edited_by_name,tab.guid,tab.version_number,count(wam.webstory_asset_map_id)  as total_assets from (														
	  select 
	  ad.webstory_id,
	  ad.title,
	  ad.is_published,
	  ad.is_trashed,
	  ad.published_date,
	  ad.title_alias ,
	  ad.webstory_guid,
	  ad.created_by as created_by,
	  ad.updated_by as edited_by,
	  a.display_name created_by_name,
	  a.display_name edited_by_name,
	  ad.webstory_guid as guid,
	  --jsonb_array_elements(al.web_detail_jsn->''data''->''slides'') as total_assets,
	  ad.published_version_number as version_number,
	  row_number() over(order by case '||p_status||' when 1 then ad.published_date else ad.updated_date end desc) as slno
	  --jsonb_array_elements(al.web_detail_jsn->''data''->''slides'') as slides
	  from '||p_schema_prefix||'.'||p_schema_prefix||'_webstory ad
	  join '||p_schema_prefix||'.'||p_schema_prefix||'_user a on ad.created_by=a.user_id --and ad.updated_by=a.user_id
	  join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al on al.asset_id=ad.webstory_id and asset_type_id=142 
	  where ad.is_published= case '||p_status||' when 1 then 1 else 0 end
	  and ad.is_trashed = case '||p_status||' when 1 then 0 else 1 end
	  '||v_authorquery
	   ||v_searchalbumquery
	  -- ||v_assetfilterquery
	   ||v_fromtodatequery
	   ||v_albumcreatedbyquery
	   ||'
	   ) as tab
	  join '||p_schema_prefix||'.'||p_schema_prefix||'_webstory_asset_map wam on wam.webstory_id=tab.webstory_id
	  where wam.is_active=1 and wam.is_published=0  and wam.webstory_slide_id is not null
	  group by tab.webstory_id,tab.title,tab.is_published,tab.is_trashed,tab.published_date,tab.title_alias,tab.webstory_guid,
	  tab.created_by,tab.edited_by,tab.created_by_name,tab.edited_by_name,tab.guid,tab.version_number,tab.slno
	  order by published_date desc
	  )TAB2
	  where slno between $6 and $7
      )TAB3
	  group by cnt
	  '
	  
	  into p_webstorycount,p_webstoryjson 
	  using p_entityrolemapid ,p_authorid,p_createdby,p_from_date,p_to_date,v_fromrownumber,v_torownumber,v_entitycount;
     
	 else 
	 
	    raise notice '% check array ',p_schema_prefix;
	   
	  
	 execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
	    SELECT * FROM (
         select count(1) over() as cnt,*  from (
         select ad.asset_id webstory_id,
      (asset_data->''data''->>''title'') title,
	  (asset_data->''data''->>''guid'') webstory_guid,
	  (asset_data->''data''->>''status'') is_published, 
	  ad.created_date, 
	  ad.updated_date modified_date,
	  ad.version_number,
	  ad.updated_by as uploaded_by,
	 (select display_name from '||p_schema_prefix||'.'||p_schema_prefix||'_user 
	 where user_id=ad.updated_by) as created_by_name,
	 (asset_data->''data''->>''slug_url'') title_alias,
	 (asset_data->''data''->>''guid'') guid,
	 (asset_data->''data''->>''total_assets'') total_assets,
		row_number() over(order by ad.updated_date  desc) slno
		from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
		where ad.asset_type_id = 142
		and ad.version_number = (select max(ad1.version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad1
															where ad1.asset_id = ad.asset_id
															and ad1.asset_type_id = ad.asset_type_id)
         and ((exists (select a.webstory_id from '||p_schema_prefix||'.'||p_schema_prefix||'_webstory a
			  where a.webstory_id = ad.asset_id and a.is_published = 0 and a.is_trashed = 0 ))
		or (ad.version_number > (select max(a.published_version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_webstory a
								where a.webstory_id = ad.asset_id  )))
		'
		||v_authorquery
		||v_draftcreatedbyquery
		||v_searchdraftquery
		||v_fromtodatedraftquery
		||v_assetfilterquery
		||'
	)tab
	order by modified_date desc
   )TAB2
 where slno between $6 and $7
)TAB3
group by cnt'
into p_webstorycount,p_webstoryjson 
using null,p_authorid,p_createdby,p_from_date,p_to_date,v_fromrownumber,v_torownumber,v_assetidarr
;
 
	end if ; 
	
	
	if p_webstorycount is null then 
	p_webstorycount:=0;
	p_webstoryjson :='{"items":"[]"}';
	end if;
	--raise notice '% check count',p_webstorycount;
	-- raise notice '% json ',p_webstoryjson;
	
exception 
    when others then
	    --err_code := SQLSTATE;
		 get stacked diagnostics 
		 v_error_check =pg_exception_context;
         err_msg := SQLERRM;
		  p_webstorycount := -1;
		  p_webstoryjson := '{"Error_message" :"'||coalesce(err_msg||'-'||v_error_check, '')||'"}';	
	
end;

$_$;


--
