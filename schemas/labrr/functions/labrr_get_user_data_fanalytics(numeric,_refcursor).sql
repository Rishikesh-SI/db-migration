-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_user_data_fanalytics(numeric, refcursor)
-- Type: FUNCTION

-- Name: labrr_get_user_data_fanalytics(numeric, refcursor); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_user_data_fanalytics(p_input_id numeric, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labrr.labrr_get_user_data_fanalytics(1,'a');
fetch all in "a";
*/
declare 
v_date TIMESTAMP:= (CURRENT_TIMESTAMP - '1 day'::interval)::date;   
    
begin

/*
1 for fanalytics - new 2024 membership data
*/

if p_input_id= 1 then
    open p_user_cursor for
--    	select  ab.billing_name as full_name,
--         c.cart_json->'data'->'user_info'->>'billing_dob' as user_dob,
--         c.cart_json->'data'->'user_info'->>'billing_gender' as user_gender,
--         case when c.product_id=23 then ab.delivery_firstname else null end as junior_first_name,
--         case when c.product_id=23 then ab.delivery_lastname else null end as junior_last_name,
--         case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_dob'  else null end as junior_dob,
--         case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_gender' else null end as junior_gender,
--           ab.delivery_mobile_no as mobile_no,
--           ab.billing_user_emailid as email_id,
--           total_price as bill_amount,
--           ab.billing_address as address,
-- 		  ab.billing_state,
-- 		  ab.billing_city,
-- 		  ab.billing_country,
-- 		  ab.billing_pincode,
-- 		   p.product_name  as  membership_type,
--           b.order_status as order_status,
-- 		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
-- 		  b.bank_ref_no as transaction_id,
--           b.tracking_id::text as tracking_id,   
--           pc.description as jersey_size,
--           b.final_payment_json->'data'->>'trans_date' as transaction_date,
--           p.add_info->>'gst' as GST,
--           p.add_info->>'cgst' as CGST,
--           p.add_info->>'sgst' as SGST,
--           elements->>'membership_start_date'as membership_start_date,
-- 		  elements->>'membership_expiry_date'as membership_expiry_date,
-- 		  elements->>'membership_coupon_code'as membership_coupon_code,
-- 		  elements->>'membership_code'as membership_code,
--           ab.discount_code,
--           ab.discount_type,
--           initiated_payment_json->'data'->>'type' as service_provider
--            from labrr.labrr_product_shipment_user ab
--            join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
--            join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
-- 		   join labrr.labrr_product p on c.product_id=p.product_id
--            join labrr.labrr_product_cart_details pcd on c.product_cart_id=pcd.product_cart_id
--            left join labrr.labrr_product_customize_map pcm on pcd.product_customize_map_id=pcm.product_customize_map_id
--            left join labrr.labrr_product_customize pc on pcm.product_customize_id=pc.product_customize_id
-- 		   join labrr.labrr_web_user_membership wum on b.user_guid=wum.user_guid,
--            --join labrr.labrr_web_user wu on wum.user_guid=wu.user_guid, 
--            --join labrr.labrr_web_user_membership wum on c.user_cart_guid=wum.user_guid,
-- 		   LATERAL jsonb_array_elements(wum.campaign_json->'membership_details') AS elements
--            where lower(b.order_status) = lower('success') and
--              b.module_name='membership' and p.product_id in (21,22,23) 
--              and (elements->>'campaign_id')::int=p.product_id and
            --(b.updated_date+'5.5 hours'::interval)=v_date;
            select  ab.billing_name as full_name,
                c.cart_json->'data'->'user_info'->>'billing_dob' as user_dob,
                c.cart_json->'data'->'user_info'->>'billing_gender' as user_gender,
                  ab.delivery_mobile_no as mobile_no,
                  ab.billing_user_emailid as email_id,
                  total_price as bill_amount,
                  ab.billing_address as address,
                  ab.billing_state,
                  ab.billing_city,
                  ab.billing_country,
                  ab.billing_pincode,
                   p.product_name  as  membership_type,
                  b.order_status as order_status,
                  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
                  b.bank_ref_no as transaction_id,
                  b.tracking_id::text as tracking_id,  
                  pcd1.cartdetails_json->>'customize_name' as jersey_size, 
                  pcd2.cartdetails_json->>'customize_name' as official_rr_jersey_size, 
                  pcd2.cartdetails_json->>'jersey_name' as official_rr_jersey_name, 
                  pcd2.cartdetails_json->>'jersey_number' as official_rr_jersey_number,
                  b.final_payment_json->'data'->>'trans_date' as transaction_date,
                  p.add_info->>'gst' as GST,
                  p.add_info->>'cgst' as CGST,
                  p.add_info->>'sgst' as SGST,
                  wum.campaign_json->>'membership_start_date'as membership_start_date,
                  wum.campaign_json->>'membership_expiry_date'as membership_expiry_date,
                  wum.campaign_json->>'membership_coupon_code'as membership_coupon_code,
                  wum.campaign_json->>'membership_code'as membership_code,
                  wum.campaign_json->>'membership_pdf_path'as membership_pdf_path,
                  ab.discount_code,
                  ab.discount_type,
                  initiated_payment_json->'data'->>'type' as service_provider,
                  'Active' as "Membership Status"
                   from labrr.labrr_product_shipment_user ab
                   join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
                   join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
                   join labrr.labrr_product p on c.product_id=p.product_id
                   left join labrr.labrr_product_cart_details pcd1 on pcd1.product_cart_id=c.product_cart_id and (pcd1.cartdetails_json->>'type_id')::int<>2 and pcd1.customize_price=0
                   left join labrr.labrr_product_cart_details pcd2 on pcd2.product_cart_id=c.product_cart_id and (pcd2.cartdetails_json->>'type_id')::int<>2 and pcd2.customize_price>0
                   join labrr.labrr_web_user_membership wum on b.user_guid=wum.user_guid
                   and wum.campaign_id=c.product_id and (wum.campaign_json->>'membership_start_date')::timestamp=b.transaction_date
                   where lower(b.order_status) = lower('success') and
                     b.module_name='membership' and p.product_id in (21,22,24) 
                     and coalesce(wum.is_expiry,0)=0 
                     order by (b.updated_date+'5.5 hours'::interval)::date limit 50
                     --and b.updated_date::date=v_date
			;
end if;

end;
$$;


--
