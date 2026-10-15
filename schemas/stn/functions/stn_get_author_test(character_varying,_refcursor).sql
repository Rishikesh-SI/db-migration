-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_author_test(character varying, refcursor)
-- Type: FUNCTION

-- Name: stn_get_author_test(character varying, refcursor); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_author_test(p_full_name character varying, p_curr refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	 
     
begin
	
          
          open p_curr for
          select * from stn.stn_user
		  where (upper(full_name) = upper(p_full_name) or coalesce(p_full_name,'') = ''
                or upper(user_name) = upper(p_full_name)) ;

	
end;

$$;


--
