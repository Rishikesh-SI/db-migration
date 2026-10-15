-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ins_upd_group_registration(jsonb)
-- Type: FUNCTION

-- Name: labtcs_ins_upd_group_registration(jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ins_upd_group_registration(p_json jsonb, OUT p_out numeric, OUT p_group_reg_detail jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_group_id numeric ;
v_group_name varchar(500);
v_no_of_runners numeric;
 
v_marathon_registrants varchar(500);
 
v_open10k_registrants varchar(500);
    v_half_marathon_registrants varchar(500);
   -- v_open5k_registrants varchar(500);
   -- v_open2p5k_registrants varchar(500);
  --  v_marathon_registrants_overseas varchar(500);
    v_open10k_registrants_overseas varchar(500);
  --  v_half_marathon_registrants_overseas varchar(500);
  --  v_open5k_registrants_overseas varchar(500);
  --  v_open2p5k_registrants_overseas varchar(500);
v_total_fees varchar(500);
v_invoice_address text;
v_invoice_company_name character varying(500);
v_group_contact_name text;
v_group_contact_email text;
v_group_contact_number text;
v_group_pancard_number text;
v_group_gst_number text;
v_state_name varchar(500);
v_state_id numeric;
v_group_pancard_name varchar(500); 
v_corporate_type numeric;
v_chosen_distance varchar(50);
v_participation_format varchar(500);
v_dreamrun_registrants varchar(500);
v_dreamrun_registrants_overseas varchar(500);
v_majjarun_registrants character varying;
v_seniorcitizen_registrants character varying;
v_majjarun_registrants_virtual character varying;
v_open10k_registrants_virtual character varying;
v_cwd_registrants character varying;
v_racetype character varying;
v_subject character varying;
v_cwdb_registrants character varying;
begin

select p_json->'data'->>'group_id',
p_json->'data'->>'group_name',
p_json->'data'->>'marathon_registrants' ,
p_json->'data'->>'open10k_registrants'  ,
p_json->'data'->>'invoice_company_name',
p_json->'data'->>'invoice_address',
p_json->'data'->>'group_contact_name',
p_json->'data'->>'group_contact_email',
p_json->'data'->>'group_contact_number',
p_json->'data'->>'group_pancard_number',
p_json->'data'->>'group_gst_number',
p_json->'data'->>'no_of_runners',
p_json->'data'->>'total_fees',
p_json->'data'->>'state_id',
p_json->'data'->>'state' ,
p_json->'data'->>'corporate_registred_type',
p_json->'data'->>'group_pancard_name',
p_json->'data'->>'chosen_distance',
p_json->'data'->>'participation_format',
p_json->'data'->>'majjarun_registrants',
p_json->'data'->>'seniorcitizen_registrants',
p_json->'data'->>'majjarun_registrants_virtual',
p_json->'data'->>'open10k_registrants_virtual',
p_json->'data'->>'cwd_registrants',
p_json->'data'->>'raceType',
p_json->'data'->>'cwdb_registrants'

into v_group_id  ,
v_group_name,
v_marathon_registrants ,
    v_open10k_registrants  ,
v_invoice_company_name,
v_invoice_address ,
v_group_contact_name,
v_group_contact_email,
v_group_contact_number,
v_group_pancard_number,
v_group_gst_number,
v_no_of_runners,
v_total_fees,
v_state_id,
v_state_name,
v_corporate_type,
v_group_pancard_name,
v_chosen_distance,
v_participation_format,
v_majjarun_registrants,
v_seniorcitizen_registrants,
v_majjarun_registrants_virtual,
v_open10k_registrants_virtual,
v_cwd_registrants,
v_racetype,
v_cwdb_registrants
;
 
v_subject:='Corporate/ Group payment process for TCS World 10K 2022';
 
 if v_group_id =0 then
 if not exists(select 1 from labtcs.labtcs_group where upper(group_name)=upper(v_group_name)
			   or upper(group_contact_email)=upper(v_group_contact_email)) then
 select nextval('labtcs.seq_labtcs_group_id') 
 into v_group_id;
--- raise notice '%',v_group_id;
 insert into labtcs.labtcs_group 
( group_id  ,
group_name,
marathon_registrants ,
    open10k_registrants  ,
 invoice_company_name,
invoice_address ,
group_contact_name,
group_contact_email,
group_contact_number,
group_pancard_number,
group_gst_number,
no_of_runners,
total_fees,
state_id,
state_name,
group_pancard_name,
corporate_type,
chosen_distance,
participation_format,
majjarun_registrants,
seniorcitizen_registrants,
majjarun_registrants_virtual,
open10k_registrants_virtual,
cwd_registrants,
 racetype,
 cwdb_registrants 
)
select 
  v_group_id  ,
v_group_name,
v_marathon_registrants ,
    v_open10k_registrants  ,
v_invoice_company_name,
v_invoice_address ,
v_group_contact_name,
v_group_contact_email,
v_group_contact_number,
v_group_pancard_number,
v_group_gst_number,
v_no_of_runners,
v_total_fees,
v_state_id,
v_state_name,
v_group_pancard_name,
v_corporate_type,
v_chosen_distance,
v_participation_format,
v_majjarun_registrants,
v_seniorcitizen_registrants,
v_majjarun_registrants_virtual,
v_open10k_registrants_virtual,
v_cwd_registrants,
v_racetype,
v_cwdb_registrants 
;
 
p_out:=1;
---raise notice '%',v_group_id;
else
	p_out:=2;																		   
	p_group_reg_detail:=null;																		   
   end if;
else

update labtcs.labtcs_group 
set  
group_name=v_group_name,
marathon_registrants=v_marathon_registrants,
    open10k_registrants  =v_open10k_registrants,
invoice_company_name=v_invoice_company_name,
invoice_address=v_invoice_address ,
group_contact_name=v_group_contact_name,
group_contact_email=v_group_contact_email,
group_contact_number=v_group_contact_number,
group_pancard_number=v_group_pancard_number,
group_gst_number=v_group_gst_number,
no_of_runners=v_no_of_runners,
total_fees=v_total_fees,
state_id=v_state_id,
state_name=v_state_name,
group_pancard_name=v_group_pancard_name,
corporate_type=v_corporate_type,
chosen_distance=v_chosen_distance,
participation_format=v_participation_format,
majjarun_registrants=v_majjarun_registrants,
seniorcitizen_registrants=v_seniorcitizen_registrants,
majjarun_registrants_virtual=v_majjarun_registrants_virtual,
open10k_registrants_virtual=v_open10k_registrants_virtual,
cwd_registrants=v_cwd_registrants,
racetype=v_racetype,
cwdb_registrants=v_cwdb_registrants 
where group_id=v_group_id;

p_out:=1;
 
end if;
 
if p_out=1  then
if v_group_id <>0 then
    
select row_to_json(row) 
from (select group_id  ,
group_name,
marathon_registrants ,
    open10k_registrants  ,
invoice_company_name,
invoice_address ,
group_contact_name,
group_contact_email,
group_contact_number,
group_pancard_number,
group_gst_number,
no_of_runners,
total_fees,
state_id,
state_name,
group_pancard_name,
	  corporate_type,
	  chosen_distance,
	  participation_format,
	  majjarun_registrants,
seniorcitizen_registrants,
majjarun_registrants_virtual,
open10k_registrants_virtual,
cwd_registrants,
racetype,
cwdb_registrants 	  
	  from labtcs.labtcs_group 
	  where group_id=v_group_id
) row
into p_group_reg_detail ;
 
 p_group_reg_detail= jsonb_set(p_group_reg_detail, '{subject}',to_jsonb(v_subject), true);
 p_group_reg_detail= jsonb_set(p_group_reg_detail, '{runnerscount}',to_jsonb(v_no_of_runners), true);
 
end if;
end if; 
/*
exception when others then
p_out:=0;
p_group_reg_detail:=null;*/

end;
$$;


--
