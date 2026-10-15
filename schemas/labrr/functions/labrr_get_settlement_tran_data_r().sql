-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_settlement_tran_data_r()
-- Type: FUNCTION

-- Name: labrr_get_settlement_tran_data_r(); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_settlement_tran_data_r(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
v_tracking_id numeric;
begin

  -- update labrr.labrr_product_cart_paydetails set response_count = response_count+1 where 
    --lower(order_status) in (lower('SI-Initiated'))
	--and ( response_count< 4 or response_count is null); 
 
		--and updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc' 

	select array_to_json(array_agg(row)) from (
	select pcp.tracking_id,wu.first_name,wu.last_name,pcp.product_cart_id,pcp.module_name,pcp.user_guid,wum.campaign_id,wu.email_id,       
    case when wum.campaign_id=5 and 1=(select 1 from labrr.labrr_web_user_membership
      where user_guid=pcp.user_guid and campaign_id<>5 and coalesce(is_expiry,0)=0 limit 1) then 0
      else 1 end as is_mail_sent
from labrr.labrr_product_cart_paydetails pcp 
join labrr.labrr_product_cart pc on pc.product_cart_id=pcp.product_cart_id and pc.user_guid = pcp.user_guid
join labrr.labrr_web_user_membership wum on wum.user_guid = pcp.user_guid and wum.campaign_id=pc.product_id
left join labrr.labrr_web_user wu on wu.user_guid=wum.user_guid
where 
    lower(pcp.order_status) = lower('Success') and pcp.module_name='membership'
     and pcp.user_guid is not null and coalesce(wum.is_expiry,0)=0 
	 and current_timestamp>(wum.campaign_json->>'membership_expiry_date')::timestamp+'5.5hours'::interval  
	 order by (wum.campaign_json->>'membership_expiry_date')::timestamp limit 30)row
		--and updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc' )row
	into p_data;

	

end;

$$;


--
