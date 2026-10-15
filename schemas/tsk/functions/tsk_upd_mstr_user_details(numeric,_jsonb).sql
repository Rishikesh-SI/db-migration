-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_upd_mstr_user_details(numeric, jsonb)
-- Type: FUNCTION

-- Name: tsk_upd_mstr_user_details(numeric, jsonb); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_upd_mstr_user_details(p_opttype numeric, p_json jsonb, OUT p_result jsonb) RETURNS jsonb
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
v_orderid numeric;
v_resgisterationid numeric;
v_event_id numeric;
v_vaccinationtype character varying;
v_user_guid character varying;
v_registeration1 numeric;
v_status1 character varying;
v_eventid1 numeric;
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
		p_json->>'registrationId',
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

v_vaccinationtype:= 'Final';

if (v_userId = (select user_id from tsk.tsk_user_master
			  where user_id=v_userId )) or (v_user_guid = (select user_guid from tsk.tsk_user_master
			  where user_guid=v_user_guid)) then 

if 	p_opttype = 1 then
	
	update tsk.tsk_user_master
	set applicationStatus=coalesce(v_applicationStatus,applicationStatus),
	applicationId=coalesce(v_applicationId,applicationId),
	rejectionRemarks=coalesce(v_rejectionRemarks,rejectionRemarks),
	yearBand=coalesce(v_yearBand,yearBand),
	collectionType=coalesce(v_collectionType,collectionType),
	bib_no=coalesce(v_bibNumber,bib_no),
	lineUpSection=coalesce(v_lineUpSection,lineUpSection),
	email_id=coalesce(v_email_id,email_id),
	order_id=coalesce(v_orderid,order_id)
	where user_id=v_userId;
	
	select addons->>'registrationId',addons->>'status',addons->>'eventId'
	into v_registeration1,v_status1,v_eventid1
	from tsk.tsk_user_master
	where user_id=v_userId;
	
	update tsk.tsk_user_master
	set addons= jsonb_set(addons, '{registrationId}',('"'||coalesce(v_resgisterationid,v_registeration1)||'"')::jsonb, true)
	where user_id=v_userId;
	
	update tsk.tsk_user_master
	set addons= jsonb_set(addons, '{status}',('"'||coalesce(v_status,v_status1)||'"')::jsonb, true)
	where user_id=v_userId;
	
	update tsk.tsk_user_master
	set addons= jsonb_set(addons, '{eventId}',('"'||coalesce(v_event_id,v_eventid1)||'"')::jsonb, true)
	where user_id=v_userId;
	
	p_result:='{
	"result":"1"
	}';

else if p_opttype = 2 then
		

	update tsk.tsk_user_master
	set addons= jsonb_set(addons, '{extraDetails,vaccinationType}',('"'||v_vaccinationtype||'"')::jsonb, true)
	where user_guid=v_user_guid;
	
	update tsk.tsk_user_master
	set addons= jsonb_set(addons, '{extraDetails,vaccinationUploadLink}',('"'||v_vaccinationUploadLink||'"')::jsonb, true)
	where user_guid=v_user_guid;
	/*
	update tsk.tsk_user_master
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
