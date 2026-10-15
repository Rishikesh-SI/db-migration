-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_counselling_user_listing(text)
-- Type: FUNCTION

-- Name: labbsc_dev_get_counselling_user_listing(text); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_counselling_user_listing(p_email_id text, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 

begin
  

select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
		from
		(
		  select u.user_id  ,u.user_guid ,u.first_name ,u.last_name,u.email_id  
		  from  
		   labbsc_dev.labbsc_dev_web_user u
			join labbsc_dev.labbsc_dev_user_tests ut
			on ut.user_id=u.user_id
			where ut.is_attempted=1
			and ut.report_url is not null
			and u.email_id=coalesce(p_email_id,u.email_id)
		   order by u.user_id
	  
		) as row
		into p_user_json;
 

end;

 $$;


--
