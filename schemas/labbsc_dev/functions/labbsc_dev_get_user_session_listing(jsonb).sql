-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_session_listing(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_session_listing(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_session_listing(p_json jsonb, OUT p_user_session_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare 
v_fromrownumber numeric;
v_torownumber numeric;
v_searchkeyword text;
v_current_date date :=  current_date;
v_user_id numeric;
v_status numeric;
v_pagenumber numeric;
v_itemnumber numeric;
v_searchname text;
v_user_guid text;

begin
select p_json->>'user_guid',
       p_json->>'status',
	   p_json->>'pagenumber',
	   p_json->>'itemnumber',
	   p_json->>'search_name'
into v_user_guid,
    v_status,
	v_pagenumber,
	v_itemnumber,
	v_searchname;

v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
v_torownumber   := (v_pagenumber * v_itemnumber);

select user_id
from labbsc_dev.labbsc_dev_web_user
where user_guid=v_user_guid
into v_user_id;
 
select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
		from
		(
		select user_id,counseller_id,session_date,session_slot,counselling_status,
			counseller_name,feedback,video_detail_json
		from( select us.user_id,us.counseller_id,us.session_date,us.session_slot,
		us.status as counselling_status,u.display_name as counseller_name,
case when coalesce(us.feedback_status,0) =1 then us.feedback else null end as feedback ,
		 row_number()over(order by us.session_id desc) sl_no,us.session_id,
			 us.video_detail_json
		 from labbsc_dev.labbsc_dev_user_counselling_session us
		 join labbsc_dev.labbsc_dev_user u
		 on u.user_id=us.counseller_id
		 where  us.user_id=v_user_id
			 and us.status=coalesce(v_status,us.status)
		 order by us.session_id desc
		--- and us.status=0
	 	) as abc
	where sl_no between v_fromrownumber and v_torownumber
		) as row
		into p_user_session_json;
 exception when others then
 
p_user_session_json:=null;
end;

 $$;


--
