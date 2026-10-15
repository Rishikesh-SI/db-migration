-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_recommended_video(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_recommended_video(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_recommended_video(p_json jsonb, OUT p_out numeric, OUT p_recommended_video_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
/*
SELECT * from labbsc_dev.labbsc_dev_ins_upd_recommended_video(
	 '{
  "user_guid": "46f173f0-e9f5-44f6-a572-a0217e9f2370",
  "counseller_id": "342",
  "session_id": "21",
  "session_video_json": [
    {
      "video_id": "321",
      "title": "Marketing beginner - Introduction",
      "slug_url":"marketing-beginner---introduction"
    },
    {
      "video_id": "261",
      "title": "Sales beginner - Introduction",
      "slug_url":"sales-beginner"
    }
  ]
}'
);*/
 
v_counseller_id numeric;
 
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
 
v_session_id numeric;
v_user_guid text;
v_user_id numeric;
v_session_video_json jsonb;
i record;
v_first_name text;
v_last_name text;
v_user_email text;
v_counseller_name varchar(4000);
begin

select 
       p_json->>'counseller_id' ,
	   p_json->>'user_guid' ,
	   p_json->>'session_id' ,
	   p_json->>'session_video_json' 
 into
 v_counseller_id,
 v_user_guid,
 v_session_id,
 v_session_video_json;

select user_id,email_id,first_name,last_name
from labbsc_dev.labbsc_dev_web_user
where user_guid=v_user_guid
into v_user_id,v_user_email,v_first_name,v_last_name;

select full_name
from labbsc_dev.labbsc_dev_user
where user_id =v_counseller_id
into v_counseller_name;

if (exists(select 1 from  labbsc_dev.labbsc_dev_session_video_detail
		 where session_id=v_session_id) and v_session_video_json is not null)
		 then
		 delete from labbsc_dev.labbsc_dev_session_video_detail
		 where session_id=v_session_id;
		 
 end if;
 
--- raise notice '%',v_session_video_json;
		if v_session_video_json is not null then 
 insert into labbsc_dev.labbsc_dev_session_video_detail
 (session_video_detail_id,
 counseller_id,
 user_id,
 session_id,
 video_id)
 select nextval('labbsc_dev.seq_labbsc_dev_session_video_detail'),
 v_counseller_id,
 v_user_id,
 v_session_id,
 video_id::numeric 
 from (select value->>'video_id' as video_id from jsonb_array_elements(v_session_video_json)) as tb;
		 
update labbsc_dev.labbsc_dev_user_counselling_session
set video_detail_json=v_session_video_json
where session_id=v_session_id;
end if;
p_out:=1;

---p_recommended_video_json:=p_json;

select  row_to_json(row)  from (
select v_user_email as user_email,v_first_name as first_name,v_last_name as last_name,
 v_counseller_id as counseller_id,
 v_user_guid as user_guid,
 v_session_id as session_id,
 v_session_video_json as session_video_json,
v_counseller_name as counseller_name) as row
 into p_recommended_video_json;
/*
exception when no_data_found 
then 
p_out:=2;
when others then 
p_out:=-1;*/

end;
$$;


--
