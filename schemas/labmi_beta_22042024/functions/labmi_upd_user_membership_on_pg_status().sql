-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_user_membership_on_pg_status()
-- Type: FUNCTION

-- Name: labmi_upd_user_membership_on_pg_status(); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_user_membership_on_pg_status(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

begin
	p_result:=0;
	if exists(select 1 from labmi.labmi_product_cart_paydetails pcp 
			join labmi.labmi_web_user wu on wu.user_guid=pcp.user_guid
			where pcp.order_status='SUCCESS' and (wu.campaign_id is null or wu.campaign_id=1) ) then

			update labmi.labmi_web_user wu
			set campaign_id=pc.product_id,membership_start_date=pcp.updated_date
			from labmi.labmi_product_cart_paydetails pcp
			join labmi.labmi_product_cart pc on pc.product_cart_id=pcp.product_cart_id
			where pcp.order_status='SUCCESS' and (wu.campaign_id is null or wu.campaign_id=1)
			and wu.user_guid=pcp.user_guid;
			
			p_result:=1;

	end if;
end;

$$;


--
