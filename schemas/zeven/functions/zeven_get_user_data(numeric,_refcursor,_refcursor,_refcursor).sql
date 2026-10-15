-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_user_data(numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_user_data(numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_user_data(p_userid numeric, p_cur_user_data refcursor, p_cur_user_sport refcursor, p_ret_type refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	v_ret_type numeric;
begin
  
   open p_cur_user_data for     
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
            cu.gender
    from        zeven.zeven_web_user cu	
    left join   zeven.zeven_country cc   
    on          cu.country_id = cc.countryid
    left join   zeven.zeven_city cct     
    on          cu.city_id = cct.cityid
    left join   zeven.zeven_state st
          on    st.stateid = cu.state_id
    where       user_id = p_userid;
    
    
    open p_cur_user_sport for
    select user_id,
           sportid,
           skill_level,
           created_date
    from zeven.zeven_user_sport_map
    where user_id = p_userid;
    
    v_ret_type := 1;
	
	open p_ret_type for select v_ret_type as p_ret_type;

end;

$$;


--
