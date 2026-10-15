-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_check_product_cart_ids(numeric[])
-- Type: FUNCTION

-- Name: labmi_check_product_cart_ids(numeric[]); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_check_product_cart_ids(p_product_cart_ids numeric[]) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_present jsonb;
    v_missing jsonb;
BEGIN
    
    SELECT jsonb_agg(
        jsonb_build_object(
            'product_cart_id', product_cart_id,
            'order_status', order_status,
            'invoice_id', invoice_id
        )
    )
    INTO v_present
    FROM labmi.labmi_product_cart_paydetails
    WHERE product_cart_id = ANY (p_product_cart_ids);

    
    SELECT jsonb_agg(missing_id)
    INTO v_missing
    FROM (
        SELECT unnest(p_product_cart_ids) AS missing_id
        EXCEPT
        SELECT product_cart_id
        FROM labmi.labmi_product_cart_paydetails
    ) t;

    RETURN jsonb_build_object(
        'present_product_cart_ids', COALESCE(v_present, '[]'::jsonb),
        'missing_product_cart_ids', COALESCE(v_missing, '[]'::jsonb)
    );
END;
$$;


--
