-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_product_cart_count(character varying)
-- Type: FUNCTION

-- Name: labmi_v1_get_product_cart_count(character varying); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_product_cart_count(p_user_guid character varying, OUT p_count numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
		--v_sysdate timestamp; 
       
BEGIN

    
   select count(1) into p_count  from 
labmi_v1.labmi_v1_product_cart a 
join labmi_v1.labmi_v1_product_cart_details b on a.product_cart_id=b.product_cart_id
where a.user_cart_guid=p_user_guid
and b.is_active=1
;
     
	      
    
END;

    

$$;


--
