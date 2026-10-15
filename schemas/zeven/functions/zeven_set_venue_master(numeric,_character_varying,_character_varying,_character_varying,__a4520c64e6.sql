-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_venue_master(numeric, character varying, character varying, character varying, character varying, integer, numeric, character varying, numeric, numeric, numeric, numeric, character varying, character varying, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, numeric, numeric, character varying, character varying, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: zeven_set_venue_master(numeric, character varying, character varying, character varying, character varying, integer, numeric, character varying, numeric, numeric, numeric, numeric, character varying, character varying, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, numeric, numeric, character varying, character varying, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_venue_master(p_venue_masterid numeric, p_venue_name character varying, p_shortname character varying, p_display_name character varying, p_known_as character varying, p_venue_type integer, p_venue_parentid numeric, p_email_id character varying, p_city_id numeric, p_state_id numeric, p_country_id numeric, p_pincode numeric, p_google_map character varying, p_description character varying, p_sport_master_id numeric, p_capacity numeric, p_dress_code character varying, p_price character varying, p_mobile_no character varying, p_mobile_no1 character varying, p_telephone_no character varying, p_timings character varying, p_is_active numeric, p_is_featured numeric, p_address character varying, p_short_address character varying, p_latitude numeric, p_longitude numeric, p_is_verified numeric, p_opt_type numeric, OUT p_ret_type numeric, OUT p_venue_masterid_out numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare 

v_sysdate            timestamp(0) = current_timestamp at time zone 'utc';
v_venue_masterid     zeven.zeven_venue_master.venue_masterid%type;
v_sql_cnt            numeric;

begin

----------------opt type 1 for insert data into table---------
if p_opt_type=1 then

    select nextval('zeven.seq_zeven_venue_masterid') into v_venue_masterid;
    
    insert into zeven.zeven_venue_master
    (venue_masterid,venue_name,shortname,display_name,known_as,venue_type,venue_parentid,email_id,city_id,state_id,country_id,              
    pincode,google_map,description,sport_master_id,capacity,dress_code,price,mobile_no,mobile_no1,telephone_no,timings,          
    is_active,created_date,updated_date,is_featured,address,latitude,longitude,is_verified,short_address)
    values
   (v_venue_masterid,p_venue_name,p_shortname,p_display_name,p_known_as,p_venue_type,p_venue_parentid,p_email_id,p_city_id,
    p_state_id,p_country_id,p_pincode,p_google_map,p_description,p_sport_master_id,p_capacity,p_dress_code,p_price,p_mobile_no,
    p_mobile_no1,p_telephone_no,p_timings,p_is_active,v_sysdate,v_sysdate,p_is_featured,p_address,p_latitude,p_longitude,p_is_verified,
    p_short_address
    );

end if;
----------------opt type 2 for update table---------
if p_opt_type=2 then

      update zeven.zeven_venue_master
      set     
      venue_name       =coalesce(p_venue_name,venue_name),
      shortname        =coalesce(p_shortname,shortname),     
      display_name     =coalesce(p_display_name,display_name),   
      known_as         =coalesce(p_known_as,known_as),     
      venue_type       =coalesce(p_venue_type,venue_type),
      venue_parentid   =coalesce(p_venue_parentid,venue_parentid),        
      email_id         =coalesce(p_email_id,email_id),      
      city_id          =coalesce(p_city_id,city_id),         
      state_id         =coalesce(p_state_id,state_id),       
      country_id       =coalesce(p_country_id,country_id),
      pincode          =coalesce(p_pincode,pincode),      
      google_map       =coalesce(p_google_map,google_map),       
      description      =coalesce(p_description,description),       
      sport_master_id  =coalesce(p_sport_master_id,sport_master_id),         
      capacity         =coalesce(p_capacity,capacity),            
      dress_code       =coalesce(p_dress_code,dress_code),    
      price            =coalesce(p_price,price),       
      mobile_no        =coalesce(p_mobile_no,mobile_no),       
      mobile_no1       =coalesce(p_mobile_no1,mobile_no1),        
      telephone_no     =coalesce(p_telephone_no,telephone_no),    
      timings          =coalesce(p_timings,timings),
      is_active        =coalesce(p_is_active,is_active),     
      updated_date     =v_sysdate,         
      is_featured      =coalesce(p_is_featured,is_featured),  
      address          =coalesce(p_address,address),
      short_address    =coalesce(p_short_address,short_address),
      latitude         =coalesce(p_latitude,latitude),
      longitude        =coalesce(p_longitude,longitude),
      is_verified      =coalesce(p_is_verified,is_verified)
      where venue_masterid   =p_venue_masterid;

end if;
----------------opt type 3 for delete data---------
if p_opt_type=3 then

   delete from zeven.zeven_venue_master
   where  venue_masterid=p_venue_masterid;
end if;

p_ret_type := 1;
if p_venue_masterid is null then
  p_venue_masterid_out    := v_venue_masterid;
else
  p_venue_masterid_out    := p_venue_masterid;
end if;

/*exception 
when others then 

p_ret_type := -1;*/
end;

$$;


--
