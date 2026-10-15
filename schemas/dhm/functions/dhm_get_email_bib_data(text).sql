-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_email_bib_data(text)
-- Type: FUNCTION

-- Name: dhm_get_email_bib_data(text); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_email_bib_data(p_email_id text, OUT p_email_bib_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 
begin
 
 

select  row_to_json(row)
		from(
		select email_id,bib_no from dhm.dhm_user_master
             where payment_status =1
			and upper(email_id)=upper(p_email_id)
		) as row
		into p_email_bib_data;

 

  
end;
$$;


--
