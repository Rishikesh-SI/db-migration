-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_validate_user_test_payment(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_validate_user_test_payment(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_validate_user_test_payment(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_guid text;
	v_email_id text;
	v_user_id numeric;
	
begin
	
	select p_json->>'user_guid', p_json->>'email_id'
	into v_user_guid, v_email_id;
	
	if v_user_guid is not null and v_user_guid <> '' and v_email_id is not null and v_email_id <> '' then
		
		select user_id
		into strict v_user_id
		from labbsc_dev.labbsc_dev_web_user
		where user_guid = v_user_guid
		and email_id = v_email_id;

		if exists(select 1
				  from labbsc_dev.labbsc_dev_user_tests ut
				  join labbsc_dev.labbsc_dev_cart c
				  on c.cart_id = ut.cart_id
				  where ut.user_id = v_user_id
				  and ut.is_attempted = 0
				  and ut.valid_till >= current_timestamp at time zone 'utc'
				  and c.status = 2) then

			p_result := 1;

		else

			p_result := 0;

		end if;
		
	else
		
		p_result := 0;
		
	end if;
	
exception
	when no_data_found then
		p_result := -2;
	when others then
		p_result := -1;
end;
$$;


--
