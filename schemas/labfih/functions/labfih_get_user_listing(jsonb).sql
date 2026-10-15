-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_user_listing(jsonb)
-- Type: FUNCTION

-- Name: labfih_get_user_listing(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_user_listing(p_json jsonb, OUT p_usercount numeric, OUT p_userjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
declare
   
	/*
    p_articlecount numeric;
	
	{
	"page_number":"1",
	"item_number":"10",
	"searchkeyword":""
	}
	
	*/
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_column_name text;
	v_authorquery text := ' ';
	v_draftcreatedbyquery text := ' ';
    v_articlecreatedbyquery text := ' ';
	v_searchdraftquery text := ' ';
    v_searcharticlequery text := ' ';
	v_fromtodatequery text:= ' ';
	v_contentsourcequery text := ' ';
	v_entitycount numeric;
	v_assetidarr numeric[];
	v_assetfilterquery text := ' ';
	v_searchkeyword text;
	v_article_json json;
	v_sorting_column text;
	v_assets_json json;
	v_fromtodatedraftquery text :=' ';
	v_age_group_filter text := ' ';
	v_age_group character varying;
	v_gender character varying;
	v_source character varying;
	v_gender_filter text := ' ';
begin

		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    	v_torownumber   := (p_pagenumber * p_itemnumber);
		
		
		select p_json->>'searchkeyword',
				p_json->>'age_group',
				p_json->>'gender',
				p_json->>'source'
		into v_searchkeyword,
			 v_age_group,
			 v_gender,
			 v_source;
		
		
		if v_searchkeyword = '' then
			v_searchkeyword:= null;
		end if;	
		
		
		if v_searchkeyword is not null then
		 v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
			--- v_searchdraftquery := ' and upper(ad.asset_data->''data''->>''title'') like ''%'||v_searchkeyword||'%'' ';
			
          -- v_searcharticlequery :=   ' and upper(ad.title) like ''%'||v_searchkeyword||'%'' ';
		    v_searchdraftquery := '  and (to_tsvector(wu.first_name) @@@ to_tsquery('''||v_searchkeyword||'''))
										or (to_tsvector(wu.last_name) @@@ to_tsquery('''||v_searchkeyword||'''))';
			  
			
			 v_searcharticlequery:= ' and to_tsvector(ad.title) @@@ to_tsquery(quote_literal('''||v_searchkeyword||'''))';
		end if;
		
		  raise notice '% search',v_searcharticlequery;
		
   if v_age_group is not null THEN
   		v_age_group_filter:= 'and age_group in ($3)';	
   end if;
   raise notice 'v_age_group_filter %',v_age_group_filter;
   
   
   if v_gender is not null THEN
   
   		IF v_gender= 'Male' then v_gender:='VUgybOg9dYJphrnUmWnTuQ==';
		elsif v_gender= 'Female' then v_gender:='//vE0ALE1cZUe5IpJSRj/A==';
		elsif v_gender= 'Other' then v_gender:='J/Z1pr5WrZGVJTxqz5kVGQ==';
		end if;
		
   		v_gender_filter:= 'and gender in ($4)';	
		
   end if;
	  
	  execute 'select cnt,''{"items":[''||string_agg(row_to_json(tab3)::text,'','')||'']}'' from (
	  SELECT * FROM (
	  select count(1) over() as cnt,*  from (														
	  select 
	  wu.user_id,
	  wu.first_name,
	  wu.last_name,
	  wu.created_date,
	  row_number() over(order by wu.updated_date end desc) slno
	  from '||p_schema_prefix||'.'||p_schema_prefix||'web_user	wu
	  '||v_searcharticlequery
	  ||v_gender_filter
	  ||v_age_group_filter'
	  )tab
	  
	  )TAB2
	  where slno between $6 and $7
      )TAB3
	  group by cnt
	  '
	  
	  into p_usercount,p_userjson 
	  using v_fromrownumber,v_torownumber;
     
	 
	
	
	if p_usercount is null then 
	p_userjson :='{ "items": []}';
	p_usercount:=0;
	end if;
	--raise notice '% check count',p_usercount;
	-- raise notice '% json ',p_userjson;
end;
$_$;


--
