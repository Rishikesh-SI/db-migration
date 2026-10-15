-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_email_bib_list()
-- Type: FUNCTION

-- Name: dhm_get_email_bib_list(); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_email_bib_list(OUT p_email_bib_list jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 
begin
 
 

select  array_to_json(array_agg(row))
		from(
		select email_id,bib_no from dhm.dhm_user_master
where payment_status =1
		) as row
		into p_email_bib_list;

 

  
end;
$$;


--
