-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_get_user_data_sftp(refcursor)
-- Type: FUNCTION

-- Name: lablsg_get_user_data_sftp(refcursor); Type: FUNCTION; Schema: lablsg; Owner: -
--

CREATE FUNCTION lablsg.lablsg_get_user_data_sftp(p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare

begin

          open p_user_cursor for
          select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
		 case wua.platform_type when 0 then 'website' when 1 then 'website' else 'app' end as platform_type,
         TO_CHAR(wu.created_date::date, 'yyyy/mm/dd') as created_date,
         TO_CHAR(wu.updated_date::date, 'yyyy/mm/dd') as updated_date,
         case  when created_date=updated_date then 'registered user' when created_date<>updated_date then 'updated user' end as remarks
		 from lablsg.lablsg_web_user wu
		 join lablsg.lablsg_web_user_audit wua on wu.user_guid=wua.user_guid
        left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
         left join waf_master.waf_countries wc on wc.phone_code= wu.country_code::numeric
		 where coalesce(wu.sync_sftp_status,0) =0 and 
         wua.option_type in (1,2)
		 and wu.email_id is not null 
		 limit 30000;

end;

$$;


--
