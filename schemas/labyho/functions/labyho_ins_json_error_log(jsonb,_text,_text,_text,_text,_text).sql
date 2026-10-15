-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_ins_json_error_log(jsonb, text, text, text, text, text)
-- Type: FUNCTION

-- Name: labyho_ins_json_error_log(jsonb, text, text, text, text, text); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_ins_json_error_log(p_json jsonb, p_error text, p_title text, p_url text, p_error_guid text, p_error_type text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	if p_error is not null then
		insert into labyho.labyho_json_error_log
		select nextval('labyho.seq_labyho_json_error_log_id'),p_json,p_error,p_title,p_url,p_error_guid,current_timestamp at time zone 'utc',p_error_type;
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
