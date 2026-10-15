-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_membershipdetails_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_get_membershipdetails_r(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_membershipdetails_r(p_json jsonb, OUT p_membershipdetail2 jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	v_mobile_no character varying(1000);
	
	/* input of function:-
	
	select * from labmi.labmi_get_membershipdetails_r( 
	'{"mobileno": "umy7vIQrBinGUFGEYAhjyuKmnGhG4LIJFy+zA4hhSL8="}') */
begin
	select p_json->>'mobileno' into v_mobile_no;
    
	
	select row_to_json (a) 
	into  p_membershipdetail2 
	from (select  user_full_name as name,gender ,dob ,lp.product_id as membership_type_id,
				  lp.product_name as membership_type_name, membership_start_date::date as member_since  
				  from labmi.labmi_web_user lwu
				  join labmi.labmi_product_cart lpc
					  on lwu.user_guid=lpc.user_guid and lwu.campaign_id=lpc.product_id
				  join labmi.labmi_product lp
					  on lpc.product_id=lp.product_id
				  where lwu.mobile_no=v_mobile_no)a;
			  
end;

$$;


--
