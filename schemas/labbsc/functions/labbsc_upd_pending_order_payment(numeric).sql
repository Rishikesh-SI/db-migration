-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_upd_pending_order_payment(numeric)
-- Type: FUNCTION

-- Name: labbsc_upd_pending_order_payment(numeric); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_upd_pending_order_payment(p_order_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	 
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_cart_id numeric;
	v_user_id numeric;
	 
	
begin
	
	 
		select c.cart_id,c.user_id 
		from	labbsc.labbsc_cart c
	   join labbsc.labbsc_purchase_order po
		on po.cart_id = c.cart_id  
	where   po.order_id = p_order_id
	and c.status=1
	into v_cart_id,v_user_id;
		
		update labbsc.labbsc_cart c
		set status =-1
		 where c.cart_id = v_cart_id
		and user_id =v_user_id
		and status=1
		 ;
		
		
		p_result := 1;
		
	
	 
	
-- exception
-- 	when others then
-- 		p_result := -1;
	
end;
$$;


--
