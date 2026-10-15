-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_get_web_user_listing_encription(numeric, numeric)
-- Type: FUNCTION

-- Name: labstlz_get_web_user_listing_encription(numeric, numeric); Type: FUNCTION; Schema: labstlz; Owner: -
--

CREATE FUNCTION labstlz.labstlz_get_web_user_listing_encription(p_pagenumber numeric, p_itemnumber numeric, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 

declare 
	userid_arr numeric[];
begin
	  

     select  array(select a.user_id
                   from labstlz.labstlz_web_user_nonencript a
                   where not exists (select 1 from labstlz.labstlz_web_user b 
                                     where a.user_id = b.user_id)
                   and coalesce(is_process_encript,0) = 0
                   and client_id in (2,3,4)
                  -- and ((client_id in (2,3,4) and coalesce(social_user_name,'') != '' Or coalesce(email_id ,'') != '')
                  --      or client_id =5)
                   order by user_id
                   limit p_itemnumber
                   ) 
     into userid_arr ; 
     
       
     select array_to_json(array_agg(a))
     into p_result
     from (select user_id, client_id, social_user_name, user_full_name, 
           			lower(trim(email_id)) email_id, lower(trim(upper_email_id)) upper_email_id, user_password, social_id, 
                dob, profile_picture_url, city, mobile_no, user_guid, reset_key, key_expiry_date, reset_key_status,
                old_password, failed_attempts, unlock_date, user_bio, is_registered, created_date, updated_date, gender,
                is_verified
           -- , favourite_club, token, epoch_timestamp, ipaddress, edition
           from labstlz.labstlz_web_user_nonencript a
           where user_id in (select * from unnest(userid_arr))       
          )a ; 
	
   -- update labstlz.labstlz_t1 set id = 1 ; 
    /*     
    create table labstlz.labstlz_t1 (id numeric) ;
	insert into labstlz.labstlz_t1 
    */
end;

$$;


--
