-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_ins_json_log(jsonb, text, text)
-- Type: FUNCTION

-- Name: labyho_ins_json_log(jsonb, text, text); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_ins_json_log(p_json jsonb, p_url text, p_epochtime text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	if p_json is not null then
		insert into labyho.labyho_json_log
		select nextval('labyho.seq_labyho_json_log_id'),p_json,p_url,p_epochtime,current_timestamp at time zone 'utc';
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
