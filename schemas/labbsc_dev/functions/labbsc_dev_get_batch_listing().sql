-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_batch_listing()
-- Type: FUNCTION

-- Name: labbsc_dev_get_batch_listing(); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_batch_listing(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

	begin
    
	select '{ "data" : '||json_agg(row_to_json(tab))||'}' into p_json	from		
	(select batch_id,batch_name,batch_date::date as batch_date,batch_time,
		   mentor_name_1,mentor_email_id_1,mentor_name_2,mentor_email_id_2,available_slots as slots,
	 	   position
	from labbsc_dev.labbsc_dev_batch
	order by position
	)tab	;

	end;
$$;


--
