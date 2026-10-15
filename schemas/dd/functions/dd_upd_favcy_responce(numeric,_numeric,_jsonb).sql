-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_upd_favcy_responce(numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: dd_upd_favcy_responce(numeric, numeric, jsonb); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_upd_favcy_responce(p_product_cart_id numeric, p_status numeric, p_status_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

	
BEGIN

        -- 0 failed ,1 success 
        
        
        
      
        update   dd.dd_product_cart_paydetails
        set favcy_responce_status=p_status,
            favcy_responce_status_json=p_status_json
       where product_cart_id=p_product_cart_id;
           
END;

    

$$;


--
