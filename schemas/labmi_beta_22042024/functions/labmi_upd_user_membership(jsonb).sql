-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_user_membership(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_user_membership(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_user_membership(p_data jsonb, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_user_guid character varying(1000);
	v_json jsonb;
	v_sysdate timestamp;
	v_coupon_code varchar(250);
	/*
	p_data := '{
	  			"user_guid" : ""
	           }'
*/
	
begin
	select current_timestamp at time zone 'utc' 
		into   v_sysdate;
	
	select p_data->>'user_guid'
	into v_user_guid;
	
	update labmi.labmi_web_user
	set campaign_id = 1
	where user_guid = v_user_guid;
	
	if not exists(select 1 from labmi.labmi_membership_coupon_code
							  where user_guid = v_user_guid and product_id = 1 and is_used = 1) then
							  
						select coupon_code into v_coupon_code 
						from labmi.labmi_membership_coupon_code 
						where product_id = 1 and is_used = 0
						order by coupon_code_id
						limit 1;
						
						update labmi.labmi_membership_coupon_code
						set is_used = 1,
							allocated_date = v_sysdate,
							user_guid = v_user_guid
						where coupon_code = v_coupon_code and product_id = 1;
				else
						
						 
						 select coupon_code into v_coupon_code
                         from labmi.labmi_membership_coupon_code
						 where user_guid = v_user_guid and product_id = 1 and is_used = 1;	
						
				end if;
	
	
  	select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
				from (select email_id,user_full_name,v_coupon_code
							 from labmi.labmi_web_user
							 where user_guid = v_user_guid
 				 	)row 
	into v_json;
	
	p_json := v_json;
					
				
	

	p_result := 1;
	
	
	/*
	
exception
	when others then
		p_result := -1;*/
end;

$$;


--
