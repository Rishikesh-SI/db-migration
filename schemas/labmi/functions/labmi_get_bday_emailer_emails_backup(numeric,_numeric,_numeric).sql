-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_bday_emailer_emails_backup(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_get_bday_emailer_emails_backup(numeric, numeric, numeric); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_bday_emailer_emails_backup(p_opt_type numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_user_data jsonb) RETURNS jsonb
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
		
		if 	p_opt_type = 2 then 
		
		select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
		from (select email_id,user_full_name,row_number() over(order by p.created_date ) as rno,
				case when p.invoice_id like 'GTM%' then 'Gold' 
				when p.invoice_id like 'STM%' then 'Silver'
				when p.invoice_id like 'JTM%' then 'Junior'
				end as membership
				from labmi.labmi_product_cart_paydetails p
				left join labmi.labmi_web_user wu on p.user_guid = wu.user_guid
				where p.order_status = 'SUCCESS'
		)row
	where rno between v_fromrownumber and v_torownumber
	into p_user_data;
		
		
		/*select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
		from (select email_id,user_full_name,row_number() over(order by created_date ) as rno 
			  from labmi.labmi_web_user
			  where is_active =  1 and campaign_id = 1 and is_verified = 1 and client_id = 5
			  and (created_date + '5.5 hours'::interval)::date between '2019-01-01' and '2020-09-15'
		)row
	where rno between v_fromrownumber and v_torownumber
into p_user_data;*/
	
	/*
		 select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
		from (select email_id,user_full_name,row_number() over(order by created_date ) as rno,		  
		case campaign_id when 3 then 'Silver'
		when 4 then 'Gold' when 5 then 'Junior' else 'Blue' end as membership
		from labmi.labmi_web_user
		where is_verified = 1 and client_id = 5 and is_active = 1 and 
			  campaign_id in (3,4,5)
			  --and  city_id in ( 2707,2763,2764)
			  -- and  campaign_id in (1,2707,2763,2764 )
			 -- and user_id in ( 312381,307062,311937,141,161146)
		)row
	where rno between v_fromrownumber and v_torownumber
into p_user_data;*/

/*select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
from(select email_id,user_full_name,row_number() over(order by p.created_date ) as rno from labmi.labmi_product_cart_paydetails p
left join labmi.labmi_web_user wu on p.user_guid = wu.user_guid
where p.order_status = 'SUCCESS' and p.invoice_id like 'GTM%' /*and wu.user_id in (194705,94523)*/)row
where rno between v_fromrownumber and v_torownumber
into p_user_data;*/

	/*select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
	from(select email_id,user_full_name,case when p.invoice_id like 'GTM%' then 'Gold'
	when p.invoice_id like 'STM%' then 'Silver' end as membership
	,row_number() over(order by p.created_date ) as rno 
	from labmi.labmi_product_cart_paydetails_03012022 p
	left join labmi.labmi_web_user wu on p.user_guid = wu.user_guid
	where  p.order_status = 'SUCCESS' and p.invoice_id like 'STM%'  )row
	where rno between v_fromrownumber and v_torownumber
	into p_user_data;*/
	
	/*
	select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
	from (select email_id,row_number() over(order by user_guid) as rno
		  from(select wu.user_guid,wu.email_id
			   from labmi.labmi_product_cart_paydetails p
			   left join labmi.labmi_web_user wu on p.user_guid = wu.user_guid
			   where p.order_status = 'SUCCESS'
			   union
			   select wu.user_guid,wu.email_id
			   from labmi.labmi_product_cart_paydetails_archive p
			   left join labmi.labmi_web_user wu on p.user_guid = wu.user_guid
			   where p.order_status = 'SUCCESS') tab
		 )row
		 where rno between v_fromrownumber and v_torownumber
		 into p_user_data; */

end if;
		
		
	end;
	$$;


--
