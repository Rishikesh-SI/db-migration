-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_asset_detail_r_niu(character varying)
-- Type: FUNCTION

-- Name: labyho_get_asset_detail_r_niu(character varying); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_asset_detail_r_niu(p_titlealias character varying, OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

 

declare
	
    v_assetid numeric;
    v_assettypeid numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
    v_sysdate timestamp;
    v_assetjsonarr jsonb[];
    v_assetjson jsonb;
    v_json text := '{"items":[';
    v_asset_count numeric;
    
    -- parameters for changes for accomodating listing page data
    v_url varchar(10000);
    v_count int;
    v_asset_alias varchar(10000);
    v_fulltext text := ' ';
    v_lang_canonical_url varchar(10);
    v_version_number numeric;
    v_browser_title varchar(10000) := '';
    v_amp numeric := 0;
    
begin
       v_sysdate:= current_timestamp at time zone 'utc';
       
       v_url :=lower(p_titlealias);
       select * into v_count from labyho.regexp_count(v_url, '/');
       v_asset_alias :=   split_part(v_url, '/', (v_count+1));
       
       
    
    
    	    select asset_id, asset_type_id
            into   v_assetid, v_assettypeid
            from   labyho.labyho_asset_list
            where  (lower(title_alias) = v_url
            		or p_titlealias ~ concat('^',title_alias,'$'))
            and    is_published=1
            and    published_date <= v_sysdate
            and    asset_type_id in (11);
            
      
      if v_assetid is null then
            
           -- raise notice '1 : %', v_assetid ; 
            
        select asset_id, asset_type_id, published_version_number,language_id,language_url
    	into   v_assetid, v_assettypeid , v_version_number ,v_language_id,v_lang_canonical_url
    	from   labyho.labyho_asset_list
    	where  lower(title_alias) = v_asset_alias
        and    is_published=1
        and    published_date <= v_sysdate
        and    asset_type_id in (1,2,4,5);
            
      end if;
      
      if v_assettypeid in (2,4)
      then 
          select web_detail_jsn->'data'->>'browser_title' 
		  into v_browser_title
          from labyho.labyho_asset_list
          where asset_type_id = v_assettypeid
          and asset_id = v_assetid
          and published_version_number = v_version_number ;
                             
      end if ; 
     
        
        if exists (select count(1) from labyho.labyho_page
        where asset_type_id=1 and is_amp=1)
        then 
        v_amp=1;
        else 
        v_amp=0;
        end if ;
        
 
    if v_assetid is not null then
	
	-- explain  ANALYZE
select ('{ "items":'||jsonb_agg(tab)::text||'}')::jsonb from (
select 
sl.asset_list_id, 
sl.asset_id, 
coalesce(p.asset_type_id,sl.asset_type_id) as asset_type_id,
sl.asset_title,
sl.title_alias,
short_desc,
asset_guid,
u.display_name user_name,
 sl.language_id, 
sd.meta_info->>'keywords' keywords,
sd.meta_info, 
null as full_text , 
sl.language_url as lang_url, 
coalesce(ar.browser_title,null) browser_title,
v_amp as is_amp,
web_detail_jsn->'data'->>'client_canonical_url' as client_canonical_url,
web_listing_json->>'content_provider_name' as content_provider_name,
coalesce(web_listing_json->>'secondary_entity_name','English') as secondary_entity_name,
coalesce(web_listing_json->>'primary_entity_name','English') as primary_entity_name	
from   labyho.labyho_asset_list sl
left join labyho.labyho_user u
on     u.user_id = sl.author_id
left join   labyho.labyho_seo_data sd
on     sd.asset_id = sl.asset_id
and    sd.asset_type_id = sl.asset_type_id
left join labyho.labyho_article ar 
on (ar.article_id =  sl.asset_id and sl.asset_type_id = 1) 
left join labyho.labyho_page p on p.page_id=sl.asset_id and  sl.asset_type_id=11
where  sl.is_active=1
and    sl.is_deleted=0
and    sl.is_published=1
and    sl.published_date<=v_sysdate
and    sl.asset_id = v_assetid
and    sl.asset_type_id = v_assettypeid
) tab
into p_assetjson
;

end if;
  
end;
$_$;


--
