-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_get_contact_listing_r()
-- Type: FUNCTION

-- Name: pbl_get_contact_listing_r(); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_get_contact_listing_r(OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 

declare 
	
begin

 select array_to_json(array_agg(a))  into p_result
 from (select * from pbl.pbl_contact)a ; 

end;

 

$$;


--
