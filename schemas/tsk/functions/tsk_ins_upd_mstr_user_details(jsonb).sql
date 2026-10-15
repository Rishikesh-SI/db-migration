-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_ins_upd_mstr_user_details(jsonb)
-- Type: FUNCTION

-- Name: tsk_ins_upd_mstr_user_details(jsonb); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_ins_upd_mstr_user_details(p_json jsonb, OUT p_result jsonb) RETURNS jsonb
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
begin

select  p_json->>'userId',
		p_json->>'opttype',
		p_json->'additionalInfo'->>'applicationStatus',
		p_json->'additionalInfo'->>'applicationId',
		p_json->'additionalInfo'->>'rejectionRemarks',
		p_json->'additionalInfo'->>'yearBand',
		p_json->'additionalInfo'->>'collectionType',
		p_json->'additionalInfo'->>'bibNumber'
		
 into 			
		v_userId,
		v_opttype,
		v_applicationStatus,
		v_applicationId,
		v_rejectionRemarks,
		v_yearBand,
		v_collectionType,
		v_bibNumber;
		
if 	v_opttype = 1 then
	
	update tsk.tsk_user_master
	set applicationStatus=v_applicationStatus
	where user_id=v_userId;
	
	p_result:='{
	"result":"1"
	}';

else if v_opttype = 2 then

	update tsk.tsk_user_master
	set applicationStatus=v_applicationStatus,
	applicationId=v_applicationId,
	rejectionRemarks=v_rejectionRemarks,
	yearBand=v_yearBand,
	collectionType=v_collectionType,
	bib_no=v_bibNumber
	where user_id=v_userId;
	
	p_result:='{
	"result":"1"
	}';
	
	else
	
	p_result:='{
	"result":"0"
	}';
end if;
end if;
end;
$$;


--
