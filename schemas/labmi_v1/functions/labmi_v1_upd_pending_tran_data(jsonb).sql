-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_upd_pending_tran_data(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_upd_pending_tran_data(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_upd_pending_tran_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
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
					
						select response_count into v_response_count 
						from labmi_v1.labmi_v1_product_cart_paydetails
						where tracking_id = i.tracking_id::numeric;
						
						update labmi_v1.labmi_v1_product_cart_paydetails
						set response_count = coalesce(v_response_count,0) +1,
							updated_date = current_timestamp at time zone 'utc'
						where tracking_id = i.tracking_id::numeric;
						
						if exists(select 1 from labmi_v1.labmi_v1_product_cart_paydetails
								 where tracking_id = i.tracking_id::numeric and response_count > 2 ) then
							update labmi_v1.labmi_v1_product_cart_paydetails	 
							set order_status = 'CANCELLED',
							is_active=0,is_deleted=1,is_status_flag=0,
							refund_reason='awaited or trans cancel'
							where tracking_id = i.tracking_id::numeric;	 
						end if;
					else	
						
						update labmi_v1.labmi_v1_product_cart_paydetails
						set order_status = i.order_status,
							failure_message = i.response_code,
							status_code = i.status_code,
							status_message=i.status_message,
							transaction_date = to_date(left(i.transaction_timestamp,10),'YYYY-MM-DD'),
							payment_json = ('{ "data":' ||i.b || '}')::jsonb,
							updated_date = current_timestamp at time zone 'utc', 
						    is_active =  case when lower(i.order_status)=lower('SUCCESS') then 1
				 			             else 0 end 	, 
				           is_deleted = case when lower(i.order_status)=lower('SUCCESS') then 0
				 							when lower(i.order_status)in (lower('AWAITED'))then 0
				 			  				else 1 end ,
				 		   is_status_flag = case when lower(i.order_status)=lower('SUCCESS') then 1
               								when lower(i.order_status)=lower('Failed') then 2 
			   					 			else 0 end 
											
						   where tracking_id = i.tracking_id::numeric;
						   
			   if lower(i.order_status)=lower('SUCCESS') then
			   
			   	select user_guid into v_user_guid from labmi_v1.labmi_v1_product_cart_paydetails
				where tracking_id = i.tracking_id::numeric;
				
				select product_id,product_cart_id into v_product_id,v_product_cart_id from labmi_v1.labmi_v1_product_cart
				where user_guid= v_user_guid;
				
				update labmi_v1.labmi_v1_product_cart
				set expiry_date = current_timestamp at time zone 'utc' + '1 year'::interval
	    		where user_guid= v_user_guid;
				
				update labmi_v1.labmi_v1_web_user
				set campaign_id = v_product_id,
					membership_start_date = current_timestamp at time zone 'utc'
				where user_guid= v_user_guid;
				
				update labmi_v1.labmi_v1_product_cart_paydetails
				set product_cart_id=v_product_cart_id
				where tracking_id = i.tracking_id::numeric;
				
				update labmi_v1.labmi_v1_product_inventory
				set stock_quantity=stock_quantity - 1
				where product_id=v_product_id;
				
				end if;
						   
						end if;   
					
				end loop;
	
	

p_result:= 1;

end;

$$;


--
