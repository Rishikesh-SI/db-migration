-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_create_partition_table(text)
-- Type: PROCEDURE

-- Name: labdms_create_partition_table(text); Type: PROCEDURE; Schema: labdms; Owner: -
--

CREATE PROCEDURE labdms.labdms_create_partition_table(IN p_table_script text)
    LANGUAGE plpgsql
    AS $$
begin
	
	execute p_table_script;
	
end;
$$;


--
