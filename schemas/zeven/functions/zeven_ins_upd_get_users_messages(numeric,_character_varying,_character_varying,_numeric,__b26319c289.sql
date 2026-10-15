-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_get_users_messages(numeric, character varying, character varying, numeric, character varying, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_ins_upd_get_users_messages(numeric, character varying, character varying, numeric, character varying, numeric, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_get_users_messages(p_option_id numeric, p_user_name character varying, p_twitter_handle character varying, p_ambassador_id numeric, p_message character varying, p_users_messages_id numeric, p_result refcursor, p_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

  declare 
  
    v_continue numeric;
    v_user_id zeven.zeven_rowz_users.user_id%type;
    v_twitter_handle zeven.zeven_rowz_users.twitter_handle%type = upper(p_twitter_handle);
    v_user_message_id zeven.zeven_rowz_users_messages.users_messages_id%type;
    v_sysdate timestamp(0) = current_timestamp;
    
  begin
	
    if exists(select 1
                  from   zeven.zeven_rowz_ambassador
                  where  ambassador_id = p_ambassador_id
                  and    is_shown      = 1) then
		v_continue := 1;
	end if;

    
    if v_continue = 1 then
      
      if p_option_id = 1 then
        
        begin
          
          select user_id
          into   strict v_user_id
          from   zeven.zeven_rowz_users
          where  upper(twitter_handle) = v_twitter_handle;
          
        exception
          
          when no_data_found then
            
            v_user_id := nextval('zeven.seq_zeven_rowz_user_id');
            
            insert into zeven.zeven_rowz_users(user_id,
                                               user_name,
                                               twitter_handle,
                                               created_date,
                                               updated_date,
                                               is_active,
                                               is_deleted)
            values(v_user_id,
                   p_user_name,
                   p_twitter_handle,
                   v_sysdate,
                   v_sysdate,
                   1,
                   0);
            
        end;
        
        v_user_message_id := nextval('zeven.seq_zeven_rowz_user_message_id');
        
        insert into zeven.zeven_rowz_users_messages(users_messages_id,
                                                    user_id,
                                                    ambassador_id,
                                                    message,
                                                    is_accepted,
                                                    created_date,
                                                    updated_date,
                                                    is_active,
                                                    is_deleted)
        values(v_user_message_id,
               v_user_id,
               p_ambassador_id,
               p_message,
               0,
               v_sysdate,
               v_sysdate,
               1,
               0);
        
        
        
      elsif p_option_id = 2 then
        
        update zeven.zeven_rowz_users_messages
        set    is_accepted       = 1,
               updated_date      = v_sysdate
        where  users_messages_id = p_users_messages_id;
        
        
        
      end if;
      
    end if;
    
    open p_data for
      select um.users_messages_id, u.user_name, u.twitter_handle, a.ambassador_name, um.message, case um.is_accepted  when 1 then  1  else 0 end accept, a.ambassador_id
      from   zeven.zeven_rowz_users_messages um
      join   zeven.zeven_rowz_users u
      on     u.user_id       = um.user_id
      join   zeven.zeven_rowz_ambassador a
      on     a.ambassador_id = um.ambassador_id
      and    is_shown        = 1
      and    um.is_accepted  = 0
      order by um.created_date desc;
	
    open p_result for select 1 as p_result;
    
  end;

$$;


--
