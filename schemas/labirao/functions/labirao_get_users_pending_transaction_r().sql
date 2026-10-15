-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_get_users_pending_transaction_r()
-- Type: FUNCTION

-- Name: labirao_get_users_pending_transaction_r(); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_get_users_pending_transaction_r(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	declare

		v_user_data jsonb;

	begin

	  			select '{"eventjinidata":'||json_agg(row)||'}' into v_user_data
				from(select a.email_id,a.user_guid,a.transaction_id,a.transaction_status,a.payment_date,
							a.transaction_guid,a.pg_transaction_id,a.order_number,b.user_full_name as user_name,
					 		c.race_category_name
					 from labirao.labirao_user_transaction a
					 left join labirao.labirao_web_user b on a.user_guid=b.user_guid
					 left join labirao.labirao_race_category c on a.race_category_id = c.race_category_id
					 where a.transaction_status= 'Pending' )row;
	  
	p_user_data := v_user_data;
	
	exception when others then 
		p_user_data:='{}';
	end ; 

	$$;


--
