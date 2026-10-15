-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_placed_users()
-- Type: FUNCTION

-- Name: labbsc_dev_get_placed_users(); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_placed_users(OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
 
v_json jsonb;

begin

select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
		from
		( select candidate_name,
		 role_name ,
		 company_name
		 from labbsc_dev.labbsc_dev_placed_user
		 order by created_date desc
		 ) as row 
		 into p_user_json;
		 		 
		 
		 
		 end;
		 $$;


--
