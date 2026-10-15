-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_job_listing(text, numeric, numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_job_listing(text, numeric, numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_job_listing(p_user_guid text, p_pagenumber numeric, p_itemnumber numeric, p_page_size numeric, p_searchkeyword character varying, p_date_desc numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
	--$$
	declare
	/*
	p_pagenumber numeric :=1;
	p_itemnumber numeric:=10;
	p_page_size numeric:=10;
	p_entityrole_mapid numeric[]:= array[5,322];
	p_assetjson jsonb ;
	*/  
	v_json text := '{"items":[';

    v_asset_type_id numeric:=35;
    v_sysdate timestamp;
    v_ent_count numeric;
	v_entityrolemapidquery text=' ';
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_sec_ent_id numeric;
	v_pri_ent_id numeric[];
	v_lang_id numeric;
	v_pri_filter_sql text :=' ';
	v_sec_filter_sql text:=' ';
	v_entity_master_id numeric;
	v_ent_role_map_id integer[];
	v_searchkeyword text := upper(p_searchkeyword);
	v_searchquery text := ' ';
	v_location jsonb;
	v_function jsonb;
	v_type jsonb;
	v_exprience jsonb;
	v_company jsonb;
	v_user_id numeric;
	v_order_by text;
	
	begin

 
    v_sysdate:= current_timestamp at time zone 'utc' ;
	---v_ent_role_map_id := p_entityrole_mapid ;
	
 begin
 select user_id
 from labbsc_dev.labbsc_dev_web_user
 where user_guid=p_user_guid
 into v_user_id;
 exception when no_data_found 
 then 
 v_user_id:=null;
 
 end;
	
	--- raise notice '%',v_ent_role_map_id;

	/*	 select count(distinct entity_id)
		 into   v_ent_count
		 from   unnest(p_entityrole_mapid)entity_id;*/

     
	/*	select entity_role_map_id into v_lang_id
		from labbsc_dev.labbsc_dev_entity_category a
		join labbsc_dev.labbsc_dev_entity_role_map b on a.entity_role_id=b.entity_role_id
		where category_name='Language'
		and entity_role_map_id in (SELECT any_entity_role_mapid
								   FROM UNNEST(p_entityrole_mapid) U(any_entity_role_mapid));
								   */
		if v_searchkeyword is not null then
	
		v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
		v_searchquery := ' and to_tsvector(a.job_profile) @@@ to_tsquery('''||v_searchkeyword||''')';
		
	
		
		end if;
		if p_date_desc =1 then
		v_order_by:= ' order by up.created_date asc ';
		elsif p_date_desc =0 then
		v_order_by:= ' order by up.created_date desc ';
	 
		end if;
							   

     	if p_page_size is null then
		
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
		 
		/*8 raise notice 'v_fromrownumber:%',v_fromrownumber;
		 raise notice 'v_torownumber:%',v_torownumber;
		 raise notice 'v_ent_role_map_id:%',v_ent_role_map_id;
		 raise notice 'v_sysdate:%',v_sysdate;*/
		 

		 execute 'select ''{"items":''||jsonb_agg(tab)::text||'',"count":''||cnt||''}'' 
			 	  from(select distinct count(1) over() as cnt,a.job_profile_id ,a.job_profile,a.slug_url,c.entity_name as location,
			 	  		d.entity_name as department,a.job_desc,g.entity_name as job_type,a.pub_date,a.test_id, i.entity_name as company_name,
						row_number() over ( order by pub_date desc) as rn,
						case when $5 is not null and up.user_id=$5 then 1 else 0 end as proj_flag,
						up.feedback as user_feedback,up.company_feedback,
						up.save_as_draft_user,up.save_as_draft_company,up.upload_file,up.created_date 
				  		from labbsc_dev.labbsc_dev_job_profile a
						join labbsc_dev.labbsc_dev_entity_role_map b on a.job_location::numeric=b.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master c on b.entity_master_id = c.entity_master_id
						join labbsc_dev.labbsc_dev_entity_role_map e on a.job_function::numeric=e.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master d on e.entity_master_id = d.entity_master_id
						join labbsc_dev.labbsc_dev_entity_role_map f on a.job_type::numeric=f.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master g on f.entity_master_id = g.entity_master_id
						join labbsc_dev.labbsc_dev_entity_role_map h on a.company_name::numeric=h.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master i on h.entity_master_id = i.entity_master_id
						join labbsc_dev.labbsc_dev_user_job_detail up
						on up.job_id=a.job_profile_id
						and up.user_id=coalesce($5,up.user_id)
						where  a.is_published=1
						and a.is_trashed=0
					----	and a.job_exp >= $4
						---- and a.tagged_entity @> $1 
						'						
						|| v_searchquery ||'
					 '						
						|| v_order_by ||'
						
						)tab
						where rn between '||v_fromrownumber||' and '||v_torownumber||'
						group by cnt'
			into p_data
			using v_ent_role_map_id,v_fromrownumber,v_torownumber,v_sysdate,v_user_id;
			--order by pub_date desc
			
			-- raise notice 'p_data:%',p_data;
			-- select 1/0;
			
			
	select '{"location":'||json_agg(row)||'}' into v_location from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc_dev.labbsc_dev_entity_master a
	join labbsc_dev.labbsc_dev_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (23)
	order by b.entity_role_map_id	
	)row;

	select json_agg(row) into v_function from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc_dev.labbsc_dev_entity_master a
	join labbsc_dev.labbsc_dev_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (24)
	order by b.entity_role_map_id	
	)row;

	select json_agg(row) into v_type from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc_dev.labbsc_dev_entity_master a
	join labbsc_dev.labbsc_dev_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (25)
	order by b.entity_role_map_id	
	)row;

	select json_agg(row) into v_exprience from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc_dev.labbsc_dev_entity_master a
	join labbsc_dev.labbsc_dev_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (26)
	order by b.entity_role_map_id 	
	)row;
	
	select json_agg(row) into v_company from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc_dev.labbsc_dev_entity_master a
	join labbsc_dev.labbsc_dev_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (27)
	order by b.entity_role_map_id 	
	)row;

	p_data := jsonb_set(p_data,'{location}',v_location,true);
	p_data := jsonb_set(p_data,'{job_function}',v_function,true);
	p_data := jsonb_set(p_data,'{job_type}',v_type,true);
	p_data := jsonb_set(p_data,'{total_exprience}',v_exprience,true);
	p_data := jsonb_set(p_data,'{Company}',v_company,true);
	

	end;
$_$;


--
