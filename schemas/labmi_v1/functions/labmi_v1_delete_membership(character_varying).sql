-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_delete_membership(character varying)
-- Type: FUNCTION

-- Name: labmi_v1_delete_membership(character varying); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_delete_membership(p_user_guid character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
		
        
BEGIN

if exists (select 1 from labmi_v1.labmi_v1_web_user where user_guid =p_user_guid) then

delete from labmi_v1.labmi_v1_product_shipment_user 
where product_cart_id in 
(select product_cart_id from labmi_v1.labmi_v1_product_cart where user_guid=p_user_guid);

delete from labmi_v1.labmi_v1_product_cart_paydetails where user_guid=p_user_guid;

delete from labmi_v1.labmi_v1_product_cart_details 
where product_cart_id in 
(select product_cart_id from labmi_v1.labmi_v1_product_cart where user_guid=p_user_guid);

delete from labmi_v1.labmi_v1_product_cart where user_guid=p_user_guid;

update labmi_v1.labmi_v1_web_user set campaign_id=1,membership_start_date=null where user_guid=p_user_guid;

-- delete from labmi_v1.labmi_v1_web_user_membership where user_guid=p_user_guid;
	
p_result:=1;

else

p_result:=0;

end if;

END;

    

$$;


--
