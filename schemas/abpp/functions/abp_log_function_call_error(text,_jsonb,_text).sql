-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_log_function_call_error(text, jsonb, text)
-- Type: FUNCTION

-- Name: abp_log_function_call_error(text, jsonb, text); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_log_function_call_error(p_function_name text, p_function_parameter_json jsonb, p_punction_error_text text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
	if exists(select 1 from abp.abp_site_config_parameter where parameter_name = 'log_error' and parameter_value = '1') then
		insert into abp.abp_function_call_error_log
		select p_function_name,p_function_parameter_json,p_punction_error_text,current_timestamp at time zone 'utc';
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
