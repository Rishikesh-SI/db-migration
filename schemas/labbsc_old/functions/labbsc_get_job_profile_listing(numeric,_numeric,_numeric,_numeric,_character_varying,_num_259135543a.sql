-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_get_job_profile_listing(numeric, numeric, numeric, numeric, character varying, numeric[], numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labbsc_get_job_profile_listing(numeric, numeric, numeric, numeric, character varying, numeric[], numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labbsc_old; Owner: -
--

CREATE FUNCTION labbsc_old.labbsc_get_job_profile_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_location numeric, p_type numeric, p_function numeric, p_total_exp numeric, OUT p_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

	--do
	--$$
	declare
    p_schema_prefix text :='labbsc';
	/*p_status numeric:=0;
	p_authorid numeric:=null;
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=10;
	p_searchkeyword character varying :=null;
	p_entityrolemapid numeric[]:=array[2121];
	p_from_date timestamp without time zone:=null;
	p_to_date timestamp without time zone:=null;
	--p_createdby numeric:=null;
	p_content_source_id numeric :=null;
		p_json jsonb;
		p_count numeric;
	*/
	v_fromrownumber numeric;
	v_torownumber numeric;
	v_column_name text;
	v_authorquery text := ' ';
	v_articlecreatedbyquery text := ' ';
	v_searchdraftquery text := ' ';
	v_searcharticlequery text := ' ';
	v_contentsourcequery text := ' ';
	v_entitycount numeric;
	v_assetidarr numeric[];
	v_assetfilterquery text := ' ';
	v_searchkeyword text := upper(p_searchkeyword);
	v_article_json json;
	v_sorting_column text;
	v_assets_json json;
	v_locationquery text := ' ';
	v_typequery text := ' ';
	v_functionquery  text := ' ';
	v_total_expquery text := ' ';

	

	begin

	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);

	select count(1) into v_entitycount
	from (select entityid from unnest(p_entityrolemapid) u(entityid)) a;

	if p_authorid is not null then
		
		v_authorquery := ' and ad.created_by=$2';

	end if;
	
	
	
	if p_location is not null then
	
		v_locationquery := ' and a.job_location::numeric= $6 ';

	end if;
	
	if p_type is not null then
	
		v_typequery := ' and a.job_type::numeric = $7 ';

	end if;
	
	if p_function is not null then
	
		v_functionquery := ' and a.job_function::numeric = $8 ';

	end if;
	

	
	if p_total_exp is not null then
	
		v_total_expquery := ' and a.tot_exp::numeric = $9';
		
		

	end if;
	

	if v_searchkeyword is not null then
	
		v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
	
   		v_searchdraftquery := '  and to_tsvector(ad.asset_data->''data''->>''job_profile'') @@@ to_tsquery('''||v_searchkeyword||''')';

		v_searcharticlequery:= ' and to_tsvector(a.job_profile) @@@ to_tsquery('''||v_searchkeyword||''')';
	end if;
	
	

	if v_entitycount >0 then

		if p_status = 0 then

				execute 'with entitydata(t_json)
				as (select (asset_data->''data''->>''entitydata'')::json, asset_draft_id
					from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
					where asset_type_id = 36
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

--select 1/0;

			v_assetfilterquery := ' and ad.asset_draft_id in(select asset_draft_id from unnest($5) u(asset_draft_id))';
		else
  			v_assetfilterquery:=' 	and exists(	select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map eam
												where eam.asset_id = a.job_profile_id
												and eam.asset_type_id = 36
												and eam.entity_role_map_id in (select entityid from unnest($1) u(entityid))
												group by eam.asset_id
												having count(1) = $5)';

		end if;
		
	end if;

			if p_status in(1, 2) then

			--   select * from labbsc.labbsc_job_profile;

			 execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
			 SELECT * FROM (
			 select count(1) over() as cnt,*  from (
			 select
			 a.job_profile_id,
				  a.job_profile,
				 (case a.is_published when 1 then 1 else 2 end) is_published,
			 a.pub_date,
			 a.created_date,
			 a.updated_date,
				  u.display_name as created_by,
			 u1.display_name as updated_by,
				  a.version_number as version_number,
			 a.job_guid,

			 row_number() over(order by case  '||p_status||' when 1 then a.pub_date else a.updated_date end desc) slno
			 from labbsc.labbsc_job_profile a
				  left join labbsc.labbsc_user u on a.created_by=u.user_id
				  left join labbsc.labbsc_user u1 on a.updated_by=u1.user_id
				  where a.is_published= case '||p_status||' when 1 then 1 else 0 end
			 and a.is_trashed = case '||p_status||' when 1 then 0 else 1 end
			 '||v_authorquery
			  ||v_searcharticlequery
			  ||v_assetfilterquery
			  ||v_locationquery
			  ||v_typequery
			  ||v_functionquery
			  ||v_total_expquery
			  ||'

			 )tab
			 order by pub_date desc
			 )TAB2
			 where slno between $3 and $4
				  )TAB3
			 group by cnt
			 '

			 into p_count,p_json
			 using p_entityrolemapid ,p_authorid,v_fromrownumber,v_torownumber,v_entitycount,p_location,p_type,p_function,p_total_exp;

				--raise notice '% %',p_count,p_json;
			--select 1/0;
			else

			/*execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
			   SELECT * FROM (
					 select count(1) over() as cnt,*  from(

					 select ad.asset_id job_profile_id,

				  (asset_data->''data''->>''job_profile'') job_profile,
			 (asset_data->''data''->>''job_guid'') job_guid,
			 (asset_data->''data''->>''status'')::varchar is_published,
			 ad.created_date,
			 ad.updated_date,
			 ad.version_number,
			 u.display_name as created_by,
			 u1.display_name as updated_by,
			row_number() over(order by ad.updated_date  desc) slno
			from labbsc.labbsc_asset_draft ad
			left join labbsc.labbsc_user u on ad.created_by=u.user_id
			left join labbsc.labbsc_user u1 on ad.updated_by=u1.user_id
			where ad.asset_type_id = 36
			and   ad.version_number = (select max(ad1.version_number)
			from   labbsc.labbsc_asset_draft as ad1
			where  ad1.asset_id = ad.asset_id
			and    ad1.asset_type_id = ad.asset_type_id)
			and    ((exists (select job_profile_id
			from   labbsc.labbsc_job_profile a
			where  a.job_profile_id = ad.asset_id
			and    a.is_published = 0
			and    a.is_trashed = 0'
			||v_locationquery
			  ||v_typequery
			  ||v_functionquery
			  ||v_total_expquery
			  ||'))
			or (ad.version_number > (select version_number
			from labbsc.labbsc_job_profile
			where job_profile_id = ad.asset_id)))
			'
			||v_authorquery
			||v_searchdraftquery
			||v_assetfilterquery
			||'
			)tab
			order by updated_date desc
			   )TAB2
			 where slno between $3 and $4
			)TAB3
			group by cnt'
			into p_count,p_json
			using null,p_authorid,v_fromrownumber,v_torownumber,v_assetidarr,p_location,p_type,p_function,p_total_exp
			;*/
			
			 execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
			 SELECT * FROM (
			 select count(1) over() as cnt,*  from (
			 select
			 a.job_profile_id,
				  a.job_profile,
				a.is_published,
			 a.pub_date,
			 a.created_date,
			 a.updated_date,
				  u.display_name as created_by,
			 u1.display_name as updated_by,
				  a.version_number as version_number,
			 a.job_guid,

			 row_number() over(order by case  '||p_status||' when 1 then a.pub_date else a.updated_date end desc) slno
			 from labbsc.labbsc_job_profile a
				  left join labbsc.labbsc_user u on a.created_by=u.user_id
				  left join labbsc.labbsc_user u1 on a.updated_by=u1.user_id
				  where a.is_published= 0
			 and a.is_trashed = 0
			 '||v_authorquery
			  ||v_searcharticlequery
			  ||v_assetfilterquery
			  ||v_locationquery
			  ||v_typequery
			  ||v_functionquery
			  ||v_total_expquery
			  ||'

			 )tab
			 order by pub_date desc
			 )TAB2
			 where slno between $3 and $4
				  )TAB3
			 group by cnt
			 '

			 into p_count,p_json
			 using p_entityrolemapid ,p_authorid,v_fromrownumber,v_torownumber,v_entitycount,p_location,p_type,p_function,p_total_exp;

			--raise notice '% %',p_count,p_json;
			end if ;

			if p_count is null then
			p_count :=0;
			p_json :='{"messege":"no data found"}';
			end if;
--raise notice '% check count',p_articlecount;
-- raise notice '% json ',p_articlejson;
	end;

$_$;


--
