-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_pending_order_payment()
-- Type: FUNCTION

-- Name: labbsc_dev_get_pending_order_payment(); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_pending_order_payment(OUT p_pending_order_payment jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare 
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
begin
 

insert into labbsc_dev.labbsc_dev_pending_order
(order_id,created_date,cart_id,status)
select po.order_id,po.created_date,c.cart_id,1
		from	labbsc_dev.labbsc_dev_cart c
	   join labbsc_dev.labbsc_dev_purchase_order po
		on po.cart_id = c.cart_id  
	where   c.status=1
	 and po.created_date  <=v_current_timestamp - interval '15 minute'
	 and po.order_id not in 
	 (select order_id from labbsc_dev.labbsc_dev_pending_order )
	 order by po.created_date desc;

select array_to_json(array_agg(row))
		from
		(select  order_id, created_date
		from	labbsc_dev.labbsc_dev_pending_order
	 where    status=1
	 and  created_date  <=v_current_timestamp - interval '15 minute'
	 order by  created_date desc
			) as row
	into 	p_pending_order_payment;	
 

end;
$$;


--
