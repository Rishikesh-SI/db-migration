-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_pending_tran_data_r()
-- Type: FUNCTION

-- Name: labrr_get_pending_tran_data_r(); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_pending_tran_data_r(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
v_tracking_id numeric;
begin

  -- update labrr.labrr_product_cart_paydetails set response_count = response_count+1 where 
    --lower(order_status) in (lower('SI-Initiated'))
	--and ( response_count< 4 or response_count is null); 
 
		--and updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc' 

	select array_to_json(array_agg(row)) from (
	select tracking_id,module_name from labrr.labrr_product_cart_paydetails
	where lower(order_status) in (lower('SI-Initiated'),lower('Awaited'))
		and ( response_count< 4 or response_count is null) 
		and updated_date + '15 minutes'::interval < current_timestamp at time zone 'utc'
        order by created_date 
		limit 30)row
		--and updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc' )row
	into p_data;

	

end;

$$;


--
