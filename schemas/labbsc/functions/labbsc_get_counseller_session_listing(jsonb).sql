-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_counseller_session_listing(jsonb)
-- Type: FUNCTION

-- Name: labbsc_get_counseller_session_listing(jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_counseller_session_listing(p_input_json jsonb, OUT p_counseller_session_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare 
v_fromrownumber numeric;
v_torownumber numeric;
p_pagenumber numeric;
p_itemnumber numeric;
v_current_date date :=  current_date;
v_user_test_url varchar(500);

v_user_id numeric;
v_status numeric;
v_searchname text;

begin

 select p_input_json->>'counseller_id',
 p_input_json->>'status',
 p_input_json->>'search_name',
 p_input_json->>'pagenumber',
 p_input_json->>'itemnumber'
 into v_user_id,
 v_status,
 v_searchname,
 p_pagenumber,
 p_itemnumber;
 
 
 
v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
v_torownumber   := (p_pagenumber * p_itemnumber);

 --- raise notice '%,%',v_searchname,v_torownumber;
select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
		from
		(
		select user_id,counseller_id,session_date,session_slot,status as counselling_status,
		sporscore_report,feedback,feedback_status,user_email,session_id,first_name,last_name,
			video_detail_json,user_guid
		from( select us.user_id,us.counseller_id,us.session_date,us.session_slot,
		us.status  ,u.first_name ,u.last_name  ,
          ut.report_url as sporscore_report  ,
		 row_number()over(order by us.session_id desc) sl_no,us.session_id,us.feedback,
			 us.feedback_status,u.email_id as user_email,us.video_detail_json,
			 u.user_guid
		 from labbsc.labbsc_user_counselling_session us
		 join labbsc.labbsc_web_user u
		 on u.user_id=us.user_id
		left join labbsc.labbsc_user_tests ut
			 on ut.user_id=us.user_id
			 and ut.is_attempted=1
			 and ut.report_url is not null
		 where  us.counseller_id=v_user_id
			 and u.email_id =coalesce(v_searchname,u.email_id)
			 and coalesce(us.status,2)=coalesce(v_status,coalesce(us.status,2))
		 order by us.session_id desc
		--- and us.status=0
	 	) as abc
	where sl_no between v_fromrownumber  and v_torownumber
		) as row 
		into p_counseller_session_json
	 ;
 
 /*
 if p_counseller_session_json is null then
 p_counseller_session_json:= '{
  "data": [
    { "user_id":"",
	  "counseller_id":"",
      "session_date": "",
      "session_id": "",
      "counselling_status": "",
      "session_slot": "",
      "sporscore_report": "",
      "first_name": "",
	  "last_name": "",
      "user_email": "",
	  "feedback":"",
	  "feedback_status":""
    }
  ]
}';
end if;*/

end;

 $$;


--
