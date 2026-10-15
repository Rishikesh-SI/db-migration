-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_reschedule_listing(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_reschedule_listing(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_reschedule_listing(p_json jsonb, OUT p_rescheule_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare 
v_fromrownumber numeric;
v_torownumber numeric; 
v_current_date date :=  current_date;
v_status numeric;
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_searchname text;

begin
select p_json ->>'status',
p_json ->>'pagenumber',
p_json ->>'itemnumber',
p_json ->>'search_name'
into v_status,
v_pagenumber,
v_itemnumber,
v_searchname;

v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
v_torownumber   := (v_pagenumber * v_itemnumber);

select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
		from
		(
		select user_id,user_guid,user_email,counseller_email,counseller_id,session_date,session_slot,counselling_status,
			first_name,last_name,counseller_name,session_id,is_rescheduled
		from( select us.user_id,wu.user_guid,wu.email_id as user_email,u.email_id as counseller_email, 
			 us.counseller_id,us.session_date,us.session_slot,
		'Pending' as counselling_status,wu.first_name as first_name,wu.last_name as last_name
		 ,u.display_name as counseller_name,us.is_rescheduled,
		 row_number()over(order by us.session_id desc) sl_no,us.session_id
		 from labbsc_dev.labbsc_dev_user_counselling_session us
		 join labbsc_dev.labbsc_dev_web_user wu
		 on wu.user_id=us.user_id
		 join labbsc_dev.labbsc_dev_user u
		 on u.user_id=us.counseller_id
		 where  (us.session_date<v_current_date
			 or us.session_date=case when coalesce(us.is_rescheduled,0)=1 then us.session_date end)
		 and us.status= case when coalesce(v_status,0)=0 then 0 else us.status end
		 and coalesce(us.is_rescheduled,0)= case when coalesce(v_status,0) =1 then 1 
			 when coalesce(v_status,1) =0 then 0 
			 else coalesce(us.is_rescheduled,0)
		   end	 
		and wu.email_id=coalesce(v_searchname,wu.email_id)	 
			 order by us.session_id desc
	 	) as abc
	where sl_no between v_fromrownumber and v_torownumber
		) as row
		into p_rescheule_json;
 

end;

 $$;


--
