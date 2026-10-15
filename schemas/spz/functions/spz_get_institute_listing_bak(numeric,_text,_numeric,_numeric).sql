-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_institute_listing_bak(numeric, text, numeric, numeric)
-- Type: FUNCTION

-- Name: spz_get_institute_listing_bak(numeric, text, numeric, numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_institute_listing_bak(p_city_id numeric, p_search text, p_page_number numeric, p_item_number numeric, OUT p_institute_count numeric, OUT p_institute_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	v_from_row_number numeric;
    v_to_row_number numeric;
	v_search text := lower(p_search);
	v_search_query text := ' ';
begin
	v_from_row_number := (p_page_number * p_item_number - (p_item_number - 1));
    v_to_row_number := (p_page_number * p_item_number);
	if v_search is not null then
		v_search_query := ' and lower(institute_name) like ''%''||'||'$1'||'||''%'' ';
	end if;
    execute 'select count(1) from spz.spz_institute_master
    			where city_id = case '||p_city_id||' when 0 then city_id else '||p_city_id||' end'
				||v_search_query
	into p_institute_count
	using v_search;
	execute 'select (''{"institutes":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::jsonb
				from (select *
                		from (select *, row_number() over(order by institute_name) slno from spz.spz_institute_master
                        		where city_id = case '||p_city_id||' when 0 then city_id else '||p_city_id||' end'
                                ||v_search_query||')tab
						where slno between $2 and $3)row'
	into p_institute_json
	using v_search, v_from_row_number, v_to_row_number;
end;

$_$;


--
