-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_del_users_permanently(jsonb)
-- Type: FUNCTION

-- Name: labmi_del_users_permanently(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_del_users_permanently(p_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
	v_expiry_date character varying;
	v_verification_key character varying;
	v_user_guid character varying;
	p_opttype numeric:=14;
	v_platform_type numeric;
	v_device_name character varying;
	v_platform_version numeric;
	v_status numeric;
	v_message character varying;
	v_is_app numeric;
	v_ipaddress character varying;
	v_reset_key character varying;
	v_subject character varying;
	v_json_array jsonb;
	v_data jsonb;
	v_user_id numeric;
begin

select p_json->>'items' into v_json_array;
for v_data in select * from jsonb_array_elements(v_json_array)
      loop
        select v_data->>'user_guid'
	   into
	   v_user_guid;
	   
	  v_current_timestamp :=  current_timestamp at time zone 'utc';

   select  user_id into v_user_id from labmi.labmi_web_user
	where user_guid=v_user_guid
	and is_deleted = 1;
	
	insert into labmi.labmi_deleted_membership_data
	select pcp.user_guid,pcp.invoice_id,pcp.order_status,pc.total_price,pcp.created_date,
           v_current_timestamp
	from labmi.labmi_product_cart_paydetails pcp
	left join labmi.labmi_product_cart pc on pcp.product_cart_id = pc.product_cart_id
	where pcp.user_guid = v_user_guid ;
	
	insert into labmi.labmi_deleted_membership_data
	select pcp.user_guid,pcp.invoice_id,pcp.order_status,pc.total_price,pcp.created_date,
       	   v_current_timestamp
	from labmi.labmi_product_cart_paydetails_archive pcp
	left join labmi.labmi_product_cart_archive pc on pcp.product_cart_id = pc.product_cart_id
	where pcp.user_guid = v_user_guid ;
	
	delete from labmi.labmi_product_cart_details
	where product_cart_id in (select product_cart_id from labmi.labmi_product_cart
	where user_guid = v_user_guid);

	delete from labmi.labmi_product_shipment_user
	where product_cart_id in (select product_cart_id from labmi.labmi_product_cart
	where user_guid = v_user_guid) ;
	
	delete from labmi.labmi_product_cart_paydetails
	where user_guid = v_user_guid;

	delete from labmi.labmi_product_cart
	where user_guid = v_user_guid;
	
	
	delete from labmi.labmi_product_cart_details_archive
	where product_cart_id in (select product_cart_id from labmi.labmi_product_cart
	where user_guid = v_user_guid);

	delete from labmi.labmi_product_shipment_user_archive
	where product_cart_id in (select product_cart_id from labmi.labmi_product_cart
	where user_guid = v_user_guid) ;
	
	delete from labmi.labmi_product_cart_paydetails_archive
	where user_guid = v_user_guid;

	delete from labmi.labmi_product_cart_archive
	where user_guid = v_user_guid;
	

	delete from labmi.labmi_web_user
	where user_guid=v_user_guid
	and is_deleted = 1;

 end loop;
		
		   p_ures_json:= '{
		   					"status":"1"
		   				  }';
	
		   p_result := 1  ;

        	insert into labmi.labmi_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
            select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

end;
$$;


--
