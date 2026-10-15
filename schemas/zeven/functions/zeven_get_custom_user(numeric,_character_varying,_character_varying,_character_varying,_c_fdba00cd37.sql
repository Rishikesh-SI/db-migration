-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_custom_user(numeric, character varying, character varying, character varying, character varying, numeric, numeric, timestamp without time zone, character varying, numeric, numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_custom_user(numeric, character varying, character varying, character varying, character varying, numeric, numeric, timestamp without time zone, character varying, numeric, numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_custom_user(p_user_id numeric, p_full_name character varying, p_user_name character varying, p_password character varying, p_email_id character varying, p_city_id numeric, p_clientid numeric, p_dob timestamp without time zone, p_gender character varying, p_user_forgot_pwdid numeric, p_opt_type numeric, p_ret_type refcursor, p_cur_custom_user refcursor, p_cur_user_sport_map refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
v_sysdate								timestamp(0) = current_timestamp;
v_user_id						    numeric;
v_user_exists           numeric = 0;
v_user_guid             varchar(4000);
v_custom_user_id numeric = 0;
v_is_pwd_verified numeric = 0;
v_is_verified numeric = 0;
v_zeven_web_user_forgot_pwd numeric ;
v_is_link_valid numeric = 0 ;
v_is_link_used numeric = 0;
v_ret_type numeric;

begin

  if p_user_id is null or p_user_id = 0 then
    begin
      select	zeven_custom_user_id
      into strict v_custom_user_id
      from    zeven.zeven_custom_user    
      where   email_id = coalesce(p_email_id,'');
    exception 
        when no_data_found then
        v_custom_user_id := 0; 
    end;
    
    begin
      select	user_id, 1
      into strict v_user_id, v_user_exists
      from    zeven.zeven_web_user    
      where   social_id::numeric = v_custom_user_id
              and client_id = p_clientid;
    exception 
        when no_data_found then
        v_user_id := 0; 
    end;
  else
    v_user_id := p_user_id;
    
    begin
      select	social_id
      into strict v_custom_user_id
      from    zeven.zeven_web_user    
      where   user_id = v_user_id;
    exception 
        when no_data_found then
        v_custom_user_id := 0; 
    end;
    
  end if;
  
  if (	p_opt_type = 1 
        and length(p_email_id) <> 0  
        and length(p_password) <> 0	 
        and p_email_id	is not null 
        and p_password  is not null
     ) then
  begin
    if v_user_exists = 0 then
      begin      
        v_user_guid  := uuid_generate_v4();
        v_user_id := nextval('zeven.seq_zeven_web_user_id');
        v_custom_user_id := nextval('zeven.seq_zeven_custom_userid');
        
        --------------------------------------------------------------
        insert into zeven.zeven_custom_user
        (
          zeven_custom_user_id,full_name,email_id,password,is_active,created_date,updated_date
        )
        values
        (
          v_custom_user_id,p_full_name,p_email_id,p_password,1,v_sysdate,v_sysdate
        );
        
        insert into zeven.zeven_web_user
        (
          user_id,social_id,client_id,full_name,user_name,email_id,city_id,state_id,country_id,image_url,mobile_no,
          is_active,user_guid,created_date,updated_date,dob,gender,is_verified
        )
        values 
        (
          v_user_id,v_custom_user_id,p_clientid,p_full_name,p_user_name,p_email_id,p_city_id,
          null,null,null,null,1,v_user_guid, v_sysdate, v_sysdate,p_dob,p_gender,0
        ) ;
        
        /* commit; */
       ---------------------------------------------------------------------------
       v_ret_type	 := 1;
      end;
    elsif v_user_exists = 1 then
      v_ret_type	:= -1;
    end if;
  end;
  elsif (		p_opt_type = 1  
            and (	length(p_email_id) = 0  
                  or	length(p_password)= 0	 
                  or p_email_id	is  null 
                  or p_password	is  null
                ) 
					) then
	  begin
	     v_ret_type	 := -2;
	  end;
    elsif ( p_opt_type = 2 
            and p_clientid = 5 
            and ( length(p_email_id) > 0 
                  or p_email_id	is not null)
            and v_user_id > 0 
          ) then
    begin
      v_zeven_web_user_forgot_pwd := nextval('zeven.seq_zeven_web_user_forgot_pwd');
      insert into zeven.zeven_user_forgot_pwd
      (
        zeven_user_forgot_pwdid,user_id,created_date,updated_date,is_link_used
      )
      values
      (
        v_zeven_web_user_forgot_pwd,v_user_id,v_sysdate,v_sysdate,0
      );
      /* commit; */
      
      v_ret_type := 2;
    end;
    elsif (p_opt_type = 3 and p_clientid = 5 and p_user_forgot_pwdid > 0) then
      begin
        select  trunc((current_timestamp - created_date) * 24,2) ,is_link_used,user_id
        into    v_is_link_valid,v_is_link_used,v_user_id
        from    zeven.zeven_user_forgot_pwd
        where   zeven_user_forgot_pwdid = p_user_forgot_pwdid;
      exception 
            when no_data_found then
            v_user_id := 0; 
     end;
     
      begin
        select	social_id
        into    v_custom_user_id
        from    zeven.zeven_web_user    
        where   user_id = v_user_id;
      exception 
            when no_data_found then
            v_custom_user_id := 0; 
     end;
      
      if p_password is not null and v_is_link_valid <= 1 and v_is_link_used = 0 then
        update	zeven.zeven_custom_user 
        set			password  = p_password,
                updated_date = v_sysdate
        where		zeven_custom_user_id =    v_custom_user_id ; 
        
        update  zeven.zeven_user_forgot_pwd
        set     is_link_used = 1,
                updated_date = v_sysdate
        where   zeven_user_forgot_pwdid = p_user_forgot_pwdid;
        
        /* commit; */
        v_ret_type := 1;
      else
        v_ret_type := -3;
      end if;
    elsif (p_opt_type = 4 and p_clientid = 5 and v_user_id > 0) then
      select  count(1)
      into    v_is_verified
      from    zeven.zeven_web_user
      where   user_id = v_user_id
              and
              is_verified = 1;
      
      if  v_is_verified = 0 then
        update  zeven.zeven_web_user
        set     is_verified = 1
        where   user_id = v_user_id;
        
        v_ret_type := 1;
        /* commit; */
       else
          v_ret_type := -3;
      end if;
    elsif (p_opt_type = 5 and p_clientid = 5) then
    begin
    
      select  count(1)
      into    v_is_pwd_verified
      from    zeven.zeven_custom_user c
      where   c.zeven_custom_user_id = v_custom_user_id
              and
              c.password = p_password;
              
      if v_is_pwd_verified > 0 then
        v_ret_type := 1;
      else
        v_ret_type := -3;
      end if;
    end;
    else
      v_ret_type := 3;
  end if;
    
  open p_cur_custom_user for     
    select	cu.user_id ,
            cu.social_id,
            cu.user_name,
            cu.full_name,
            cu.email_id,
            cu.country_id,
            cc.country_name,
            cu.city_id,
            cct.city_name,
            cu.state_id,
            st.state_name,
            cu.client_id,
            cu.created_date,
            cu.updated_date,
            cu.image_url,
            cu.mobile_no,
            cu.user_guid,
            cu.is_registered,
            cu.dob,
            cu.gender,
            cu.is_verified,
            v_zeven_web_user_forgot_pwd as forgot_pwd_id
    from        zeven.zeven_web_user cu	
    left join   zeven.zeven_country cc   
    on          cu.country_id = cc.countryid
    left join   zeven.zeven_city cct     
    on          cu.city_id = cct.cityid
    left join   zeven.zeven_state st
          on    st.stateid = cu.state_id
    where       user_id = v_user_id;
  
  open p_cur_user_sport_map for
    select  usm.user_id,usm.sportid,sm.sport_name,usm.skill_level
    from    zeven.zeven_user_sport_map usm
    inner join  zeven.zeven_sport_master sm
          on    sm.sport_master_id = usm.sportid
    where   user_id = v_user_id;
	
	open p_ret_type for select v_ret_type as p_ret_type;
end;

$$;


--
