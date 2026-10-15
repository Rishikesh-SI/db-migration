-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_delete_membership(character varying)
-- Type: FUNCTION

-- Name: labrr_delete_membership(character varying); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_delete_membership(p_user_guid character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
		
        
BEGIN

if exists (select 1 from labrr.labrr_web_user where user_guid =p_user_guid) then

delete from labrr.labrr_product_shipment_user 
where product_cart_id in 
(select product_cart_id from labrr.labrr_product_cart where user_guid=p_user_guid or user_cart_guid=p_user_guid);

delete from labrr.labrr_product_shipment_user_archive 
where product_cart_id in 
(select product_cart_id from labrr.labrr_product_cart_archive where user_guid=p_user_guid);

delete from labrr.labrr_product_cart_paydetails where user_guid=p_user_guid;
delete from labrr.labrr_product_cart_paydetails_archive where user_guid=p_user_guid;

delete from labrr.labrr_product_cart_details 
where product_cart_id in 
(select product_cart_id from labrr.labrr_product_cart where user_guid=p_user_guid or user_cart_guid=p_user_guid);
delete from labrr.labrr_product_cart_details_archive 
where product_cart_id in 
(select product_cart_id from labrr.labrr_product_cart_archive where user_guid=p_user_guid);

delete from labrr.labrr_product_cart where user_guid=p_user_guid or user_cart_guid=p_user_guid;
delete from labrr.labrr_product_cart_archive where user_guid=p_user_guid;

--update labrr.labrr_web_user set campaign_json=null,campaign_id=null,membership_code=null where user_guid=p_user_guid;

delete from labrr.labrr_web_user_membership where user_guid=p_user_guid;
	
p_result:=1;

else

p_result:=0;

end if;

END;

    

$$;


--
