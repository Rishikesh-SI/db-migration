-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_pending_tran_data_r()
-- Type: FUNCTION

-- Name: labmi_get_pending_tran_data_r(); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_pending_tran_data_r(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

begin
	select array_to_json(array_agg(row)) from (
	select tracking_id from labmi.labmi_product_cart_paydetails
	where lower(order_status) in (lower('SI-Initiated') ,lower('AWAITED'),lower('INITIATED'))
		and ( response_count< 3 or response_count is null) 
		and updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc' )row
	into p_data;
	

end;

$$;


--
