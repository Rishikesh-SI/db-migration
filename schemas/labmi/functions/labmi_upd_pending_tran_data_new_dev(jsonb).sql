-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_upd_pending_tran_data_new_dev(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_pending_tran_data_new_dev(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_upd_pending_tran_data_new_dev(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

/*
{"data":[{
  "tracking_id": "202003111224194443",
  "order_id": "501000019298",
  "card_number": "NA",
  "transaction_txntype": "NB",
  "transaction_timestamp": "20200311122929",
  "status_message": "BOUNCED",
  "order_status": "BOUNCED",
  "response_code": "request initiated from merchant",
  "status_code": "306"
},
{
  "tracking_id": "202003111224194443",
  "order_id": "501000019298",
  "card_number": "NA",
  "transaction_txntype": "NB",
  "transaction_timestamp": "20200311122929",
  "status_message": "BOUNCED",
  "order_status": "BOUNCED",
  "response_code": "request initiated from merchant",
  "status_code": "306"
}]}

*/
   i record;
   v_response_count numeric;
   v_user_guid character varying(1000);
   v_product_id numeric;
   v_product_cart_id numeric;
 

begin

  insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'labmi.labmi_upd_pending_tran_data_new_dev','p_json',uuid_generate_v4(),p_json,current_timestamp,'labmi','logs');

/*
{
  "data": [
    {
      "order_id": "",
      "mer_amount": "",
      "card_number": "",
      "status_code": "500",
      "tracking_id": "92729",
      "order_status": "PENDING",
      "response_code": "P0030",
      "status_message": "",
      "transaction_txntype": null,
      "transaction_timestamp": ""
    }
  ]
}*/

for i in select b->>'tracking_id' tracking_id, b->>'status_message' status_message,
  b->>'order_status' order_status,
  b->>'response_code' response_code,b->>'status_code' status_code,
  b->>'transaction_timestamp' transaction_timestamp,
  b
from (
select b
from json_array_elements(p_json::json->'data') b)as a

loop

if lower(i.order_status)=lower('AWAITED') or i.order_status is null  or lower(i.order_status)=lower('INITIATED') then
raise notice 'here in 1st if';
select response_count into v_response_count
from labmi.labmi_product_cart_paydetails
where tracking_id = i.tracking_id;

update labmi.labmi_product_cart_paydetails
set response_count = coalesce(v_response_count,0) +1,
updated_date = current_timestamp at time zone 'utc'
where tracking_id = i.tracking_id;

if exists(select 1 from labmi.labmi_product_cart_paydetails
where tracking_id = i.tracking_id and response_count > 2 ) then
update labmi.labmi_product_cart_paydetails
set order_status = 'CANCELLED',
is_active=0,is_deleted=1,is_status_flag=0,
refund_reason='awaited or trans cancel'
where tracking_id = i.tracking_id;
--If payment keeps staying in awaited/initiated state for more than 2 responses, it is force-cancelled.
end if;
else
--status not awaited/Initiated/null then
raise notice 'status not awaited/Initiated/null';
update labmi.labmi_product_cart_paydetails
set order_status = i.order_status,
failure_message = i.response_code,
status_code = i.status_code,
status_message=i.status_message,
transaction_date =
        to_timestamp(i.transaction_timestamp, 'YYYYMMDDHH24MISS')::date,
payment_json = ('{ "data":' ||i.b || '}')::jsonb,
updated_date = current_timestamp at time zone 'utc',
   is_active =  case when lower(i.order_status)=lower('SUCCESS') then 1
            else 0 end ,
          is_deleted = case when lower(i.order_status)=lower('SUCCESS') then 0
  else 1 end ,
  is_status_flag = case when lower(i.order_status)=lower('SUCCESS') then 1
                --when lower(i.order_status)=lower('Failed') then 2
				--when lower(i.order_status)=lower('pending') then 0
  else 0 end

  where tracking_id = i.tracking_id;
 
  if lower(i.order_status)=lower('SUCCESS') then
 
  raise notice 'if sucess';
  select user_guid into v_user_guid from labmi.labmi_product_cart_paydetails
where tracking_id = i.tracking_id;

select product_id,product_cart_id into v_product_id,v_product_cart_id from labmi.labmi_product_cart
where user_guid= v_user_guid; --and product_cart_id=i.tracking_id::numeric;

-------------------------------------
UPDATE labmi.labmi_product_cart
SET expiry_date = current_timestamp at time zone 'utc' + '1 year'::interval,
    is_active = 1,
    is_deleted = 0
WHERE user_guid = v_user_guid
AND product_cart_id = i.tracking_id::numeric;

-- UPDATE labmi.labmi_product_cart
-- SET expiry_date = v_expiry_date,
--     is_active = 0,
--     is_deleted = 1
-- WHERE user_guid = v_user_guid
-- AND product_cart_id IS DISTINCT FROM i.tracking_id::numeric;

update labmi.labmi_web_user
set campaign_id = v_product_id,
    membership_start_date = CASE
        WHEN membership_start_date IS NULL THEN current_timestamp at time zone 'utc'
        WHEN EXTRACT(YEAR FROM membership_start_date) >= 2026 THEN membership_start_date
        WHEN EXTRACT(YEAR FROM membership_start_date) < 2026 THEN current_timestamp at time zone 'utc'
        ELSE NULL
    END,
    sync_data = 0
where user_guid = v_user_guid;

update labmi.labmi_product_cart_paydetails
set product_cart_id=v_product_cart_id
where tracking_id = i.tracking_id;

----------------------------------------
-- UPDATE labmi.labmi_product_cart_paydetails
-- SET 
--     invoice_id = v_invoice_prefix || p_tracking_id,
--     is_status_flag = 1,
--     is_active = 1,
--     is_deleted = 0,
-- product_cart_id=i.tracking_id::numeric
-- WHERE user_guid = v_user_guid
-- AND tracking_id = i.tracking_id

-- UPDATE labmi.labmi_product_cart_paydetails
-- SET order_status = 'FAILED',
--     failure_message = 'P1006',
--     status_message = NULL,
--     status_code = '500',
--     invoice_id = NULL,
--     is_status_flag = 0,
--     is_active = 0,
--     is_deleted = 1
-- WHERE user_guid = v_user_guid
-- AND tracking_id IS DISTINCT FROM i.tracking_id;
---------------------------------------------------------

update labmi.labmi_product_inventory
set stock_quantity=stock_quantity - 1
where product_id=v_product_id;

end if;
 
end if;  

end loop;

--tracking_id = i.tracking_id::numeric

p_result:= 1;

end;

$$;


--
