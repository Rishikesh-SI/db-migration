-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_contact_listing_r()
-- Type: FUNCTION

-- Name: u17wc_get_contact_listing_r(); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_contact_listing_r(OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 

declare 
	
begin

 select array_to_json(array_agg(a))  into p_result
 from (select * from u17wc.u17wc_contact)a ; 

end;

 

$$;


--
