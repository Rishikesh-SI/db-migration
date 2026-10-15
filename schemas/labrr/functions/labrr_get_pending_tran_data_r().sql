-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_pending_tran_data_r()
-- Type: FUNCTION

-- Name: labrr_get_pending_tran_data_r(); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_pending_tran_data_r(OUT p_data jsonb) RETURNS jsonb
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
	select pcp.tracking_id,pcp.module_name,u.product_shipment_user_id, u.product_cart_id, u.delivery_name,
           u.delivery_address, u.delivery_pincode as delivery_zip, u.delivery_mobile_no as delivery_tel,
    		u.is_shipment_billing_address_same,u.delivery_email,u.discount_code as offer_code,u.discount_type as offer_type,
		u.billing_name, u.billing_address,u.delivery_state ,u.delivery_city,
		u.billing_pincode as billing_zip, u.billing_mobile_no as billing_tel,u.billing_state,u.billing_city,
		u.billing_user_emailid as billing_email,u.billing_country,u.delivery_country,
            (pc.total_price + pc.delivery_charges + (case when lower(u.delivery_country)='nepal' then 300 else 0 end )) bill_amount,
          -- ps.product_price as total_amount, 
           pc.cart_json->'data'->>'membership_intiated_from' as membership_intiated_from,
		   case when pc.total_price::text ilike '%.00' then replace(pc.total_price::text,'.00','.0')
         when pc.total_price::text ilike '%.10' then replace(pc.total_price::text,'.10','.1')
           when pc.total_price::text ilike '%.20' then replace(pc.total_price::text,'.20','.2')
           when pc.total_price::text ilike '%.30' then replace(pc.total_price::text,'.30','.3')
           when pc.total_price::text ilike '%.40' then replace(pc.total_price::text,'.40','.4')
           when pc.total_price::text ilike '%.50' then replace(pc.total_price::text,'.50','.5')
           when pc.total_price::text ilike '%.60' then replace(pc.total_price::text,'.60','.6')
           when pc.total_price::text ilike '%.70' then replace(pc.total_price::text,'.70','.7')
           when pc.total_price::text ilike '%.80' then replace(pc.total_price::text,'.80','.8')
           when pc.total_price::text ilike '%.90' then replace(pc.total_price::text,'.90','.9')
            else pc.total_price::text end as amount,
           pcp.tracking_id::text,
           u.currency,
           pc.user_cart_guid,--wu.mobile_no, wu.email_id,
           pcp.order_status,
           coalesce(pcp.response_count,0) as response_count,
		   case when lower(pcp.order_status) in ('si-initiated','success','awaited') then 0
		   		else 1 end as process_payment,
         product_name as product_info
        
        from 
        labrr.labrr_product_cart_paydetails pcp
        join labrr.labrr_product_shipment_user u on u.product_cart_id=pcp.product_cart_id
        join labrr.labrr_product_cart pc on pc.product_cart_id=pcp.product_cart_id
        join labrr.labrr_product pp on  pp.product_id = pc.product_id
	where lower(pcp.order_status) in (lower('SI-Initiated'),lower('Awaited'))
		and ( pcp.response_count< 3 or pcp.response_count is null) 
		and pcp.updated_date + '9 minutes'::interval < current_timestamp at time zone 'utc'
--  		and pcp.user_guid='af130137-457b-42af-9548-42a8ab9cf392'
        --'652a3751-e40e-4509-966a-70bcf8ac12d7'
        order by pcp.created_date 
		
		)row
		--and updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc' )row
	into p_data;

	

end;

$$;


--
