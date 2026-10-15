-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_authorid_r(jsonb)
-- Type: FUNCTION

-- Name: labuww_get_authorid_r(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_authorid_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_user_guid character varying;
v_user_id numeric;
v_author_id numeric;
begin
/*
{
   "author_guid":"da51ef77-d1f8-4526-8942-8e3512b3cc6c"
}
*/

 select    p_json->>'author_id',
		   p_json->>'author_guid'
        
into 
	v_user_id,
	v_user_guid;
	
	
	select user_id into v_author_id
	from labuww.labuww_user
	where ref_id=v_user_id
	or ref_guid=v_user_guid;
	
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
