-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_del_thumbnail(jsonb)
-- Type: FUNCTION

-- Name: labkxip_del_thumbnail(jsonb); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_del_thumbnail(p_thumbnail_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

i record;

begin

	for i in select b->>'gallery_id' as gallery_id, b->>'user_guid' as user_guid
	from (select b
		  from jsonb_array_elements(p_thumbnail_json->'data') b)as a 
	loop 

			update labkxip.labkxip_gallery
			set is_active=0, is_deleted=1
			where gallery_id =i.gallery_id::numeric and user_guid=i.user_guid;

	end loop ;
	
	p_result := 1;
	
	exception
		when others then
			p_result := -1;

end;
$$;


--
