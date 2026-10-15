-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_get_asset_draft(numeric, refcursor)
-- Type: FUNCTION

-- Name: cfc_get_asset_draft(numeric, refcursor); Type: FUNCTION; Schema: cfc; Owner: -
--

CREATE FUNCTION cfc.cfc_get_asset_draft(p_asset_type_id numeric, p_article_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

DECLARE
	
    
BEGIN
	
              
      OPEN p_article_cur FOR  
    	select asset_id  , asset_data,  A.version_number, A.is_active, A.is_deleted, A.asset_type_id
		from cfc.cfc_asset_draft A
		where A.asset_type_id = p_asset_type_id 
		and A.is_active = 1 
		and A.is_deleted = 0 
        and  ((asset_data->'data'->'published_date')::text like '%AM%' 
				or (asset_data->'data'->'published_date')::text like '%PM%' ) 
		and A.version_number = (select max(B.version_number) from cfc.cfc_asset_draft B
								where A.asset_type_id = B.asset_type_id
								and A.asset_id = B.asset_id and B.is_active = 1	and B.is_deleted = 0 );

                                                          
    END;
    

$$;


--
