-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_upd_mstr_user_details(numeric, jsonb)
-- Type: FUNCTION

-- Name: labtcs_upd_mstr_user_details(numeric, jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_upd_mstr_user_details(p_opttype numeric, p_json jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_applicationStatus character varying;
v_applicationId numeric;
v_rejectionRemarks character varying;
v_yearBand character varying;
v_collectionType character varying;
v_bibNumber numeric;
v_userId numeric;
v_opttype numeric;
v_vaccinationUploadLink character varying;
v_lineUpSection character varying;
v_status  character varying;
v_email_id character varying;
v_orderid character varying;
v_resgisterationid numeric;
v_event_id numeric;
v_vaccinationtype character varying;
v_user_guid character varying;
v_registeration1 numeric;
v_status1 character varying;
v_eventid1 numeric;
v_bib_no numeric;
v_vaccinationCertificateUploaded character varying;
begin

select  p_json->>'userId',
		p_json->'additionalInfo'->>'applicationId',
		p_json->'additionalInfo'->>'applicationStatus',
		p_json->>'rejectionRemark',
		p_json->'additionalInfo'->>'yearBand',
		p_json->'additionalInfo'->>'collectionType',
		p_json->'additionalInfo'->>'bibNumber',
		p_json->'additionalInfo'->>'lineUpSection',
		p_json->>'status',
		p_json->>'emailId',
		p_json->>'orderId',
		p_json->>'eventId',
		p_json->'registrationId',
		p_json->>'url',
		p_json->>'user_guid'
 into 			
		v_userId,
		v_applicationId,
		v_applicationStatus,
		v_rejectionRemarks,
		v_yearBand,
		v_collectionType,
		v_bibNumber,
		v_lineUpSection,
		v_status,
		v_email_id,
		v_orderid,
		v_event_id,
		v_resgisterationid,
		v_vaccinationUploadLink,
		v_user_guid;

/*
{
    "userId": 3,
    "eventId": 1,
    "registrationId": 1,
    "orderId": "123456789",
    "emailId": "testinglabtcs133@mailinator.com",
    "status": "CONFIRMED",
    "additionalInfo": {
        "bibNumber": 123,
        "applicationId": 1,
        "applicationStatus": "APPROVED",
        "collectionType": "Self",
        "yearBand": "",
        "lineUpSection": ""
    }
}
*/

v_vaccinationtype:= 'Final';
v_vaccinationCertificateUploaded:='true';

if (v_userId = (select distinct external_user_id from labtcs.labtcs_user_master
			  where external_user_id=v_userId and race_type='on_ground')) or (v_user_guid = (select user_guid from labtcs.labtcs_user_master
			  where user_guid=v_user_guid and race_type='on_ground'
			  limit 1))  then 

if 	p_opttype = 1 then
	
	update labtcs.labtcs_user_master
	set application_status=coalesce(v_status,application_status),
	applicationId=coalesce(v_applicationId,applicationId),
	rejectionRemarks=coalesce(v_rejectionRemarks,rejectionRemarks),
	yearband=coalesce(v_yearBand,yearband),
	collectionType=coalesce(v_collectionType,collectionType),
	bib_no=coalesce(v_bibNumber,bib_no),
	lineUpSection=coalesce(v_lineUpSection,lineUpSection),
	email_id=coalesce(v_email_id,email_id),
	order_id=coalesce(v_orderid,order_id)
	where external_user_id=v_userId
	and race_type='on_ground';
	
	select addons->>'registrationId',addons->>'status',addons->>'eventId'
	into v_registeration1,v_status1,v_eventid1
	from labtcs.labtcs_user_master
	where external_user_id=v_userId
	and race_type='on_ground';
	
	update labtcs.labtcs_user_master
	set addons= jsonb_set(addons, '{registrationId}',('"'||coalesce(v_resgisterationid,v_registeration1)||'"')::jsonb, true)
	where external_user_id=v_userId
	and race_type='on_ground';
	
	update labtcs.labtcs_user_master
	set addons= jsonb_set(addons, '{eventId}',('"'||coalesce(v_event_id,v_eventid1)||'"')::jsonb, true)
	where external_user_id=v_userId
	and race_type='on_ground';
	
	p_result:='{
	"result":"1"
	}';

else if p_opttype = 2 and exists (select 1 from labtcs.labtcs_user_master
			  									where user_guid=v_user_guid
						  						and race_type = 'on_ground') then
		

	update labtcs.labtcs_user_master
	set addons= jsonb_set(addons, '{extraDetails,vaccinationType}',('"'||v_vaccinationtype||'"')::jsonb, true)
	where user_guid=v_user_guid
	and race_type='on_ground';
	
	update labtcs.labtcs_user_master
	set addons= jsonb_set(addons, '{extraDetails,vaccinationUploadLink}',('"'||v_vaccinationUploadLink||'"')::jsonb, true)
	where user_guid=v_user_guid
	and race_type='on_ground';
	
	update labtcs.labtcs_user_master
	set addons= jsonb_set(addons, '{extraDetails,vaccinationCertificateUploaded}',('"'||v_vaccinationCertificateUploaded||'"')::jsonb, true)
	where user_guid=v_user_guid
	and race_type='on_ground';

	/*
	update labtcs.labtcs_user_master
	set applicationStatus=v_applicationStatus
	where user_id=v_userId; */
	
	p_result:='{
	"result":"1"
	}';
	
	else
	
	p_result:='{
	"result":"0"
	}';
end if;
end if;

else 
p_result:='{
	"result":"0"
	}';
	
	end if;

end;
$$;


--
