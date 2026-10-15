-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_job_listing(character varying)
-- Type: FUNCTION

-- Name: labbsc_dev_user_job_listing(character varying); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_user_job_listing(p_user_guide character varying, OUT p_data jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_job_id numeric[];

begin

begin
select job_id into strict  v_job_id from labbsc_dev.labbsc_dev_web_user 
			                        where user_guid=p_user_guide;
select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		from (select job_profile,job_id,slug_url from 
			labbsc_dev.labbsc_dev_job_profile where job_id::int =any (v_job_id ) 
       )row
	   into p_data;
		
 p_result:=1;
exception 
    when no_data_found 
	then 
        p_result:=2;
end ;



exception
	when others 
	then
    	p_result := -1;
end;
$$;


--
