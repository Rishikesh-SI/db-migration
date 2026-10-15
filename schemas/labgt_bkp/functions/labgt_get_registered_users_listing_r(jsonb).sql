-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_get_registered_users_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_registered_users_listing_r(jsonb); Type: FUNCTION; Schema: labgt_bkp; Owner: -
--

CREATE FUNCTION labgt_bkp.labgt_get_registered_users_listing_r(p_json jsonb, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

 v_pagination jsonb; 
 v_start_date_time text;
 v_end_date_time text;
 v_fromrownumber numeric;
 v_torownumber numeric;
v_pgnum text;
v_pgsize text;
v_start_date_time1 timestamp;
v_end_date_time1 timestamp;
v_pgnum1 numeric;
v_pagination1 jsonb;

begin

	select p_json->>'from_date',
		   p_json->>'to_date',
		   p_json->>'pagenumber',
		   p_json->>'page_size'
		  -- p_json->>'item_number'
		   
	  into v_start_date_time,
	  	   v_end_date_time,
		   v_pgnum,  --1
		   v_pgsize; --10
		  -- v_itnum;  --10


raise notice '%v_start_date_time',v_start_date_time;
raise notice '%v_end_date_time',v_end_date_time;
raise notice '%v_pgnum',v_pgnum;
raise notice '%v_pgsize',v_pgsize;

--select * from lbgt.labgt_web_user
--limit 1;


if ((v_start_date_time is null or v_start_date_time = '') or (v_end_date_time is null or v_end_date_time = '') or (v_pgnum is null or v_pgnum= '') or (v_pgsize is null or v_pgsize= '')) then
 p_assetjson:='{
 "message":"Invalid Request"
 }';
 
p_assetcount:=0;
else
		 v_start_date_time1:= v_start_date_time::timestamp;
 		 v_end_date_time1:= v_end_date_time::timestamp;


		v_start_date_time1 := v_start_date_time1::date;
		v_end_date_time1 := v_end_date_time1::date;

		v_fromrownumber := (v_pgnum::int * v_pgsize::int - (v_pgsize::int - 1));
		v_torownumber := (v_pgnum::int * v_pgsize::int);


		select '{ "items": '|| json_agg(X) ||'}'into p_assetjson
		FROM (select user_id,social_user_name,user_full_name,upper_email_id,user_password,social_id,profile_picture_url,
			  mobile_no, user_guid,reset_key,key_expiry_date,reset_key_status,old_password, failed_attempts,unlock_date,user_bio,is_registered,is_active,is_deleted,
			  created_by,updated_by,created_date,updated_date,gender,country,country_code,auth_token,favourite_club,token,epoch_timestamp,edition,is_login,verification_key,is_custom_image,old_profile_image_url,
			  city_id,state_id,country_id, is_profile_complete,complete_profile_id, ipaddress,is_shared_data,is_used_data,ext_info,membership_code,is_ind,mobile_verified,jersey_number,pincode,favourite_player_id,jersey_name,subscribe_for_email,
			  first_name,last_name,email_id,dob,city,pincode,is_verified,client_id,
			  case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source, 
			  row_number() over(order by created_date) as rn 
			  FROM labgt.labgt_web_user
			  where created_date::date between v_start_date_time1 and v_end_date_time1
			  )AS X 
			  where rn between v_fromrownumber and  v_torownumber
			  order by 1 ;

			SELECT count(1)
			FROM labgt.labgt_web_user
			where created_date::date between v_start_date_time1 and v_end_date_time1
			into p_assetcount;

 if p_assetjson is null then 
 p_assetjson:='{"items":null}';
 --raise notice '%',p_assetcount;
 --select 1/0;
 end if;
 
 /*
  v_pagination:='{"total":'||p_assetcount||',
 				 "current_page":'||coalesce(v_pgnum1,0)||'	
				 }';
 */
 
 
 --v_pgnum1:=v_pgnum::int;
  v_pagination:='{"total":'||p_assetcount||',
 				 "current_page":'||coalesce(v_pgsize::int,0)||'	
				 }';

  p_assetjson:=jsonb_set(p_assetjson,'{pagination}',v_pagination,true);

 end if;  

end;
$_$;


--
