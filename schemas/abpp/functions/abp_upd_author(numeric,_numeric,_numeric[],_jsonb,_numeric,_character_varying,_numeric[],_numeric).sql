-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_upd_author(numeric, numeric, numeric[], jsonb, numeric, character varying, numeric[], numeric)
-- Type: FUNCTION

-- Name: abp_upd_author(numeric, numeric, numeric[], jsonb, numeric, character varying, numeric[], numeric); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_upd_author(p_opttype numeric, p_status numeric, p_assettypeid numeric[], p_selectedassetsjson jsonb, p_authorid numeric, p_searchfilter character varying, p_entityrolemapid numeric[], p_newauthorid numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_searchfilter varchar(4000) := upper(p_searchfilter);
     v_searchdraftquery varchar(4000) := ' ';
     v_searchassetquery varchar(4000) := ' ';
     v_enityrolemapidcount numeric;
     v_draftenityrolemapidquery varchar(4000) := ' ';
     v_assetenityrolemapidquery varchar(4000) := ' ';
     v_draftcreatedbyquery varchar(4000) := ' ';
     v_assettypeidcount numeric;
     v_assettypeid numeric;
     v_andfilterquery varchar(4000) := ' ';
     v_partialquery varchar(4000) := ' ';
     v_assetquery varchar(4000) := ' ';
     v_assetcreatedbyquery varchar(4000) := ' ';
     v_assettypefilterquery varchar(4000) := ' ';
     v_sysdate timestamp := current_timestamp at time zone 'utc';
     v_selectedassetsjsonarr json[];
     v_selectedassetsjsonarrlength numeric;
     v_selectedassetsjson json;
     v_jsonassettypeid numeric;
     v_jsonassetidlist varchar(40000) := '';
     v_versionnumber numeric;
     v_versionnumberquery varchar(4000) := ' ';
     v_jsonassetidlistcount numeric;
     v_jsonassetidlistarr numeric[];
     
begin
	
     create temp table if not exists t_allassetdata
     (
         c_assetid numeric,
         c_assettypeid numeric,
         c_versionnumber numeric
     );
     
  	select count(asset_type_id)
     into   v_assettypeidcount
	from   unnest(p_assettypeid) U(asset_type_id);
  	
  	if v_assettypeidcount > 0 then
		
          v_assettypefilterquery := ' and ad.asset_type_id in(select asset_type_id from unnest($1) U(asset_type_id))';
     
     end if;
     
  	if v_searchfilter is not null then
     	
          v_searchfilter := '*'||replace(''||v_searchfilter||'',' ',':* & *') || ':*';
      	v_searchassetquery := ' and (to_tsvector(al.asset_title) @@@ to_tsquery('''||'$4'||''')
          						or to_tsvector(sl.short_desc) @@@ to_tsquery('''||'$4'||'''))';
  		
     end if;
     
  	select count(entity_role_map_id)
  	into   v_enityrolemapidcount
  	from   unnest(p_entityrolemapid) U(entity_role_map_id);
  	
  	if p_opttype = 1 then
  	/*option type 1(All) begins*/
     	
          if p_status = 0 then
      		
          	v_partialquery := 'insert into t_allassetdata
               			    select asset_id, asset_type_id, version_number
                                  from   abp.abp_asset_draft as ad
                                  where  ad.version_number = (select max(ad1.version_number)
                                  						  from   abp.abp_asset_draft as ad1
                                                              where  ad1.asset_id = ad.asset_id
                                                              and    ad1.asset_type_id = ad.asset_type_id)';
			
      		v_andfilterquery := 'and ((exists (select al.asset_id
               							from   abp.abp_asset_list al
                                                  where  al.asset_id = ad.asset_id
                                                  and    al.asset_type_id = ad.asset_type_id
                                                  and    al.is_published = 0
                                                  and    al.is_trashed = 0)))';
			
      		v_draftcreatedbyquery := ' and ad.asset_id in(select aa.asset_id
                                                    from   abp.abp_author_action aa
                                                    where  action_id = 4
                                                    and    aa.asset_type_id = ad.asset_type_id
                                                    and    author_id = $2)';
			
      		if v_searchfilter is not null then
               	
                    v_searchdraftquery := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$3'||'||''%'' ';
                    
      		end if;
               
      		if v_enityrolemapidcount > 0 then
               
        			v_draftenityrolemapidquery := ' and ad.asset_id in(select asset_id
                    										 from   abp.abp_asset_entity_map aem
                                                                       where  aem.asset_type_id = ad.asset_type_id 
                                                                       and    aem.entity_role_map_id in (select entityrolemapid
                                                                       							from   unnest($4) U(entityrolemapid))
														 group by aem.asset_id, asset_type_id
                                                                       having count(1) = '||v_enityrolemapidcount||')';
				
      		end if;
               
      		execute v_partialquery
               	   ||v_assettypefilterquery
                       ||v_andfilterquery
                       ||v_draftcreatedbyquery
                       ||v_searchdraftquery
                       ||v_draftenityrolemapidquery
			using   p_assettypeid, p_authorid, v_searchfilter, p_entityrolemapid;
               
      		/*insert into abp.t_allassetdataquery
               values(v_partialquery||v_andfilterquery||v_draftcreatedbyquery||v_searchdraftquery||v_draftenityrolemapidquery);*/
               
      		update abp.abp_author_action
      		set    author_id = p_newauthorid,
               	  updated_date = v_sysdate
			where  (asset_type_id, asset_id) in (select c_assettypeid, c_assetid from t_allassetdata)
			and    author_id = p_authorid
               and    action_id = 4;
               
      		p_result := 1;
               
    		elsif p_status in(1, 2) then
          	
               v_partialquery := 'insert into t_allassetdata ';
               
               if v_assettypeidcount > 0 then
               	
                    v_assettypefilterquery := ' and al.asset_type_id in(select asset_type_id
                    										  from   unnest($1) U(asset_type_id))';
                    
     		end if;
               
      		v_assetquery := 'select asset_id, asset_type_id, published_version_number
               			  from   abp.abp_asset_list as al
                                where  al.is_published = (case $1 when 1 then 1 else 0 end)
                                and    al.is_trashed   = (case $1 when 1 then 0 else 1 end)';
			
      		v_assetcreatedbyquery := ' and al.asset_id in(select aa.asset_id
               									 from   abp.abp_author_action aa
                                                             where  action_id = 4
                                                             and    aa.asset_type_id = al.asset_type_id
                                                             and    author_id = $3)';
			
      		if v_enityrolemapidcount > 0 then
               	
        			v_assetenityrolemapidquery := ' and al.asset_id in(select aem.asset_id
                    										 from   abp.abp_asset_entity_map aem
                                                                       where  aem.asset_type_id = al.asset_type_id
                                                                       and    aem.entity_role_map_id in (select entityrolemapid
                                                                       							from   unnest($5) U(entityrolemapid))
														 group by aem.asset_id, asset_type_id
                                                                       having count(1) = '||v_enityrolemapidcount||')';
				
      		end if;
               
      		execute v_partialquery
               	   ||v_assetquery
                       ||v_assettypefilterquery
                       ||v_assetcreatedbyquery
                       ||v_searchassetquery
                       ||v_assetenityrolemapidquery
      		using   p_status, p_assettypeid, p_authorid, v_searchfilter, p_entityrolemapid;
               
      		/*insert into abp.t_allassetdataquery
               values(v_partialquery||v_assetquery||v_assetcreatedbyquery||v_searchassetquery||v_assetenityrolemapidquery);*/
               
      		update abp.abp_author_action
      		set    author_id = p_newauthorid,
               	  updated_date = v_sysdate
			where  (asset_type_id, asset_id) in(select c_assettypeid, c_assetid from t_allassetdata)
			and    author_id = p_authorid
      		and    action_id = 4;
               
      		p_result := 1;
               
    		end if;
          
          if p_status = 0 then
			
               v_versionnumberquery := ' and version_number not in(c_versionnumber)';
               
		elsif p_status = 1 then
          	
               v_versionnumberquery := ' and version_number = c_versionnumber';
               
		end if;
          
          execute 'update abp.abp_asset_draft
          	    set    asset_data = jsonb_set(asset_data,''{data,author_data}'',(replace((asset_data->''data''->>''author_data'')::text,$1::text,$2::text))::text::jsonb,false)
                   from   t_allassetdata
                   where  asset_id = c_assetid
                   and    asset_type_id = c_assettypeid'
                   ||v_versionnumberquery
		  using p_authorid, p_newauthorid;
          
	/*option type 1(All) ends*/
     
  	elsif p_opttype = 2 then
     /*option type 2(Selected) begins*/
     	
    		select array(select json_array_elements(tjson)
                       from   (select (p_selectedassetsjson->'data'->'asset_type')::json tjson) a)
		into   v_selectedassetsjsonarr;
          
    		select json_array_length((p_selectedassetsjson->'data'->'asset_type')::json)
    		into   v_selectedassetsjsonarrlength;
          
    		if v_selectedassetsjsonarrlength > 0 then
          	
               for i in 1..v_selectedassetsjsonarrlength
      		loop
               	
                    select v_selectedassetsjsonarr[i]
                    into   v_selectedassetsjson;
                    
                    select (v_selectedassetsjson->>'asset_type_id')::numeric, (v_selectedassetsjson->>'asset_id')::varchar
                    into   v_jsonassettypeid, v_jsonassetidlist;
        			
                    update abp.abp_author_action
                    set    author_id = p_newauthorid,
                    	  updated_date = v_sysdate
				where  asset_type_id = v_jsonassettypeid
                    and    asset_id in(select asset_id::numeric
                                       from unnest(string_to_array(v_jsonassetidlist,',')) U(asset_id))
				and    author_id = p_authorid
        			and    action_id = 4;
                    
                    select count(asset_id::numeric),string_to_array(v_jsonassetidlist,',')::numeric[]
                    into   v_jsonassetidlistcount, v_jsonassetidlistarr
                    from   unnest(string_to_array(v_jsonassetidlist,',')) U(asset_id);
                    
                    for i in 1..v_jsonassetidlistcount
                    loop
                    	
                         select published_version_number
                         into   v_versionnumber
                         from   abp.abp_asset_list al
                    	where  al.asset_id = v_jsonassetidlistarr[i]
          			and    al.asset_type_id = v_jsonassettypeid;
	                    
                    	if p_status = 0 then
                    		
                         	v_versionnumberquery := ' and version_number not in($1)';
	                         
                    	elsif p_status = 1 then
                    		
                         	v_versionnumberquery := ' and version_number = $1';
	                         
	                    end if;
                    	
                    	execute 'update abp.abp_asset_draft
	                    	    set    asset_data = jsonb_set(asset_data,''{data,author_data}'',(replace((asset_data->''data''->>''author_data'')::text,$2::text,$3::text))::text::jsonb,false)
          	                   where  asset_id = $4
               	              and    asset_type_id = $5'
                    	         ||v_versionnumberquery
          			using    v_versionnumber, p_authorid, p_newauthorid, v_jsonassetidlistarr[i], v_jsonassettypeid;
                         
                    end loop;
                    
      		end loop;
               
    		end if;
          
  		p_result := 1;
          
  	end if;
  	/*option type 2(Selected) ends*/
     
  	drop table t_allassetdata;
     
/*exception
	when others then
     	p_result := -1;*/

end;

$_$;


--
