-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _del_thumbnail(character varying, jsonb)
-- Type: FUNCTION

-- Name: _del_thumbnail(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._del_thumbnail(p_schema character varying, p_thumbnail_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

i record;

begin

	for i in select b->>'gallery_id' as gallery_id, b->>'user_guid' as user_guid
	from (select b
		  from jsonb_array_elements(p_thumbnail_json->'data') b)as a 
	loop 
            execute
			'update labmi.labmi_gallery
			set is_active=0, is_deleted=1
			where gallery_id = ' ||i.gallery_id::numeric || ' 
			and user_guid = '''|| i.user_guid ||'';

	end loop ;
	
	p_result := 1;
	
	exception
		when others then
			p_result := -1;

end;
$$;


--
