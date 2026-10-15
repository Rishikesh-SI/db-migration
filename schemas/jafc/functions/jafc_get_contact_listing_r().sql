-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_get_contact_listing_r()
-- Type: FUNCTION

-- Name: jafc_get_contact_listing_r(); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_get_contact_listing_r(OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 

declare 
	
begin

 select array_to_json(array_agg(a))  into p_result
 from (select * from jafc.jafc_contact)a ; 

end;

 

$$;


--
