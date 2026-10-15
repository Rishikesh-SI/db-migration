-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_process_content_data()
-- Type: FUNCTION

-- Name: labsaw_process_content_data(); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_process_content_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    
	insert into test
	select new.asset_id,new.asset_type_id;
	
return new;
end;
$$;


--
