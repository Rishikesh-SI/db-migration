-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_series_year_wise(text)
-- Type: FUNCTION

-- Name: labhkind_get_series_year_wise(text); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_series_year_wise(p_year text, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin	
select ('{"items":'||jsonb_agg(tab)::text||'}')::jsonb into p_json
from (select 
series_id,
match_title,
match_centre_guid,
year,
match_centre_json->'data'->'media_series_files' as media_series_files
from labhkind.labhkind_match_centre
where year=p_year and is_active=1 and is_deleted=0
)tab;
exception
	when others then
    	p_json := null;   
end;

$$;


--
