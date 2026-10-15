-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_user_detail_by_service()
-- Type: FUNCTION

-- Name: labrstg_get_user_detail_by_service(); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_user_detail_by_service(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

begin

select '{"data": {"items" :'||json_agg(row_alias)||'}}'
	from (select email_id,mobile_no,first_name,last_name,client_id,user_guid,sync_status,social_id,created_date
		 from labrstg.labrstg_web_user
		 where sync_status=0
		 and email_id is not null
		 and mobile_no is not null 
		 --and is_shared_data=1 
		 limit 30)row_alias
		 into p_data;

end
$$;


--
