-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_user_detail_by_service()
-- Type: FUNCTION

-- Name: labgt_get_user_detail_by_service(); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_user_detail_by_service(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

begin

select '{"items" :'||json_agg(row_alias)||'}'
	from (select a.user_id as "CustomerId",a.email_id as "EmailAddress",a.city as "City",a.gender as "Gender",b.name as "Country",
		  a.pincode as "Postcode",a.client_id,a.ipaddress,a.is_active,a.last_name as "LastName",a.dob,
		  a.mobile_no as "Telephone",a.social_id,a.user_guid,a.first_name as "FirstName",a.is_deleted,
		  a.jersey_name,a.country_code,a.created_date,a.updated_date,a.jersey_number,
		  a.upper_email_id,ww.platform_type,ww.platform_version,ww.device_name,ww.option_type,
		  a.user_full_name,a.is_custom_image,
		  a.membership_code,a.social_user_name,e.entity_name as "FavouritePlayer",
		  a.profile_picture_url,a.subscribe_for_email--,a.sync_status,d.option_type
		  --d.option_type,email_id,mobile_no,first_name,last_name,client_id,user_guid,sync_status,social_id,created_date
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
		 where a.sync_status=0
		 and a.email_id is not null 
		 --and ww.option_type in (1,2) --or d.option_type is null)
		 limit 30)row_alias
		 into p_data;

end
$$;


--
