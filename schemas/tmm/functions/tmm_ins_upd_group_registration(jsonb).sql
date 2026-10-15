-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_ins_upd_group_registration(jsonb)
-- Type: FUNCTION

-- Name: tmm_ins_upd_group_registration(jsonb); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_ins_upd_group_registration(p_json jsonb, OUT p_out numeric, OUT p_group_reg_detail jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_group_id numeric ;
v_group_name varchar(500);
v_no_of_runners numeric;
 
v_marathon_registrants varchar(500);
 
v_open10k_registrants varchar(500);
    v_half_marathon_registrants varchar(500);
    v_open5k_registrants varchar(500);
    v_open2p5k_registrants varchar(500);
    v_marathon_registrants_overseas varchar(500);
    v_open10k_registrants_overseas varchar(500);
    v_half_marathon_registrants_overseas varchar(500);
    v_open5k_registrants_overseas varchar(500);
    v_open2p5k_registrants_overseas varchar(500);
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

begin

select p_json->'data'->>'group_id',
p_json->'data'->>'group_name',
p_json->'data'->>'marathon_registrants' ,
   p_json->'data'->>'open10k_registrants'  ,
   p_json->'data'->>'half_marathon_registrants' ,
   p_json->'data'->>' open5k_registrants'  ,
   p_json->'data'->>'open2p5k_registrants'  ,
   p_json->'data'->>'marathon_registrants_overseas'  ,
   p_json->'data'->>'open10k_registrants_overseas'  ,
  p_json->'data'->>'half_marathon_registrants_overseas'  ,
   p_json->'data'->>'open5k_registrants_overseas'  ,
  p_json->'data'->>'open2p5k_registrants_overseas',
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
p_json->'data'->>'dreamrun_registrants',
p_json->'data'->>'dreamrun_registrants_overseas'


into v_group_id  ,
v_group_name,
v_marathon_registrants ,
    v_open10k_registrants  ,
    v_half_marathon_registrants ,
    v_open5k_registrants  ,
    v_open2p5k_registrants  ,
    v_marathon_registrants_overseas  ,
    v_open10k_registrants_overseas  ,
    v_half_marathon_registrants_overseas  ,
    v_open5k_registrants_overseas  ,
    v_open2p5k_registrants_overseas,
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
v_dreamrun_registrants,
v_dreamrun_registrants_overseas

;
 
 
 if v_group_id =0 then
 if not exists(select 1 from tmm.tmm_group where upper(group_name)=upper(v_group_name)
			   or upper(group_contact_email)=upper(v_group_contact_email)) then
 select nextval('tmm.seq_tmm_group_id') 
 into v_group_id;
--- raise notice '%',v_group_id;
 insert into tmm.tmm_group 
( group_id  ,
group_name,
marathon_registrants ,
    open10k_registrants  ,
    half_marathon_registrants ,
    open5k_registrants  ,
    open2p5k_registrants  ,
    marathon_registrants_overseas  ,
    open10k_registrants_overseas  ,
    half_marathon_registrants_overseas  ,
    open5k_registrants_overseas  ,
    open2p5k_registrants_overseas,
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
dreamrun_registrants,
dreamrun_registrants_overseas)
select 
  v_group_id  ,
v_group_name,
v_marathon_registrants ,
    v_open10k_registrants  ,
    v_half_marathon_registrants ,
    v_open5k_registrants  ,
    v_open2p5k_registrants  ,
    v_marathon_registrants_overseas  ,
    v_open10k_registrants_overseas  ,
    v_half_marathon_registrants_overseas  ,
    v_open5k_registrants_overseas  ,
    v_open2p5k_registrants_overseas,
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
v_dreamrun_registrants,
v_dreamrun_registrants_overseas
;
 
p_out:=1;
---raise notice '%',v_group_id;
else
	p_out:=2;																		   
	p_group_reg_detail:=null;																		   
   end if;
else

update tmm.tmm_group 
set  
group_name=v_group_name,
marathon_registrants=v_marathon_registrants,
    open10k_registrants  =v_open10k_registrants,
    half_marathon_registrants=v_half_marathon_registrants ,
    open5k_registrants=v_open5k_registrants  ,
    open2p5k_registrants =v_open2p5k_registrants ,
    marathon_registrants_overseas=v_marathon_registrants_overseas  ,
    open10k_registrants_overseas=v_open10k_registrants_overseas  ,
    half_marathon_registrants_overseas=v_half_marathon_registrants_overseas  ,
    open5k_registrants_overseas=v_open5k_registrants_overseas  ,
    open2p5k_registrants_overseas=v_open2p5k_registrants_overseas,
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
dreamrun_registrants=v_dreamrun_registrants,
dreamrun_registrants_overseas=v_dreamrun_registrants_overseas

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
    half_marathon_registrants ,
    open5k_registrants  ,
    open2p5k_registrants  ,
    marathon_registrants_overseas  ,
    open10k_registrants_overseas  ,
    half_marathon_registrants_overseas  ,
    open5k_registrants_overseas  ,
    open2p5k_registrants_overseas,
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
	  dreamrun_registrants,
	  dreamrun_registrants_overseas

	  from tmm.tmm_group 
	  where group_id=v_group_id
) row
into p_group_reg_detail ;
 
end if;
end if; 
/*
exception when others then
p_out:=0;
p_group_reg_detail:=null;*/

end;
$$;


--
