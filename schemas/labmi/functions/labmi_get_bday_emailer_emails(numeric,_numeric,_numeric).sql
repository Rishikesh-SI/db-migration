-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_bday_emailer_emails(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_get_bday_emailer_emails(numeric, numeric, numeric); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_bday_emailer_emails(p_opt_type numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	
	declare
		v_fromrownumber numeric;
		v_torownumber numeric;
	
	begin
		
		 v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
 		 v_torownumber := (p_pagenumber * p_itemnumber);
		 
	if	p_opt_type = 1 then 
	
		 select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
				from (select email_id,user_full_name,dob,row_number() over(order by created_date ) as rno
							 from labmi.labmi_web_user
							 where is_verified = 1 and client_id = 5 and campaign_id is not null
					  -- and user_id in (94491,112548,99390,99586,94523,94497,99610)
					 )row
		where rno between v_fromrownumber and v_torownumber	 
		into p_user_data;
		
		end if;
		
		if 	p_opt_type = 12 then 
		
		/*select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
		from (select email_id,user_full_name,row_number() over(order by p.created_date desc) as rno,
				case when p.invoice_id like 'GTM%' then 'Gold' 
				when p.invoice_id like 'STM%' then 'Silver'
				when p.invoice_id like 'JTM%' then 'Junior'
				end as membership
				from labmi.labmi_product_cart_paydetails p
				left join labmi.labmi_web_user wu on p.user_guid = wu.user_guid
				where lower(p.order_status) = lower('SUCCESS')
		)row
	where rno between v_fromrownumber and v_torownumber and rno < 2112
	into p_user_data;*/
		
	--	if p_pagenumber > 1250 then
		
-- 		select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
-- 		from (select email_id,user_full_name,campaign_id,row_number() over(order by created_date ) as rno 
-- 			  from labmi.labmi_web_user
-- 			  where is_active =  1 and is_verified = 1 and client_id = 5 --and campaign_id = 1
-- 			 -- and (created_date + '5.5 hours'::interval)::date between '2017-01-01' and '2023-09-15'
-- 			 -- and user_id in (307062,311937,141,161146,186,312588,250408,203,98941,307772)
-- 			  --and user_id in (203,186,311974,312588)
-- 			  and city_id in (2707,2726,2727,2836,2745,2571,2763)
-- 		     )row
-- 	    where rno between v_fromrownumber and v_torownumber
--         into p_user_data;

select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
		from (select email_id,user_full_name,campaign_id,row_number() over(order by created_date ) as rno 
			  from labmi.labmi_web_user	
			  
			  where is_active =  1 and is_verified = 1 and user_id in (186,311974,312588,390519,141,391046,203)
		     )row
	    where rno between v_fromrownumber and v_torownumber
        into p_user_data;
		
		--else
		
		--end if;
		

end if;

if 	p_opt_type = 2 then 
		
 		select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
 		from (select email_id,user_full_name,row_number() over(order by p.created_date ) as rno,
 				case when p.invoice_id like 'GTM%' then 'Gold' 
 				when p.invoice_id like 'STM%' then 'Silver'
				when p.invoice_id like 'JTM%' then 'Junior'
 				end as membership
				from labmi.labmi_product_cart_paydetails_01022024 p
				left join labmi.labmi_web_user wu on p.user_guid = wu.user_guid
				where p.order_status = 'SUCCESS'
 		)row
 	where rno between v_fromrownumber and v_torownumber
 	into p_user_data;

-- 	select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
-- 		from (select email_id,user_full_name,row_number() over(order by created_date ) as rno,
-- 				case when user_id=186 then 'Gold' 
-- 			  		 when user_id=311974 or user_id=391046 then 'Silver'
-- 					when user_id=312588 or user_id=250408 or user_id=203 then 'Junior' end
-- 			  as membership from
-- 				labmi.labmi_web_user 
-- 				where user_id in (186,311974,312588,391046,250408,203)
-- 		)row
-- 	where rno between v_fromrownumber and v_torownumber
-- 	into p_user_data;

	end if;	
		
	end;
	$$;


--
