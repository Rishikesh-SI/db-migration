-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_user_daily_login(numeric)
-- Type: FUNCTION

-- Name: zeven_ins_user_daily_login(numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_user_daily_login(p_userid numeric, OUT ret numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 

v_userid numeric;
v_login numeric;
v_sysdate timestamp(0);
v_activity_points numeric;

begin


select trunc(current_timestamp) into v_sysdate;

select count(user_id) into v_userid
from zeven.zeven_web_user
where user_id = p_userid;

select count(user_id) into v_login
from zeven.zeven_user_daily_login
where user_id = p_userid and trunc(login_date) = v_sysdate;


if v_userid = 1 and v_login = 0 then

    insert
    into zeven.zeven_user_daily_login values
      (
        nextval('zeven.seq_zeven_user_daily_loginid'),
        p_userid,
        v_sysdate
      );
    ret := 1;
    /* commit; */
    
    select zam.activity_points
    into v_activity_points
    from zeven.zeven_activity_master zam
    where zam.activity_name = 'login';
     
     if exists(select 1 from zeven.zeven_user_overall_points where user_id = p_userid) then
	      
		  update zeven.zeven_user_overall_points
		  set points  = coalesce(points,0) + v_activity_points,
		  updated_date = v_sysdate 
		  where user_id = p_userid;
	
	else
		  
		insert into zeven.zeven_user_overall_points(user_id, points, created_date, updated_date)
		select p_userid, v_activity_points, v_sysdate, v_sysdate;
		
	 end if;
	 
	 
  
 
      /* commit; */
 else
    ret := -1;
 
 end if; 
  
exception
when others then
  ret:=-2;
  /* rollback; */
end;
$$;


--
