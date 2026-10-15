-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_institute_category_listing_bak()
-- Type: FUNCTION

-- Name: spz_get_institute_category_listing_bak(); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_institute_category_listing_bak(OUT p_instcategory_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	select ('{"institute_category":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb 
    into p_instcategory_json
	from (select institute_category_id, category_name, parent_id from spz.spz_institute_category i
          order by 1
         )row;
end;

$$;


--
