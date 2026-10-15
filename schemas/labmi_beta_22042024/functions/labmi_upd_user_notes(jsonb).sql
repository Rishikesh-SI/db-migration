-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_user_notes(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_user_notes(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_user_notes(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
 

declare 
/*
{
"data": [{
"product_cart_id": "" , 
"customer_note": "",
"note_status": "" ,
"updated_by": "" 
}]
}
*/
		   v_product_cart_id numeric;
		   v_customer_note text;
		   v_note_status numeric;
		   v_updated_by numeric;
		   i record;
		
begin
	
	/*select p_json->'data'->>'product_cart_id',
		   p_json->'data'->>'customer_note',
		   p_json->'data'->>'note_status',
		   p_json->'data'->>'updated_by'		   
	into   v_product_cart_id,
		   v_customer_note,
		   v_note_status,
		   v_updated_by;*/
		   
	for i in select b->>'product_cart_id' product_cart_id, b->>'customer_note' customer_note,
					   b->>'note_status' note_status, 
					   b->>'updated_by' updated_by
				from (select b from json_array_elements(p_json::json->'data') b)as a 	   
	loop	  
	
	if exists(select 1 from labmi.labmi_product_cart_paydetails
				 where product_cart_id = i.product_cart_id::numeric and customer_note is not null ) then
				 
	insert into labmi.labmi_user_awb_notes_history
	select product_cart_id,null,null,null,null,null,null,customer_note,
			note_status,current_timestamp at time zone 'utc',note_updated_by,note_updated_date
	from labmi.labmi_product_cart_paydetails
	where product_cart_id = i.product_cart_id::numeric;
	
	end if;
	
	update labmi.labmi_product_cart_paydetails
	set customer_note =  i.customer_note,
		note_status = i.note_status::numeric,
		note_updated_by = i.updated_by::numeric,
		note_updated_date = current_timestamp at time zone 'utc'
	where product_cart_id = i.product_cart_id::numeric;	
	
	end loop;
	
	p_result := 1;
		
	
end;

 
$$;


--
