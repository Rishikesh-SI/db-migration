-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_product_cart_count(character varying)
-- Type: FUNCTION

-- Name: dd_get_product_cart_count(character varying); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_product_cart_count(p_user_guid character varying, OUT p_count numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
		--v_sysdate timestamp; 
       
BEGIN

    
   select count(1) into p_count  from 
dd.dd_product_cart a 
join dd.dd_product_cart_details b on a.product_cart_id=b.product_cart_id
where a.user_cart_guid=p_user_guid
and b.is_active=1
;
     
	      
    
END;

    

$$;


--
