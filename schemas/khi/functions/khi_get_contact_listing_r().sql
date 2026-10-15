-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_contact_listing_r()
-- Type: FUNCTION

-- Name: khi_get_contact_listing_r(); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_contact_listing_r(OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 

declare 
	
begin

 select array_to_json(array_agg(a))  into p_result
 from (select * from khi.khi_contact)a ; 

end;

 

$$;


--
