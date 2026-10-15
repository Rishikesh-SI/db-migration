-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_get_ad_detail(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: utt_get_ad_detail(numeric, numeric, refcursor); Type: FUNCTION; Schema: utt; Owner: -
--

CREATE FUNCTION utt.utt_get_ad_detail(p_adid numeric, p_versionnumber numeric, p_curr refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

declare
	 
     
begin
	
     if p_versionnumber is null then
          
          open p_curr for
          select ad_id, ad_type, ad_code, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date,
          	  updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid, ad_title
          from   utt.utt_ad
          where  ad_id = p_adid;
          
     end if; 
     
exception
	
     when others then 
     	null;
	
end;

 $$;


--
