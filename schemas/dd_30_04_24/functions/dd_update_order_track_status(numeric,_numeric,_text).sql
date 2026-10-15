-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_update_order_track_status(numeric, numeric, text)
-- Type: FUNCTION

-- Name: dd_update_order_track_status(numeric, numeric, text); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_update_order_track_status(p_order_id numeric, p_order_tracking_status numeric, p_order_tracking_id text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

--v_order_tracking_status text;
begin
	
  if p_order_tracking_status is not null then 
 
  update dd.dd_product_shipment_user
  set order_tracking_status=(case when p_order_tracking_status=3 then 'Dispatch'
                                     else  'Order Closed'
                                end),
								ord_tracking_status_value=p_order_tracking_status
  where product_cart_id=p_order_id;
     p_result:=p_order_tracking_status;
  end if ;
  
  if p_order_tracking_id is not null then 
  update dd.dd_product_shipment_user
  set order_tracking_id=p_order_tracking_id
  where product_cart_id=p_order_id;
   
   p_result:=p_order_tracking_id::numeric;
   end if;
end;

$$;


--
