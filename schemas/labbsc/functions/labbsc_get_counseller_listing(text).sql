-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_counseller_listing(text)
-- Type: FUNCTION

-- Name: labbsc_get_counseller_listing(text); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_counseller_listing(p_email_id text, OUT p_counseller_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 

begin
  

select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
		from
		(
		  select u.user_id as counseller_id 
	 
		 ,u.display_name as counseller_name,u.email_id as counseller_email_id
		 
		 from  
		   labbsc.labbsc_user u
			 join labbsc.labbsc_user_role ur
			 on ur.user_id=u.user_id
			 where ur.role_id=25
			and u.email_id=coalesce(p_email_id,u.email_id)
		   order by u.display_name
	  
		) as row
		into p_counseller_json;
 

end;

 $$;


--
