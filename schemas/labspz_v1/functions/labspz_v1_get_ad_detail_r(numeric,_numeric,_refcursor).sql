-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_get_ad_detail_r(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: labspz_v1_get_ad_detail_r(numeric, numeric, refcursor); Type: FUNCTION; Schema: labspz_v1; Owner: -
--

CREATE FUNCTION labspz_v1.labspz_v1_get_ad_detail_r(p_adid numeric, p_versionnumber numeric, p_curr refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
 

declare
	 
     
begin

     if p_versionnumber is null then

          open p_curr for
          select ad_id, ad_type, ad_code, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date,
          	  updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid, ad_title
          from   labspz_v1.labspz_v1_ad
          where  ad_id = p_adid;

     end if; 

exception

     when others then 
     	null;

end;


$$;


--
