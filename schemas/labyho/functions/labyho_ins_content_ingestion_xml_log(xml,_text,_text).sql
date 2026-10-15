-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_ins_content_ingestion_xml_log(xml, text, text)
-- Type: FUNCTION

-- Name: labyho_ins_content_ingestion_xml_log(xml, text, text); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_ins_content_ingestion_xml_log(p_xml_data xml, p_url text, p_epochtime text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	if p_xml_data is not null then
		insert into labyho.labyho_content_ingestion_xml_log(log_id, xml_data, url, epochtime, log_date)
		select nextval('labyho.seq_labyho_content_ingestion_log_id'), p_xml_data, p_url, p_epochtime, current_timestamp at time zone 'utc';
		p_result := 1;
	else
		p_result := 0;
	end if;
exception
	when others then
		p_result := -1;
end;
$$;


--
