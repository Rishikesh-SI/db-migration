-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_upd_user_membership_on_pg_status()
-- Type: FUNCTION

-- Name: labmi_v1_upd_user_membership_on_pg_status(); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_upd_user_membership_on_pg_status(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

begin
p_result:=0;
if exists(select 1 from labmi_v1.labmi_v1_product_cart_paydetails pcp
join labmi_v1.labmi_v1_web_user wu on wu.user_guid=pcp.user_guid
where pcp.order_status='SUCCESS' and (wu.campaign_id is null or wu.campaign_id=1) ) then

update labmi_v1.labmi_v1_web_user wu
set campaign_id=pc.product_id,membership_start_date=pcp.updated_date,sync_data = 0
from labmi_v1.labmi_v1_product_cart_paydetails pcp
join labmi_v1.labmi_v1_product_cart pc on pc.product_cart_id=pcp.product_cart_id
where pcp.order_status='SUCCESS' and (wu.campaign_id is null or wu.campaign_id=1)
and wu.user_guid=pcp.user_guid;

p_result:=1;

end if;
end;
$$;


--
