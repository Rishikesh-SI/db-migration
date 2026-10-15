-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_affiliate_data_listing()
-- Type: FUNCTION

-- Name: labsaw_get_affiliate_data_listing(); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_affiliate_data_listing(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	declare

	-- p_json jsonb ;
	i record;

	begin 
	
	
	select '{"data":'||jsonb_agg(row)::text||'}'
	into p_json
	from (select a.affliate_id,a.affliate_name,a.affiliate_signup,a.affiliate_deposit,
		   a.affiliate_account_no,b.user_id,a.affliate_data_id
		  from labsaw.labsaw_affliate_data a
		  left join labsaw.labsaw_web_user b on a.user_guid = b.user_guid
		  where is_approved = 1 and is_send is null
		  order by 1 desc)row ;

	for i in 
	select b->>'affliate_data_id' as affliate_data_id from (
		select b
		from jsonb_array_elements(p_json->'data') b)as a 
		loop 

			update labsaw.labsaw_affliate_data
			set is_send = 1
			where affliate_data_id = i.affliate_data_id::numeric ;
			
		end loop;

	

	end;
	
	$$;


--
