-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_ad_listing(numeric, numeric, numeric, character varying, refcursor, refcursor)
-- Type: FUNCTION

-- Name: dhm_get_ad_listing(numeric, numeric, numeric, character varying, refcursor, refcursor); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_ad_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_curr_cnt refcursor, p_curr refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$ 

declare
	 
     v_fromrownumber         numeric;
     v_torownumber           numeric;
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_searchquery varchar(500) := ' ';
     v_select1 varchar(500) := ' ';
     v_select2 varchar(4000) := ' ';
     
begin
    
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if v_searchkeyword is not null then
     	
          v_searchquery := ' and upper(ad_title) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
     
     if p_status in (0,1) then
          
          v_select1 := 'select count(1)   
          		    from   dhm.dhm_ad
                        where  is_published = '|| '$1'|| ' '
                        ||v_searchquery;
          
          open p_curr_cnt for
          execute v_select1
          using p_status, v_searchkeyword;
          
         v_select2 := 'select *
          from   (select ad_id, ad_type, ad_code, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed,
                  		created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date,
                  		asset_guid, ad_title, rank() over (order by updated_date desc) slno
                  from   dhm.dhm_ad
                  where  is_published = '||'$1'||' '
                  ||v_searchquery||'
                 ) ad
          where slno between '|| '$3' ||' and '||'$4';
          
          open p_curr for
          execute v_select2
          using p_status,v_searchkeyword, v_fromrownumber, v_torownumber; 
          
     elsif p_status = 2 then
     
          v_select1 := 'select count(1)   
          		    from   dhm.dhm_ad
                        where  is_trashed = '|| '$1'|| ' '
                        ||v_searchquery;
          
          open p_curr_cnt for
          execute v_select1
          using p_status, v_searchkeyword;
          
         v_select2 := 'select *
          from   (select ad_id, ad_type, ad_code, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed,
                  		created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date,
                  		asset_guid, ad_title, rank() over (order by updated_date desc) slno
                  from   dhm.dhm_ad
                  where  is_trashed = '||'$1'||' '
                  ||v_searchquery||'
                 ) ad
          where slno between '|| '$3' ||' and '||'$4';
          
          open p_curr for
          execute v_select2
          using p_status,v_searchkeyword, v_fromrownumber, v_torownumber;
          
     end if; 
      
end;

 $_$;


--
