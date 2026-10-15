-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_product_discount()
-- Type: FUNCTION

-- Name: labmi_get_product_discount(); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_product_discount(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare
	
	begin
		
		select ('{ "data" : '|| json_agg(row_to_json(row)) || '}')::jsonb
		from (select pd.from_product_id,pd.to_product_id,pd.discount,pd.gst_amt,pd.base_amt ,
			  		 p1.product_name as from_product_name,p2.product_name as to_product_name,
			         case old_user when 1 then 'Old User' when 0 then 'New User' end as user_type,
			  		 old_user
			  from labmi.labmi_product_discount pd
			  left join labmi.labmi_product p1 on pd.from_product_id = p1.product_id
			  left join labmi.labmi_product p2 on pd.to_product_id = p2.product_id
			  where pd.is_active = 1
			 ) row
	    into p_data;
		

	end;

	$$;


--
