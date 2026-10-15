-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_company_project_listing(text, numeric, numeric, numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: labbsc_get_company_project_listing(text, numeric, numeric, numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_company_project_listing(p_company_email text, p_date_desc numeric, p_pagenumber numeric, p_itemnumber numeric, p_page_size numeric, p_searchkeyword character varying, p_status numeric, OUT p_data jsonb) RETURNS jsonb
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

   --- v_asset_type_id numeric:=35;
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
	v_company_id numeric;
	v_company_name varchar(4000);
	v_order_by varchar(4000);
	v_status varchar(500);
	begin

 
    v_sysdate:= current_timestamp at time zone 'utc' ;
	---v_ent_role_map_id := p_entityrole_mapid ;

if p_company_email is not null then
 begin
 select entity_master_id,entity_name
 from labbsc.labbsc_entity_master
 where entity_json->>'company_spoc_email'=p_company_email
 into v_company_id,v_company_name;
 exception when no_data_found 
 then 
 v_company_id:=null;
 
 end;
 else
  v_company_id:=null;
 end if;
	
	--- raise notice '%',v_ent_role_map_id;
      
	 
								   
	 
		if p_date_desc=0 then
		v_order_by:=' order by up.created_date desc ';
		else
		v_order_by:=' order by up.created_date asc ';
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
		--- raise notice '%' ----'|| v_status ||',

		 execute 'select ''{"items":''||jsonb_agg(tab)::text||'',"count":''||cnt||''}'' 
			 	  from(select count(1) over() as cnt,
				  a.job_profile_id ,
				  a.job_profile,
				  a.slug_url,
				  
			 	  		a.job_desc,a.pub_date,a.test_id,
						row_number() over ( order by up.created_date desc) as rn,
						a.company_name as company_id,
						em.entity_name as company_name,
						u.email_id,u.user_id,u.first_name,u.last_name,u.user_guid,
						up.feedback as user_feedback,up.company_feedback ,
						up.save_as_draft_user ,
						up.created_date::date as project_applied_on,
						up.upload_file as uploaded_items,
						up.expiry_date,up.project_complete
						
				  		from labbsc.labbsc_job_profile a
						   join labbsc.labbsc_user_project_detail up
						on up.project_id=a.job_profile_id 
						join labbsc.labbsc_entity_master em
						on em.entity_master_id=a.company_name
						join labbsc.labbsc_entity_role_map b 
						on em.entity_master_id = b.entity_master_id
						  and  b.entity_role_id in (27)
						join labbsc.labbsc_web_user u
						on u.user_id=up.user_id
                    
						
						where  a.is_published=1
						and a.is_trashed=0
						and a.job_exp >= $4
						and a.company_name= coalesce($6,a.company_name)
						and u.email_id=coalesce($8,u.email_id)
						and coalesce(up.project_complete,0) = coalesce($7,coalesce(up.project_complete,0))
						---and a.tagged_entity @> $1 
						 
						'						
						|| v_searchquery ||'
						'|| v_order_by ||'
						
						
						)tab
						where rn between '||v_fromrownumber||' and '||v_torownumber||'
						group by cnt'
			into p_data
			using v_ent_role_map_id,v_fromrownumber,v_torownumber,v_sysdate,v_user_id,v_company_id,p_status,p_searchkeyword;
			--order by pub_date desc
			
			-- raise notice 'p_data:%',p_data;
			-- select 1/0;
			
			
 

	end;
$_$;


--
