-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_upd_settlement_tran_data(jsonb)
-- Type: FUNCTION

-- Name: labrr_upd_settlement_tran_data(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_upd_settlement_tran_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
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

for i in select b->>'tracking_id' tracking_id, b->>'user_guid' user_guid, b->>'product_cart_id' product_cart_id, b->>'campaign_id' campaign_id
				from (
				select b
				from json_array_elements(p_json::json->'data') b)as a 

				loop
                v_product_id:=i.campaign_id;
                v_product_cart_id:=i.product_cart_id;
                
                if((i.user_guid is not null or i.user_guid<>'') and v_product_cart_id is not null and v_product_id is not null) then
                
				insert into labrr.labrr_product_cart_archive (select * from labrr.labrr_product_cart where product_cart_id = v_product_cart_id and user_guid=i.user_guid);
				insert into labrr.labrr_product_shipment_user_archive (select * from labrr.labrr_product_shipment_user where product_cart_id = v_product_cart_id);	
				insert into labrr.labrr_product_cart_details_archive (select * from labrr.labrr_product_cart_details where product_cart_id = v_product_cart_id);
				insert into labrr.labrr_product_cart_paydetails_archive (select * from labrr.labrr_product_cart_paydetails where product_cart_id = v_product_cart_id and user_guid=i.user_guid);
				
				update labrr.labrr_product_cart_paydetails set user_guid=null where user_guid=i.user_guid and product_cart_id = v_product_cart_id;
				update labrr.labrr_product_cart set user_guid=null where user_guid=i.user_guid and product_cart_id = v_product_cart_id;
				update labrr.labrr_web_user_membership set is_expiry=1 where user_guid=i.user_guid and campaign_id=v_product_id;
                      
				end if;
                
                end loop;
	
	

p_result:= 1;

end;

$$;


--
