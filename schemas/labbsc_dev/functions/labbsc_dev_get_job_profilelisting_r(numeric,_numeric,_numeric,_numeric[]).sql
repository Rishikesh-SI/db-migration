-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_job_profilelisting_r(numeric, numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: labbsc_dev_get_job_profilelisting_r(numeric, numeric, numeric, numeric[]); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_job_profilelisting_r(p_pagenumber numeric, p_itemnumber numeric, p_page_size numeric, p_entityrole_mapid numeric[], OUT p_data jsonb) RETURNS jsonb
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
	
	begin

	/*-- new changes Done By Rakesh Bhatkar
	 add username and full_name
	 Date :-15112017
	-- End--
	*/
    v_sysdate:= current_timestamp at time zone 'utc' + '5.5 hours'::interval;
	v_ent_role_map_id := p_entityrole_mapid ;
	
	--- raise notice '%',v_ent_role_map_id;

		 /*select count(distinct entity_id)
		 into   v_ent_count
		 from   unnest(p_entityrole_mapid)entity_id;

     
		select entity_role_map_id into v_lang_id
		from labbsc_dev.labbsc_dev_entity_category a
		join labbsc_dev.labbsc_dev_entity_role_map b on a.entity_role_id=b.entity_role_id
		where category_name='Language'
		and entity_role_map_id in (SELECT any_entity_role_mapid
								   FROM UNNEST(p_entityrole_mapid) U(any_entity_role_mapid));*/

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
		 
		 

		 execute 'select ''{"items":''||jsonb_agg(tab)::text||'',"count":''||cnt||''}'' 
			 	  from(select count(1) over() as cnt,a.job_profile_id ,a.job_profile,a.slug_url,
			 	  		a.job_desc,row_number() over ( order by pub_date asc) as rn
				  		from labbsc_dev.labbsc_dev_job_profile a
						where  a.is_published=1
						and a.is_trashed=0
						and a.tagged_entity @> $1
						and a.job_exp::date > v_sysdate::date
						)tab
						where rn between $2 and $3
						group by cnt'
			into p_data
			using v_ent_role_map_id,v_fromrownumber,v_torownumber;

	end;

	$_$;


--
