-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_user_data_sftp(refcursor)
-- Type: FUNCTION

-- Name: labgt_get_user_data_sftp(refcursor); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_user_data_sftp(p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare

begin

          open p_user_cursor for
          select case a.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source,
                 a.user_id as CustomerId,a.first_name, a.last_name,
    			 a.email_id, a.dob, a.mobile_no, a.gender,a.city,a.pincode,e.entity_name as favourite_player_name,b.name as country,a.is_verified,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date,
				 a.subscribe_for_email, ww.platform_type,a.updated_date at time zone 'utc' at time zone 'Asia/Calcutta' as updated_date
          /*a.user_id as "CustomerId",a.email_id as "EmailAddress",a.city as "City",a.gender as "Gender",b.name as "Country",
		  a.pincode as "Postcode",a.client_id,a.ipaddress,a.is_active,a.last_name as "LastName",a.dob,
		  a.mobile_no as "Telephone",a.social_id,a.user_guid,a.first_name as "FirstName",a.is_deleted as "is_soft_delete",
		  a.jersey_name,a.country_code,a.created_date,a.updated_date,a.jersey_number,
		  a.upper_email_id,ww.platform_type,ww.platform_version,ww.device_name,ww.option_type,
		  a.user_full_name,a.is_custom_image,
		  a.membership_code,a.social_user_name,e.entity_name as "FavouritePlayer",
		  a.profile_picture_url,a.subscribe_for_email*/
		 from labgt.labgt_web_user a
		 left join waf_master.waf_countries b
		 on a.country_id=b.country_id
		 left join (select d.platform_type,d.platform_version,d.device_name,d.option_type,d.user_guid from
					labgt.labgt_web_user_audit d
				   where d.option_type in (1,2))ww
		 on a.user_guid = ww.user_guid 
		 left join labgt.labgt_entity_role_map c
		 on c.source_object_id = coalesce(a.favourite_player_id,'0') and c.entity_role_id = 181 
		 left join labgt.labgt_entity_master e
		 on e.entity_master_id=c.entity_master_id
		 where coalesce(a.sync_azure_status,0) =0
		 and a.email_id is not null 
		 limit 30000;

end;

$$;


--
