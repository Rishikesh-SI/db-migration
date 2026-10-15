-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_user_data_sftp_r(refcursor)
-- Type: FUNCTION

-- Name: labmi_get_user_data_sftp_r(refcursor); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_user_data_sftp_r(p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare

begin

open p_user_cursor for
select user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state,
to_char((wu.created_date + '5.5 hours'::interval)::date,'MM/DD/YYYY') as Website_registration_date , 
coalesce(wu.whatsapp_consent,0) as whatsapp_consent,
case campaign_id when 1 then 'Blue Tier Membership'
				 when 3 then 'Silver Tier Membership'
                  when 4 then 'Gold Tier Membership'
				  when 5 then 'Junior Tier Membership' end as membership_type,
				  to_char((pc.created_date + '5.5 hours'::interval)::date,'MM/DD/YYYY') as membership_purchase_date,
p.total_price as membership_price ,name_on_card,pin_code
from labmi.labmi_web_user wu
left join waf_master.waf_cities c on c.city_id = wu.city_id
left join waf_master.waf_states s on s.state_id = wu.state_id
left join labmi.labmi_product_cart_paydetails pc on  wu.user_guid = pc.user_guid and pc.order_status = 'SUCCESS'
left join labmi.labmi_product_cart p on pc.product_cart_id = p.product_cart_id
where client_id = 5 and wu.is_active = 1  and is_verified  = 1 and sync_data = 0 and campaign_id in (3,4,5)
limit 500;

end;

$$;


--
