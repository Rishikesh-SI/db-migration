-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_delete_membership(character varying)
-- Type: FUNCTION

-- Name: labmi_delete_membership(character varying); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_delete_membership(p_user_guid character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
		
        
BEGIN

if exists (select 1 from labmi.labmi_web_user where user_guid =p_user_guid) then

delete from labmi.labmi_product_shipment_user 
where product_cart_id in 
(select product_cart_id from labmi.labmi_product_cart where user_guid=p_user_guid);

delete from labmi.labmi_product_cart_paydetails where user_guid=p_user_guid;

delete from labmi.labmi_product_cart_details 
where product_cart_id in 
(select product_cart_id from labmi.labmi_product_cart where user_guid=p_user_guid);

delete from labmi.labmi_product_cart where user_guid=p_user_guid;

update labmi.labmi_web_user set campaign_id=1,membership_start_date=null where user_guid=p_user_guid;

-- delete from labmi.labmi_web_user_membership where user_guid=p_user_guid;
	
p_result:=1;

else

p_result:=0;

end if;

END;

    

$$;


--
