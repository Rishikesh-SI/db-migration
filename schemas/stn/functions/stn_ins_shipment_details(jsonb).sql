-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_ins_shipment_details(jsonb)
-- Type: FUNCTION

-- Name: stn_ins_shipment_details(jsonb); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_ins_shipment_details(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

/*
{
  "data": {
    "shipment_name": null,
    "shipment_address1": null,
    "shipment_address2": null,
    "shipment_state": null,
    "shipment_city": null,
    "shipment_pincode": null,
    "shipment_mobile_no": null,
    "is_shipment_billing_address_same": null,
    "billing_name": null,
    "billing_address1": null,
    "billing_address2": null,
    "billing_state": null,
    "billing_city": null,
    "billing_pincode": null,
    "billing_mobile_no": null,
    "prmocode": null,
    "bill_amount": null,
    "fees": null,
    "taxes": null,
    "deductions": null,
    "total_amount": null,
    "team_id": null
  }
}
*/
declare
	
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
    v_json jsonb := p_json;
    v_shipment_name text;
    v_shipment_address1 text;
    v_shipment_address2 text;
    v_shipment_state text;
    v_shipment_city text;
    v_shipment_pincode text;
    v_shipment_mobile_no text;
    v_is_shipment_billing_address_same numeric;
    v_billing_address1 text;
    v_billing_address2 text;
    v_billing_state text;
    v_billing_city text;
    v_billing_pincode text;
    v_billing_mobile_no text;
    v_promocode text;
    v_bill_amount numeric;
    v_fees numeric;
    v_taxes numeric;
    v_deductions numeric;
    v_total_amount numeric;
    v_team_id numeric;
    v_user_id numeric;
    
begin
	
    select v_json->'data'->>'shipment_name',
    		v_json->'data'->>'shipment_address1',
            v_json->'data'->>'shipment_address2',
            v_json->'data'->>'shipment_state',
            v_json->'data'->>'shipment_city',
            v_json->'data'->>'shipment_pincode',
            v_json->'data'->>'shipment_mobile_no',
            v_json->'data'->>'is_shipment_billing_address_same',
            v_json->'data'->>'billing_name',
            v_json->'data'->>'billing_address1',
            v_json->'data'->>'billing_address2',
            v_json->'data'->>'billing_state',
            v_json->'data'->>'billing_city',
            v_json->'data'->>'billing_pincode',
            v_json->'data'->>'billing_mobile_no',
            v_json->'data'->>'prmocode',
            v_json->'data'->>'bill_amount',
            v_json->'data'->>'fees',
            v_json->'data'->>'taxes',
            v_json->'data'->>'deductions',
            v_json->'data'->>'total_amount',
            v_json->'data'->>'team_id',
            v_json->'data'->>'user_id'
	into v_shipment_name,
    		v_shipment_address1,
            v_shipment_address2,
            v_shipment_state,
            v_shipment_city,
            v_shipment_pincode,
            v_shipment_mobile_no,
            v_is_shipment_billing_address_same,
            v_billing_address1,
            v_billing_address2,
            v_billing_state,
            v_billing_city,
            v_billing_pincode,
            v_billing_mobile_no,
            v_promocode,
            v_bill_amount,
            v_fees,
            v_taxes,
            v_deductions,
            v_total_amount,
            v_team_id,
            v_user_id;
    
    if exists(select 1 from stn.stn_team_info where team_id = v_team_id and user_id = v_user_id) then
    	
    	if not exists(select 1 from stn.stn_shipment_info where team_id = v_team_id and user_id = v_user_id) then
        	
        	insert into stn.stn_shipment_info(shipment_id,shipment_name,shipment_address1,shipment_address2,shipment_state,shipment_city,
                                                      shipment_pincode,shipment_mobile_no,is_shipment_billing_address_same,billing_name,
                                                      billing_address1,billing_address2,billing_state,billing_city,billing_pincode,billing_mobile_no,
                                                      promocode,bill_amount,fees,taxes,deductions,total_amount,team_id,created_date,updated_date,
                                                      is_active,is_deleted,shipment_guid)
            select nextval('stn.seq_stn_shipment_id'),v_shipment_name,v_shipment_address1,v_shipment_address2,v_shipment_state,v_shipment_city,
            		v_shipment_pincode,v_shipment_mobile_no,v_is_shipment_billing_address_same,v_billing_name,v_billing_address1,v_billing_address2,
                    v_billing_state,v_billing_city,v_billing_pincode,v_billing_mobile_no,v_promocode,v_bill_amount,v_fees,v_taxes,v_deductions,
                    v_total_amount,v_team_id,v_current_timestamp,v_current_timestamp,1,0,uuid_generate_v4();
			
        	p_result := 1;
            
		else
        	
        	p_result := 0;
            
    	end if;
        
	else
    	
    	p_result := -1;
        
    end if;
    
end;

$$;


--
