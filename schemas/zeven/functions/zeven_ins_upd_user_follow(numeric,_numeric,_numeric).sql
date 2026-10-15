-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_user_follow(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: zeven_ins_upd_user_follow(numeric, numeric, numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_user_follow(p_opt_type numeric, p_user_id numeric, p_following_id numeric, OUT ret numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare  
v_valid_following_user numeric;
v_valid_follower_user numeric;
v_already_followed numeric;
v_user_activity_ret numeric = 0;

begin

 
 if p_opt_type = 1 then    
  
   select count(1) into v_valid_following_user
   from   zeven.zeven_web_user
   where  user_id = p_user_id;
   
   select count(1) into v_valid_follower_user
   from   zeven.zeven_web_user
   where  user_id = p_following_id;
   
   select count(1) into v_already_followed
   from zeven.zeven_user_following
   where user_id = p_user_id 
   and   following_id = p_following_id;
   
   if v_already_followed > 0 then
      
      update zeven.zeven_user_following
      set is_active = 1
      where user_id = p_user_id 
      and   following_id = p_following_id; 
      
      /* commit; */
      ret := 1; 
    elsif (p_user_id is not null and p_following_id is not null) and (v_valid_following_user > 0 and v_valid_follower_user > 0) then
           
              insert into zeven.zeven_user_following
                (
                  user_following_id,
                  user_id,
                  following_id,
                  created_date,
                  is_active
                )
               values
                 (
                  nextval('zeven.seq_zvn_user_following_id'),
                  p_user_id,
                  p_following_id,
                  current_timestamp,
                  1
                 );
                 
               /* commit; */  
               
    perform zeven.zvn_set_user_track_activity(p_user_id,0,p_following_id,0,0,15,0,v_user_activity_ret);
    ret := v_user_activity_ret;
    
    perform zeven.zvn_set_user_track_activity(p_following_id,0,p_user_id,0,0,20,0,v_user_activity_ret);
    ret := v_user_activity_ret;
               
              ret := 1; 
            else 
              ret := -1;
             end if;   
      end if;

  
   if p_opt_type = 2 then    
  
  if p_user_id is not null and p_following_id is not null then
 
    update zeven.zeven_user_following
    set    is_active    = 0,
           modified_date = current_timestamp
    where  user_id    = p_user_id
    and    following_id = p_following_id;
        
               
    /* commit; */  
    ret := 2;
    
  else 
    ret := -1;
   end if;   

 end if;
  
end;
$$;


--
