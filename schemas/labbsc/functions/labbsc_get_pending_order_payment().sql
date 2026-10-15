-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_pending_order_payment()
-- Type: FUNCTION

-- Name: labbsc_get_pending_order_payment(); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_pending_order_payment(OUT p_pending_order_payment jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare 
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
begin

select array_to_json(array_agg(row))
		from
		(select po.order_id,po.created_date
		from	labbsc.labbsc_cart c
	   join labbsc.labbsc_purchase_order po
		on po.cart_id = c.cart_id  
	where   c.status=1
	 and po.created_date  <=v_current_timestamp - interval '10 minute'
	 order by po.created_date desc
			) as row
	into 	p_pending_order_payment;	
 

end;
$$;


--
