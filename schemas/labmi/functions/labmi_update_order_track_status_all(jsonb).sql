-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_update_order_track_status_all(jsonb)
-- Type: FUNCTION

-- Name: labmi_update_order_track_status_all(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_update_order_track_status_all(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
--v_order_tracking_status text;
v_item json;
v_data json;
v_product_cart_id numeric;
v_service_provider character varying(200);
v_date_of_dispatch timestamp;
v_aw_bill_number character varying(200);
v_courier_status character varying(200);
v_received_by character varying(200);
v_remarks text;

begin

/*select p_json->'product_cart_id', p_json->>'service_provider',p_json->>'date_of_dispatch',
          p_json->>'aw_bill_number',p_json->>'courier_status',p_json->>'received_by',
		  p_json->>'remarks'
   into   v_product_cart_id,v_service_provider,v_date_of_dispatch,v_aw_bill_number,
          v_courier_status,v_received_by,v_remarks;*/

	select p_json->'data'
    into v_data;
raise notice '%',v_data;
  /* RAISE NOTICE '%', p_json->>'v_product_cart_id';
   RAISE NOTICE '%', p_json->>'v_service_provider';
   RAISE NOTICE '%', p_json->>'v_date_of_dispatch';
   RAISE NOTICE '%', p_json->>'v_aw_bill_number';*/
FOR v_item IN SELECT * FROM json_array_elements(v_data)
   LOOP
   
   select v_item->>'product_cart_id', v_item->>'service_provider',v_item->>'date_of_dispatch',
          v_item->>'aw_bill_number',v_item->>'courier_status',v_item->>'received_by',
		  v_item->>'remarks'
   into   v_product_cart_id,v_service_provider,v_date_of_dispatch,v_aw_bill_number,
          v_courier_status,v_received_by,v_remarks;
  
	/*RAISE NOTICE '%',v_product_cart_id;
   RAISE NOTICE '%', v_service_provider;
   RAISE NOTICE '%', v_date_of_dispatch;
   RAISE NOTICE '%', v_aw_bill_number;
   
   select 1/0;*/
 --select * from labmi.labmi_user_awb_notes_history
 
 
 
 
if exists(select 1 from labmi.labmi_product_shipment_user
				 where product_cart_id = v_product_cart_id and aw_bill_number is not null ) then
		
		
		 insert into labmi.labmi_user_awb_notes_history
		 select product_cart_id,aw_bill_number,service_provider,date_of_dispatch,
				courier_status,received_by,remarks,null,0,current_timestamp at time zone 'utc',0,current_timestamp
		 from 	labmi.labmi_product_shipment_user	
		 where 	product_cart_id=v_product_cart_id;	
 
  end if;
 
  update labmi.labmi_product_shipment_user
  set  service_provider=v_service_provider,
	   date_of_dispatch=v_date_of_dispatch,
	   aw_bill_number=v_aw_bill_number,
	   courier_status=v_courier_status,
	   received_by=v_received_by,
	   remarks=v_remarks
  where product_cart_id=v_product_cart_id;
  
   p_result:=1;  
   
   
  end loop;
  
  /*RAISE NOTICE '%',v_product_cart_id;
   RAISE NOTICE '%', v_service_provider;
   --RAISE NOTICE '%', v_date_of_dispatch;
   RAISE NOTICE '%', v_aw_bill_number;
   
   select 1/0;*/
  
  end;

$$;


--
