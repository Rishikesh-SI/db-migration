-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_email_id_r()
-- Type: FUNCTION

-- Name: labhkind_get_email_id_r(); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_email_id_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare    
begin
/*select  ('{"email_id":'||jsonb_agg(email_address)::text||'}') ::jsonb  into p_json
from labhkind.labhkind_contact
where page_flag=3;
*/
	
		select '{"data":'||json_agg(tab)||'}' from into p_json
		(select  email_address as email_id,user_guid 
		 from labhkind.labhkind_contact
		 where page_flag=3 and is_active = 1)tab ;
	
end;	
$$;


--
