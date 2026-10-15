-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_pending_tran_data_r_17_03_2026()
-- Type: FUNCTION

-- Name: labmi_get_pending_tran_data_r_17_03_2026(); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_pending_tran_data_r_17_03_2026(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

/* output:-
[
  {
    "tracking_id": "202003111224194443",
    "order_status": "Successful"
  },
  {
    "tracking_id": "202003111224194443",
    "order_status": null
  }
]
*/

begin
/*
	select array_to_json(array_agg(row)) from (
	select tracking_id from labmi.labmi_product_cart_paydetails
	where lower(order_status) in (lower('SI-Initiated') ,lower('AWAITED'),lower('INITIATED'))
		and ( response_count< 3 or response_count is null) 
		and updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc'
	)row
	into p_data;*/
	
	 select array_to_json(array_agg(row))
from (
    select 
        tracking_id--,
       -- order_status
    from labmi.labmi_product_cart_paydetails
    where lower(order_status) in (
            lower('SI-Initiated'),
            lower('AWAITED'),
            lower('INITIATED')--,
		   -- lower('PENDING')
          ) 
      and (response_count < 3 or response_count is null)
      and updated_date + '5 minutes'::interval
          < current_timestamp at time zone 'utc'
) row
into p_data;
	

end;

$$;


--
