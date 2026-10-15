-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_payment_data(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_user_payment_data(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_user_payment_data(p_input_json jsonb, OUT p_user_data jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
/*{
  "page_number" : 1,
  "item_number" : 10,
  "email_id":""
}*/

	v_user_data jsonb;
	v_fromrownumber numeric;
	v_torownumber numeric;
	v_pagenumber numeric;
    v_itemnumber numeric;
	v_emailid character varying;
	
begin
   select p_input_json->>'page_number',
		  p_input_json->>'item_number',
		  p_input_json->>'email_id'
    into v_pagenumber,
		 v_itemnumber,
		 v_emailid;
		 
		 v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
    v_torownumber   := (v_pagenumber * v_itemnumber);
	
	select  cnt ,
	'{ "data" :'|| json_agg(raw)||'}' 
	from (select count(1) over() as cnt,user_name,emailid,cartid,perosnalitycode,perosnalitycode2,test_report,module,slno,
		  professional_score,passion_score,communication_score,planning_score,problem_score,observation_score,verification_score,user_id
		  from (select coalesce(user_full_name,social_user_name,first_name) as User_name,email_id as emailid,ldv.cart_id as cartid,
				ldu.personality_code as perosnalitycode,ldu.personality_code2 as perosnalitycode2,ldu.report_url as test_report,ldj.module_name as module,
				row_number()  over(order by ldv.created_date  desc) slno,professional_score,passion_score,communication_score,planning_score,problem_score,
				observation_score,verification_score,wu.user_id
				from labbsc_dev.labbsc_dev_web_user wu
				join labbsc_dev.labbsc_dev_cart ldv
				using(user_id)
				join labbsc_dev.labbsc_dev_user_tests ldu
				on ldv.user_id=ldu.user_id and ldv.cart_id=ldu.cart_id
				inner join labbsc_dev.labbsc_dev_journey_activity ldj
				on ldv.activity_id=ldj.activity_id
				where ldv.status = 2 and email_id=v_emailid or coalesce(v_emailid,'')='')
		  tab )
		  raw
		  where slno between v_fromrownumber and v_torownumber 
		  group by cnt
		  into p_count,v_user_data;
		  
		  p_user_data := v_user_data;
end;
$$;


--
