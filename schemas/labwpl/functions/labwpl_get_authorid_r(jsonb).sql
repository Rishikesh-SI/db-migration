-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_get_authorid_r(jsonb)
-- Type: FUNCTION

-- Name: labwpl_get_authorid_r(jsonb); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl.labwpl_get_authorid_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_email_id character varying;
v_author_id numeric;
begin
/*
{
   "author_guid":"da51ef77-d1f8-4526-8942-8e3512b3cc6c"
}
*/

 select    p_json->>'author_email'       
into 
	v_email_id;
	
	
	select user_id into v_author_id
	from labwpl.labwpl_user
	where email_id=v_email_id;
	
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
