-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_user_niu(numeric, character varying, character varying, character varying, character varying, numeric, numeric, timestamp without time zone, character varying, numeric[], numeric[], numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_user_niu(numeric, character varying, character varying, character varying, character varying, numeric, numeric, timestamp without time zone, character varying, numeric[], numeric[], numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_user_niu(p_userid numeric, p_social_id character varying, p_full_name character varying, p_user_name character varying, p_email_id character varying, p_city numeric, p_clientid numeric, p_dob timestamp without time zone, p_gender character varying, p_arr_sportid numeric[], p_arr_skill_lvl numeric[], p_opt_type numeric, p_ret_type refcursor, p_cur_user refcursor, p_cur_user_sport_map refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare 
v_sysdate								timestamp(0) = current_timestamp;
v_profile_picture_url		zeven.zeven_web_user.image_url%type;
v_userid						    numeric;
v_user_mapping					numeric;
v_user_exists           numeric;
v_user_guid             varchar(4000);
v_error_message         varchar(2000);
v_varchar_value         varchar(4000);
v_row_cnt               numeric; 
v_user_map       numeric = 0;
v_is_registered  numeric = 0;
v_ret_type numeric;

begin

  begin
      select	user_id ,image_url, 1
      into    v_userid,v_profile_picture_url,v_user_exists
      from    zeven.zeven_web_user    
      where   social_id = p_social_id
      and     client_id = p_clientid ;
    exception 
        when no_data_found then
        v_user_exists := 0; 
    end;
  if (	p_opt_type = 1 
		and length(trim(both ' ' from p_clientid::varchar)) <> 0  
        and length(trim(both from p_social_id)) <> 0	 
        and trim(both from p_clientid::varchar)	is not null 
        and trim(both from p_social_id)	is not null
     ) then
  begin
    if v_user_exists = 0 then
    begin      
      v_user_guid  := uuid_generate_v4();
      v_userid := nextval('zeven.seq_zeven_userid');
      --------------------------------------------------------------
      insert into zeven.zeven_web_user
      (
        user_id,social_id,client_id,full_name,user_name,email_id,city_id,state_id,country_id,image_url,mobile_no,
        is_active,user_guid,created_date,updated_date,dob,gender,is_verified
      )
      values 
      (
        v_userid,p_social_id,p_clientid,p_full_name,p_user_name,p_email_id,p_city,
        null,null,null,null,1,v_user_guid, v_sysdate, v_sysdate,p_dob,p_gender,1
      ) ;
      
      /* commit; */
     ---------------------------------------------------------------------------
     v_ret_type	 := 1;
    end;
    end if;
    
    if v_user_exists = 1 then
      v_ret_type	:= 1;
    end if;
  end;
  elsif ( p_opt_type = 2
            and     trim(both from p_userid) is not null
            and     length(trim(both from p_userid)) <> 0
          )
          then
  begin
        v_userid := p_userid;
        
				update	zeven.zeven_web_user 
				set			full_name  = coalesce(p_full_name,full_name),
                dob = p_dob,
                gender = p_gender,
                city_id = p_city
				where		user_id =    p_userid ;
        
        select  count(1)
        into    v_user_map
        from    zeven.zeven_user_sport_map
        where   user_id = p_userid;
        
        if v_user_map > 0 then
          delete 
          from    zeven.zeven_user_sport_map
          where   user_id = p_userid;
          
          /* commit; */
        end if;
        
        for i in 1..p_arr_sportid.count
        loop
          insert into zeven.zeven_user_sport_map 
          (
            user_id,sportid,skill_level,created_date,updated_date
          )
          values 
          (
            p_userid,p_arr_sportid(i),p_arr_skill_lvl(i),v_sysdate,v_sysdate
          );
          end loop;
        /* commit; */
        
        select  is_registered
        into    v_is_registered
        from    zeven.zeven_web_user 
        where		user_id =    p_userid;
        
        select  count(1)
        into    v_user_map
        from    zeven.zeven_user_sport_map
        where   user_id = p_userid;
        
        if v_user_map > 0 and v_is_registered = 0   then
          update	zeven.zeven_web_user 
          set			is_registered  = 1
          where		user_id =    p_userid ;
          
          /* commit; */
        end if; 
        
        
        v_ret_type := 1;
  end;
  elsif (		p_opt_type = 1  
            and (	length(trim(both from p_clientid::varchar)) = 0  
                  or	length(trim(both from p_social_id))= 0	 
                  or trim(both from p_clientid::varchar)	is  null 
                  or trim(both from p_social_id)		is  null
                ) 
					) then
	  begin
	         v_ret_type	 := 2;
	  end;
	  elsif (		p_opt_type = 2  
              and (	  trim(both from p_userid) is  null
                      or    length(trim(both from p_userid)) = 0
                      or    trim(both from p_email_id) is  null
                      or    length(trim(both from p_email_id))=0 
					) 
			) then
	  begin
	         v_ret_type	 := 3;
    end;
    end if;
  
	open p_ret_type for select v_ret_type;
	
  open p_cur_user for     
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
            cu.is_verified
    from        zeven.zeven_web_user cu	
    left join   zeven.zeven_country cc   
    on          cu.country_id = cc.countryid
    left join   zeven.zeven_city cct     
    on          cu.city_id = cct.cityid
    left join   zeven.zeven_state st
          on    st.stateid = cu.state_id
    where       user_id = v_userid;

    open p_cur_user_sport_map for
      select  usm.user_id,usm.sportid,sm.sport_name,usm.skill_level
      from    zeven.zeven_user_sport_map usm
      inner join  zeven.zeven_sport_master sm
            on    sm.sport_master_id = usm.sportid
      where   user_id = v_userid;

/*exception
when others then
 rollback;

-- zeven.zvn_ins_error_log(v_userid,'procedure','zvn_get_user', sqlcode,substr(sqlerrm, 1, 200),p_email_id,p_social_id,p_clientid,p_userid);
	v_ret_type := -1111;*/
end;
$$;


--
