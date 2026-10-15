-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_get_press_release_listing(numeric, numeric, numeric, text)
-- Type: FUNCTION

-- Name: labdsg_get_press_release_listing(numeric, numeric, numeric, text); Type: FUNCTION; Schema: labdsg; Owner: -
--

CREATE FUNCTION labdsg.labdsg_get_press_release_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword text, OUT p_preesreleasecount numeric, OUT p_preesreleasejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
--p_status numeric :=0;
v_cnt numeric;
v_asset_draft text ;
v_json jsonb;
err_msg text;
p_result  numeric;

v_fromrownumber numeric;
v_torownumber numeric;

 v_searchkeyword 	    varchar(4000) := upper(p_searchkeyword);
v_searchdraftquery text :=' ';
v_searcharticlequery text:=' ';
begin 

v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
v_torownumber   := (p_pagenumber * p_itemnumber);

create temp table press_release_data
(
    title text,
    published_date timestamp,
	press_release_id numeric ,
    created_date date,
    created_by numeric ,
	version_number numeric ,
	guid text,
	updated_date date 
)
;

 if v_searchkeyword is not null then
    	
        v_searchdraftquery := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$3'||'||''%'' ';
        v_searcharticlequery := ' and upper(title) like ''%''||'||'$4'||'||''%'' ';
        
	end if;

if p_status=0 then 

 select  count(1)  into  v_cnt
												
     		     from   labdsg.labdsg_asset_draft as adv
	             where  adv.asset_type_id = 20
     	         and    adv.version_number = (select max(ad1.version_number)
                     						  from   labdsg.labdsg_asset_draft as ad1
                                              where  ad1.asset_id = adv.asset_id
                     						  and    ad1.asset_type_id = adv.asset_type_id)
				and     ((exists (select press_release_id
                     			  from   labdsg.labdsg_press_release_master a
                     			  where  a.press_release_id = adv.asset_id
                     			  and status = 0
                     			 and is_trashed = 0 
								))
						 or (adv.version_number > (select max(version_number)
                     							   from   labdsg.labdsg_press_release_master
                     							   where  press_release_id = adv.asset_id )
							));
							
							

execute 'select string_agg(asset_draft_id::text,'','') from ( select  asset_draft_id,
													row_number() over (order by adv.updated_date desc) slno
     		     from   labdsg.labdsg_asset_draft as adv
	             where  adv.asset_type_id = 20
     	         and    adv.version_number = (select max(ad1.version_number)
                     						  from   labdsg.labdsg_asset_draft as ad1
                                              where  ad1.asset_id = adv.asset_id
                     						  and    ad1.asset_type_id = adv.asset_type_id)
				and     ((exists (select press_release_id
                     			  from   labdsg.labdsg_press_release_master a
                     			  where  a.press_release_id = adv.asset_id
                     			  and status = 0
                     			  and is_trashed = 0 
								))
						 or (adv.version_number > (select max(version_number)
                     							   from   labdsg.labdsg_press_release_master
                     							   where  press_release_id = adv.asset_id )
							))
							'||v_searchdraftquery||'
							)tab 
							where slno between $1 and  $2'
							into 	v_asset_draft
							using v_fromrownumber,v_torownumber ,v_searchkeyword
							;
	
	
	raise notice '%',v_asset_draft;
	
	insert into press_release_data
	select asset_data->'data'->>'title' as title ,
	       (asset_data->'data'->>'published_date')::timestamp as published_date,
		   (asset_data->'data'->>'press_release_id')::numeric as press_release_id,
		   created_date as created_date,
		   (asset_data->'data'->>'created_by')::numeric as created_by ,
		    version_number as version_number ,
		   asset_data->'data'->>'guid' as guid ,
		   updated_date as updated_date
	from labdsg.labdsg_asset_draft where asset_type_id = 20  
	and  asset_draft_id = ANY (string_to_array(v_asset_draft,',')::int[])	
	;

elsif p_status=1 then 

select count(1) into v_cnt
   from labdsg.labdsg_press_release_master adv
   where status= p_status;

  execute 'select string_agg(press_release_id::text,'','')  
   					from (select
 				 	press_release_id,
  					row_number() over (order by adv.published_date desc) slno
  
     from labdsg.labdsg_press_release_master adv
     where status= $3 
	 '||v_searcharticlequery||'
	 )tab 
     where slno between $1 and  $2'
	into 	v_asset_draft
	using v_fromrownumber,v_torownumber ,p_status,v_searchkeyword;
    
	
     insert into press_release_data
     select title,published_date,press_release_id,created_date,created_by,version_number ,guid ,updated_date
	 from labdsg.labdsg_press_release_master
	 where press_release_id = ANY (string_to_array(v_asset_draft,',')::int[])
	 and status=p_status;
else 

select count(1) into v_cnt
   from labdsg.labdsg_press_release_master adv
   where is_trashed= 1;

  execute 'select string_agg(press_release_id::text,'','')  
   					from (select
 				 	press_release_id,
  					row_number() over (order by adv.updated_date desc) slno
  
     from labdsg.labdsg_press_release_master adv
     where is_trashed= 1
	 '||v_searcharticlequery||'
	 )tab 
     where slno between $1 and  $2'
	into 	v_asset_draft
	using v_fromrownumber,v_torownumber, null,v_searchkeyword;
    
	
     insert into press_release_data
     select title,published_date,press_release_id,created_date,created_by,version_number ,guid ,updated_date
	 from labdsg.labdsg_press_release_master
	 where press_release_id = ANY (string_to_array(v_asset_draft,',')::int[])
	 and is_trashed=1;

	 
 
end if ;
		
		
		
		select '{"data":{"items":['||string_agg(row_to_json (tab)::text,',')||']}}'  
		into v_json from (
			select * from press_release_data)tab;
		
			raise notice '%',v_json;
			
			p_preesreleasecount:=v_cnt;
			p_preesreleasejson:=v_json;
			
			drop table press_release_data;
			
			
 exception 
    when others then
	    --err_code := SQLSTATE;
         err_msg := SQLERRM;
		  p_result := -1;
		  v_json := '{"data":{"message" :"'||coalesce(err_msg, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';

			
end ;

$_$;


--
