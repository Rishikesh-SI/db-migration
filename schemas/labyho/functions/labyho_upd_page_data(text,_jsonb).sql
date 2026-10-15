-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_upd_page_data(text, jsonb)
-- Type: FUNCTION

-- Name: labyho_upd_page_data(text, jsonb); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_upd_page_data(p_schema_prefix text, p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_url text;
	v_is_amp numeric;
	v_page_id numeric;
	
begin
	
	select coalesce(substring(lower(p_json->>'url'),'(.*[^\/\s])'),''), coalesce((p_json->>'is_amp')::numeric,0)
    into v_url, v_is_amp;
	
	execute 'select page_id
				from '||$1||'.'||$1||'_page
	 			where alias = $2
				and coalesce(is_amp,0) = $3
				and is_active = 1
				and is_deleted = 0'
	into v_page_id
	using p_schema_prefix, v_url, v_is_amp;
	
	execute 'delete from '||$1||'.'||$1||'_page_data
				where page_id = $2
				and alias = $3'
	using p_schema_prefix, v_page_id, v_url;
	
	execute 'insert into '||$1||'.'||$1||'_page_data
				select $2, $3, p_page_json, current_timestamp at time zone ''utc''
				from siwaf._get_app_page_data_r($1, $4)'
	using p_schema_prefix, v_page_id, v_url, p_json;
	
-- exception
-- 	when others then
-- 		p_result := -1;
end;
$_$;


--
