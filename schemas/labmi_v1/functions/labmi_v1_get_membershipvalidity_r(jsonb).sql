-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_membershipvalidity_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_get_membershipvalidity_r(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_membershipvalidity_r(p_json jsonb, OUT p_membershipvalidity4 jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    v_mobie_no character varying(1000);
	
/*select * from labmi_v1.labmi_v1_get_membershipvalidity_r
('{"mobileno": "umy7vIQrBinGUFGEYAhjyuKmnGhG4LIJFy+zA4hhSL8="}');*/	
    
begin
	select p_json->>'mobileno' 
	into v_mobie_no;

select row_to_json (a) into p_membershipvalidity4 from
( select distinct lp.product_id as membership_type_id ,lp.product_name as membership_type_name,
	case  when lpc.expiry_date > current_timestamp at time zone 'utc' then 'true'
 	when lp.product_id=1 then 'true'
    else 'false' end as membership_type_valid
    from labmi_v1.labmi_v1_web_user lwu
    left  join labmi_v1.labmi_v1_product lp on lwu.campaign_id=lp.product_id
    join labmi_v1.labmi_v1_product_cart lpc on lwu.user_guid=lpc.user_guid
    where lwu.mobile_no = v_mobie_no
)a;

end;

$$;


--
