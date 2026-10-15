-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_checkins(numeric, numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: zeven_set_checkins(numeric, numeric, numeric[], numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_checkins(p_userid numeric, p_venue_masterid numeric, p_arr_user_taggedid numeric[], p_opt_type numeric, OUT p_ret numeric, OUT p_ret_checinid numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
v_valid_user numeric = 0;
v_checkinsid numeric;
v_venue_parentid zeven.zeven_venue_master.venue_parentid%type;
v_sysdate timestamp(0) = current_timestamp;
v_user_activity_ret numeric = 0;

begin

  select	count(1)
  into    v_valid_user
  from    zeven.zeven_web_user    
  where   user_id = p_userid;
  
  begin
    select  venue_parentid
    into    v_venue_parentid
    from    zeven.zeven_venue_master
    where   venue_masterid = p_venue_masterid;
  exception 
      when no_data_found then
      v_venue_parentid := 0; 
  end;   
  
  if p_opt_type = 1 and v_valid_user = 1 then
    v_checkinsid := nextval(zeven.seq_zeven_venue_checkinsid);
   
    insert into zeven.zeven_venue_checkins
    (
      zeven_venue_checkinsid,user_id,venue_parentid,venue_masterid,created_date,updated_date
    )
    values
    (
      v_checkinsid,p_userid,v_venue_parentid,p_venue_masterid,v_sysdate,v_sysdate
    );
    
    if array_length(p_arr_user_taggedid,1) > 0 then
      for i in 1..array_length(p_arr_user_taggedid,1)
      loop
        insert into zeven.zeven_checkin_friends_map
        (
          checkin_friend_map_id,zeven_venue_checkinsid ,user_id ,friend_id,created_date ,updated_date
        )
        select  nextval(zeven.seq_checkin_friend_map_id),v_checkinsid,p_userid,p_arr_user_taggedid(i),v_sysdate,v_sysdate;
	end loop;
      /* commit; */
      
    perform zeven.zeven_set_user_track_activity(p_userid,0,v_checkinsid,p_venue_masterid,0,14,0,v_user_activity_ret);
    p_ret := v_user_activity_ret;
      
    end if;
    p_ret := 1;
    p_ret_checinid := v_checkinsid;
  end if;

end;
$$;


--
