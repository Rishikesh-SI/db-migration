-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_user_data_sftp(refcursor)
-- Type: FUNCTION

-- Name: labmi_v1_get_user_data_sftp(refcursor); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_user_data_sftp(p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare

begin

open p_user_cursor for
select user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state,
--(wu.created_date + '5.5 hours'::interval)::date as Website_registration_date , 
coalesce(wu.whatsapp_consent,0) as whatsapp_consent,
case campaign_id when 1 then 'Blue Tier Membership'
				 when 3 then 'Silver Tier Membership'
                  when 4 then 'Gold Tier Membership'
				  when 5 then 'Junior Tier Membership' else 'Blue Tier Membership'  end as membership_type,				  
--(pc.created_date + '5.5 hours'::interval)::date as membership_purchase_date,
p.total_price as membership_price ,name_on_card,wu.pin_code,wu.user_guid,pc.product_cart_id,
case old_campaign_id when 1 then 'Blue Tier Membership'
				 when 3 then 'Silver Tier Membership'
                  when 4 then 'Gold Tier Membership'
				  when 5 then 'Junior Tier Membership' else 'Blue Tier Membership'  end as old_membership_type,
to_char((wu.created_date + '5.5 hours'::interval)::date, 'DD-MM-YYYY') Website_registration_date,
to_char((pc.created_date + '5.5 hours'::interval)::date, 'DD-MM-YYYY') membership_purchase_date
from labmi_v1.labmi_v1_web_user wu
left join waf_master.waf_cities c on c.city_id = wu.city_id
left join waf_master.waf_states s on s.state_id = wu.state_id
left join labmi_v1.labmi_v1_product_cart_paydetails pc on  wu.user_guid = pc.user_guid and pc.order_status = 'SUCCESS'
left join labmi_v1.labmi_v1_product_cart p on pc.product_cart_id = p.product_cart_id
where client_id = 5 and wu.is_active = 1  and is_verified  = 1 and coalesce(sync_data,0) = 0
limit 30000;

end;

$$;


--
