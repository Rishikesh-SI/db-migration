-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_membershipquota_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_get_membershipquota_r(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_membershipquota_r(p_json jsonb, OUT p_membershipquota3 jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    v_plan_id numeric;
	
/*select * from labmi_v1.labmi_v1_get_membershipquota_r('{"plan_id":"3"}');*/	
    
begin
	select p_json->>'plan_id' 
	into v_plan_id;
	   

select row_to_json (a)  into p_membershipquota3 from
(
/*select lp.product_id as membership_type_id ,lp.product_name as membership_type_name,
500 as membership_type_remaining_qty from  labmi_v1.labmi_v1_product
where product_id=3*/
select lp.product_id as membership_type_id ,lp.product_name as membership_type_name, lpi.stock_quantity 
as membership_type_remaining_qty from labmi_v1.labmi_v1_product lp 
join labmi_v1.labmi_v1_product_inventory lpi on lp.product_id=lpi.product_id
where lp.product_id=v_plan_id)a;
end;

$$;


--
