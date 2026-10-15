-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_invite(numeric, numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, numeric, character varying)
-- Type: FUNCTION

-- Name: zeven_ins_upd_invite(numeric, numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, numeric, character varying); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_invite(p_opt_type numeric, p_invite_id numeric, p_from_user_id numeric, p_to_user_id numeric, p_facility_id numeric, p_invite_date character varying, p_invite_time character varying, p_sport_id numeric, p_message character varying, p_is_accepted numeric, p_invitee_message character varying, OUT p_ret numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_valid_invite numeric;
v_valid_from_user numeric;
v_valid_to_user numeric;
v_sysdate timestamp(0) ;

begin


v_sysdate := current_timestamp;
  
  if p_opt_type = 1 then
  
   select count(1) into v_valid_from_user
   from   zeven.zeven_web_user
   where  user_id = p_from_user_id
   and    is_active = 1;
   
   select count(1) into v_valid_to_user
   from   zeven.zeven_web_user
   where  user_id = p_to_user_id
   and    is_active = 1;
   
   select count(1) into v_valid_invite
   from   zeven.zeven_invite
   where  from_user_id = p_from_user_id 
   and    to_user_id   = p_to_user_id
   and    invite_date  = p_invite_date
   and    invite_time  = p_invite_time
   and    sport_id     = p_sport_id
   and    facility_id  = p_facility_id;
    
        if (v_valid_invite = 0 and v_valid_from_user > 0 and v_valid_to_user > 0) then
        
          insert into zeven.zeven_invite
          (
            invite_id,
            from_user_id,
            to_user_id,
            facility_id,
            invite_date,
            invite_time,
            sport_id,
            message,
            is_accepted,
            created_date
          )
          values
          (
            nextval('zeven.seq_zvn_invite_invite_id'),
            p_from_user_id,
            p_to_user_id,
            p_facility_id,
            p_invite_date,
            p_invite_time,
            p_sport_id,
            p_message,
            0,
            current_timestamp
          );
         /* commit; */ 
         
         p_ret := 1;
       
       else
         p_ret := -1;
        
       end if;
 
  end if;
 
    if p_opt_type = 2 then
    
      update zeven.zeven_invite
      set is_accepted     = p_is_accepted,
          invitee_message = p_invitee_message,
          updated_date    = v_sysdate
      where  invite_id    = p_invite_id;
      
      /* commit; */
      
     p_ret := 2; 
    end if;
    
exception
when others then
  p_ret:=-2;
  /* rollback; */
  
    
    
end;
$$;


--
