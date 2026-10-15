-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_get_authorid_r(jsonb)
-- Type: FUNCTION

-- Name: labtri_get_authorid_r(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_get_authorid_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_user_guid character varying;
v_user_id character varying;
v_author_id numeric;
begin
/*
{
   "author_guid":"da51ef77-d1f8-4526-8942-8e3512b3cc6c"
}
*/

 select    p_json->'data'->>'author'
        
into 
	v_user_id;
	
	
	select user_id into v_author_id
	from labtri.labtri_user
	where ref_id=v_user_id;
	
	if v_author_id is not null then
	p_data:='{
	"author_id":"'|| coalesce(v_author_id::varchar,'')||'"
	}';
	
	elseif v_author_id is null then
	p_data = null;	
	
	end if;
end;
$$;


--
