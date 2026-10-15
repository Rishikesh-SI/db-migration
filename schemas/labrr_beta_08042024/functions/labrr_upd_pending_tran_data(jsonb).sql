-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_upd_pending_tran_data(jsonb)
-- Type: FUNCTION

-- Name: labrr_upd_pending_tran_data(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_upd_pending_tran_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
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
   v_transaction_timestamp timestamp;

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
                
                        if i.transaction_timestamp is null then
                          v_transaction_timestamp:=current_timestamp+'5.5 hours'::interval;
                        else 
                           v_transaction_timestamp:=to_char(to_timestamp(i.transaction_timestamp,'dd-mm-yyyy HH24:MI:SS'), 'yyyy-mm-dd HH24:MI:SS')::timestamp;
                        end if;
                        
					--raise notice '%',i.transaction_timestamp;
					--if lower(i.order_status)=lower('SI-Initiated') then --or i.order_status is null then
					
						select response_count into v_response_count 
						from labrr.labrr_product_cart_paydetails
						where tracking_id = i.tracking_id::numeric;
						
						update labrr.labrr_product_cart_paydetails
						set response_count = coalesce(v_response_count,0) +1,
                            status_code = status_code,
							updated_date = current_timestamp at time zone 'utc'
						where tracking_id = i.tracking_id::numeric
                        and current_timestamp>created_date+'15 minutes'::interval;
						
						if v_response_count >= 2 then
						
							update labrr.labrr_product_cart_paydetails
							set order_status = 'FAILURE',
								failure_message = 'N',
								status_code = status_code,
								status_message = 'Response not recieved',
								transaction_date = v_transaction_timestamp,
								final_payment_json = ('{ "data":' ||i.b || '}')::jsonb,
								updated_date = current_timestamp at time zone 'utc', 
								is_active =  0	, 
							   is_deleted = 1 ,
							   is_status_flag = 2											
							   where tracking_id = i.tracking_id::numeric;
						
						
						end if;
					/*	
					else	
						
						update labrr.labrr_product_cart_paydetails
						set failure_message = i.response_code,
							--order_status = i.order_status,
							status_code = i.status_code,
							status_message=i.status_message,
							transaction_date = i.transaction_timestamp,
							--payment_json = ('{ "data":' ||i.b || '}')::jsonb,
							updated_date = current_timestamp at time zone 'utc', 
						    is_active =  case when lower(i.order_status)=lower('SUCCESS') then 1
				 			             else 0 end, 
				           is_deleted = case when lower(i.order_status)=lower('SUCCESS') then 0
				 							when lower(i.order_status)in (lower('AWAITED'))then 0
				 			  				else 1 end,
				 		   is_status_flag = case when lower(i.order_status)=lower('SUCCESS') then 1
               								when lower(i.order_status)=lower('Failed') then 2 
			   					 			else 0 end 
											
						   where tracking_id = i.tracking_id::numeric;
				
						   
				end if;   
					*/
				end loop;
	
	

p_result:= 1;

end;

$$;


--
