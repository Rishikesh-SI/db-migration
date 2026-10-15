-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_membership_mail_data_15012025()
-- Type: FUNCTION

-- Name: labmi_v1_membership_mail_data_15012025(); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_membership_mail_data_15012025(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	 declare
	
	   v_json jsonb;
	   v_new_user_data jsonb;
	   v_verified_blue_memberships numeric;
	   v_total_blue_memberships numeric;
	   v_verified_blue_memberships_previos numeric;
	   v_total_blue_memberships_previos numeric;
	   v_overall_verified_blue_memberships numeric;
	   v_overall_blue_memberships numeric;
	   v_total_membershp jsonb;

	 begin

--MI Membership Live date changes 2025-01-14 19:30:00 on 26-02-2024

	 truncate table labmi_v1.labmi_v1_membership_data_temp;
			 
			 insert into labmi_v1.labmi_v1_membership_data_temp
			 select  case coalesce (old_campaign_id,1) when 1 then 'Blue'
					when 3 then 'Silver' when 4 then 'Gold' when 5 then 'Junior' end as old,
					case left(p.invoice_id,3) when 'GTM' then 'Gold'
					when 'STM' then 'Silver' 
					when 'JTM' then 'Junior' end as new,wu.created_date as user_created_date,
					p.created_date as membership_created_date
			  from  labmi_v1.labmi_v1_web_user wu
			  left join labmi_v1.labmi_v1_product_cart_paydetails p on wu.user_guid=p.user_guid
			  where wu.is_verified = 1 and p.order_status = 'SUCCESS';
			 
			 select ('{ "old_user" : '|| json_agg(row_to_json(row)) || '}')::jsonb into v_json
			from 
			(select type,total_membership_till_day,last_day,(total_membership_till_day -last_day) total_membership
			from(select type,sum(total_membership) as total_membership_till_day,sum(last_day) as last_day
				from
					(select old||'_'||new as type,count(1) as total_membership,0 as last_day from labmi_v1.labmi_v1_membership_data_temp
					where user_created_date < ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval)  --2022-03-14 12:30:00
					group by 1,3
					union all
					select old||'_'||new,0 as total_membership,count(1) as last_day from labmi_v1.labmi_v1_membership_data_temp
					where user_created_date < ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval) --2022-03-14 12:30:00
					and membership_created_date between (current_timestamp at time zone 'utc') - '1 day'::interval and current_timestamp at time zone 'utc'
					group by 1,2)a
				group by 1)b

				)row;
				
			select json_agg(row_to_json(row))::jsonb into v_new_user_data
			from 
			(select type,total_membership_till_day,last_day,(total_membership_till_day -last_day) total_membership
			from(select type,sum(total_membership) as total_membership_till_day,sum(last_day) as last_day
				from
					(select old||'_'||new as type,count(1) as total_membership,0 as last_day from labmi_v1.labmi_v1_membership_data_temp
					where user_created_date > ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval)
					group by 1,3
					union all
					select old||'_'||new,0 as total_membership,count(1) as last_day from labmi_v1.labmi_v1_membership_data_temp
					where user_created_date > ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval)
					and membership_created_date between (current_timestamp at time zone 'utc') - '1 day'::interval and current_timestamp at time zone 'utc'
					group by 1,2)a
				group by 1)b

				)row  ;
				
			select json_agg(row_to_json(row))::jsonb into v_total_membershp
			from 
			(select type,total_membership_till_day,last_day,(total_membership_till_day -last_day) total_membership
			from(select type,sum(total_membership) as total_membership_till_day,sum(last_day) as last_day
				from
					(select new as type,count(1) as total_membership,0 as last_day from labmi_v1.labmi_v1_membership_data_temp
					group by 1,3
					union all
					select new,0 as total_membership,count(1) as last_day from labmi_v1.labmi_v1_membership_data_temp
					where  membership_created_date between (current_timestamp at time zone 'utc') - '1 day'::interval and current_timestamp at time zone 'utc'
					group by 1,2)a
				group by 1)b

				)row  ;	
				
				
			select count(1) into  v_verified_blue_memberships from labmi_v1.labmi_v1_web_user
			where is_verified = 1 and client_id = 5 and campaign_id = 1 and created_date > ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval);

			select count(1) into v_total_blue_memberships from labmi_v1.labmi_v1_web_user
			where  campaign_id = 1 and client_id = 5 and created_date > ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval);

			select count(1) into  v_verified_blue_memberships_previos from labmi_v1.labmi_v1_web_user
			where is_verified = 1 and client_id = 5 and campaign_id = 1 
			and created_date > ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval)
			and created_date between (current_timestamp at time zone 'utc') - '1 day'::interval and current_timestamp at time zone 'utc';

			select count(1) into v_total_blue_memberships_previos from labmi_v1.labmi_v1_web_user
			where  campaign_id = 1 and client_id = 5 and created_date > ('2025-01-14 00:00:00'::timestamp - '5.5 hours'::interval)
			and created_date between (current_timestamp at time zone 'utc') - '1 day'::interval and current_timestamp at time zone 'utc';

			select count(1) into  v_overall_verified_blue_memberships from labmi_v1.labmi_v1_web_user
			where is_verified = 1 and campaign_id = 1 and client_id = 5;
			
			select count(1) into v_overall_blue_memberships from labmi_v1.labmi_v1_web_user
			where  campaign_id = 1 and client_id = 5;
			
			
			
			v_json := jsonb_set(v_json, '{new_user_total}', v_new_user_data, true);	
			v_json := jsonb_set(v_json, '{total_membershp}', v_total_membershp, true);	
			
			v_json := jsonb_set(v_json, '{verified_blue_memberships}', v_verified_blue_memberships::text::jsonb, true);
			v_json := jsonb_set(v_json, '{total_blue_memberships}', v_total_blue_memberships::text::jsonb, true);
			v_json := jsonb_set(v_json, '{verified_blue_memberships_previous}', v_verified_blue_memberships_previos::text::jsonb, true);
			v_json := jsonb_set(v_json, '{total_blue_memberships_previous}', v_total_blue_memberships_previos::text::jsonb, true);
            v_json := jsonb_set(v_json, '{overall_verified_blue_memberships}', v_overall_verified_blue_memberships::text::jsonb, true);
			v_json := jsonb_set(v_json, '{overall_blue_memberships}', v_overall_blue_memberships::text::jsonb, true);
			
			
			p_user_data := v_json;

end;
$$;


--
