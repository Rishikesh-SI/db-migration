-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_get_video_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric)
-- Type: FUNCTION

-- Name: labgfg_get_video_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric); Type: FUNCTION; Schema: labgfg; Owner: -
--

CREATE FUNCTION labgfg.labgfg_get_video_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, p_createdby numeric, p_content_source_id numeric, OUT p_videocount numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--********************************PREFACE BLOCK*******************************
--  NAME: _get_video_listing
--
--  Purpose: CMS
--
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified by:   Date:           Reason:
--  R. BHATKAR             09/01/2018      MODIFY (p_content_source_id parameter added)
--********************************END PREFACE BLOCK***************************
--do
--$$
declare
    p_schema_prefix text :='labgfg';
	/*p_status numeric:=0;
	p_authorid numeric:=null;
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=10;
	p_searchkeyword character varying :=NULL;
	p_entityrolemapid numeric[]:=array[7926];
	p_from_date timestamp without time zone:=null;
	p_to_date timestamp without time zone:=null;
	p_createdby numeric:=null;
	p_content_source_id numeric :=null;
    p_videojson jsonb;
    p_videocount numeric;
	*/
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_column_name text;
	v_authorquery text := ' ';
	v_draftcreatedbyquery text := ' ';
    v_videocreatedbyquery text := ' ';
	v_searchdraftquery text := ' ';
    v_searchvideoquery text := ' ';
	v_fromtodatequery text:= ' ';
	v_contentsourcequery text := ' ';
	v_entitycount numeric;
	v_assetidarr numeric[];
	v_assetfilterquery text := ' ';
	v_searchkeyword text := upper(p_searchkeyword);
	v_video_json json;
	v_sorting_column text;
	v_assets_json json;
	v_fromtodatedraftquery text :=' ';
	
begin

		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    	v_torownumber   := (p_pagenumber * p_itemnumber);
		
		
	 
		select count(1) into v_entitycount 
		from (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
		
		if p_authorid is not null then 
		  if p_status=0 then 
		   v_column_name := 'ad.asset_id';
		  else
		 v_column_name := ' ad.video_id';
		 end if;
		  v_authorquery := ' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_author_action aa
											where aa.asset_id = '||v_column_name||' and aa.action_id = 4 
											and aa.asset_type_id = 4 and aa.author_id = $2) ';
			
		end if;
		
		  if p_createdby is not null then
			 v_draftcreatedbyquery := ' and (ad.asset_data->''data''->>''created_by'')::numeric = $3';
     		 v_videocreatedbyquery := ' and ad.created_by = $3';
  		  end if;
		
		if v_searchkeyword is not null then
		 v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
			--- v_searchdraftquery := ' and upper(ad.asset_data->''data''->>''title'') like ''%'||v_searchkeyword||'%'' ';
			
          -- v_searchvideoquery :=   ' and upper(ad.title) like ''%'||v_searchkeyword||'%'' ';
		    v_searchdraftquery := '  and to_tsvector(ad.asset_data->''data''->>''title'') @@@ to_tsquery('''||v_searchkeyword||''')';
			  
			
			 v_searchvideoquery:= ' and to_tsvector(ad.title) @@@ to_tsquery(quote_literal('''||v_searchkeyword||'''))';
		end if;
		
		  raise notice '% search',v_searchvideoquery;
		
		if v_entitycount >0 then 
		
		if p_status = 0 then
				
				execute 'with entitydata(t_json)
							as (select (asset_data->''data''->>''entitydata'')::json, asset_draft_id
								from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
								where asset_type_id = 4
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
													where eam.asset_id = ad.video_id
													and eam.asset_type_id = 4
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
		
		raise notice '% check count',v_fromtodatequery;
	
	if p_status in(1, 2) then 
	  
	  
	  execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
	  SELECT * FROM (
	  select count(1) over() as cnt,*  from (														
	  select 
	  ad.video_id,
	  ad.title,
	  ad.is_published,
	  ad.is_trashed,
	  ad.published_date,
	  ad.title_alias ,
	  ad.video_guid,
	  a.display_name created_by_name,
	  ad.duration,
	  ad.published_version_number as version_number,
	  row_number() over(order by case '||p_status||' when 1 then ad.published_date else ad.updated_date end desc) slno
	  from '||p_schema_prefix||'.'||p_schema_prefix||'_video	ad
	  join '||p_schema_prefix||'.'||p_schema_prefix||'_user a on ad.created_by=a.user_id
	  join '||p_schema_prefix||'.'||p_schema_prefix||'_user b on ad.updated_by=b.user_id
	  where ad.is_published= case '||p_status||' when 1 then 1 else 0 end
	  and ad.is_trashed = case '||p_status||' when 1 then 0 else 1 end
	  '||v_authorquery
	   ||v_searchvideoquery
	   ||v_assetfilterquery
	   ||v_fromtodatequery
	   ||v_draftcreatedbyquery
	   ||'
	  
	  )tab
	  order by published_date desc
	  )TAB2
	  where slno between $6 and $7
      )TAB3
	  group by cnt
	  '
	  
	  into p_videocount,p_videojson 
	  using p_entityrolemapid ,p_authorid,p_createdby,p_from_date,p_to_date,v_fromrownumber,v_torownumber,v_entitycount;
     
	 else 
	 
	    
	   
	  
	 execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
	    SELECT * FROM (
         select count(1) over() as cnt,*  from(
         select ad.asset_id video_id,
      (asset_data->''data''->>''title'') title,
	  (asset_data->''data''->>''guid'') video_guid,
	  (asset_data->''data''->>''status'') is_published, 
	  ad.created_date, 
	  ad.updated_date,
	  ad.version_number,
	  (asset_data->''data''->>''duration'') as duration,
	  (select display_name from labgfg.labgfg_user
      where user_id=ad.created_by) created_by_name,
	  (select display_name from labgfg.labgfg_user
      where user_id=ad.updated_by) edited_by_name,
	 (asset_data->''data''->>''slug_url'') title_alias,
		row_number() over(order by ad.updated_date  desc) slno
		from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
		where ad.asset_type_id = 4
		and ad.version_number = (select max(ad1.version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad1
															where ad1.asset_id = ad.asset_id
															and ad1.asset_type_id = ad.asset_type_id)
         and ((exists (select a.video_id from '||p_schema_prefix||'.'||p_schema_prefix||'_video a
			  where a.video_id = ad.asset_id and a.is_published = 0 and a.is_trashed = 0 ))
		or (ad.version_number > (select max(a.published_version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_video a
								where a.video_id = ad.asset_id  )))
		'
		||v_authorquery
		||v_draftcreatedbyquery
		||v_searchdraftquery
		||v_fromtodatedraftquery
		||v_assetfilterquery
		||'
	)tab
	order by updated_date desc
   )TAB2
 where slno between $6 and $7
)TAB3
group by cnt'
into p_videocount,p_videojson 
using null,p_authorid,p_createdby,p_from_date,p_to_date,v_fromrownumber,v_torownumber,v_assetidarr
;
 
	end if ; 
	
	
	if p_videocount is null then 
	p_videocount :=0;
	p_videojson :='{"items":"[]"}';
	end if;
	--raise notice '% check count',p_videocount;
	--raise notice '% json ',p_videojson;
end;
$_$;


--
