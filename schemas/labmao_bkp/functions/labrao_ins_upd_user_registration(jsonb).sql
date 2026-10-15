-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_ins_upd_user_registration(jsonb)
-- Type: FUNCTION

-- Name: labrao_ins_upd_user_registration(jsonb); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_ins_upd_user_registration(p_json jsonb, OUT p_out numeric, OUT p_user_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
    v_user_id numeric;
    v_email_id text;
    v_login_password text;
    v_payment_status numeric;
    v_payment_amount character varying(500);
    v_category character varying(500);
    v_pledged_distance character varying(500);
    v_group_id character varying(500);
    v_user_name character varying(500);
    v_city text;
    v_state_name text;
    v_pincode text;
    v_bib_no numeric;
    v_height character varying(500);
    v_weight character varying(500);
    v_mobile_no text;
    v_external_user_id numeric;
	v_dob timestamp;
	v_charity_amount varchar(500);
    v_nationality varchar(500);
	v_gender varchar(50);
	v_user_guid text;
	v_pledged_state varchar(500);
	v_pledged_city varchar(500);
	v_group_name varchar(500);
	v_is_new_user numeric;
	v_fast_n_up_code varchar(50);
begin
select p_json->'data'->>'UserId',
p_json->'data'->>'emailId', 
p_json->'data'->>'PaymentStatus',
p_json->'data'->>'PaymentAmount',
p_json->'data'->>'Category',
p_json->'data'->>'GroupId',
p_json->'data'->>'Pledgeddistance',
p_json->'data'->>'Name',
p_json->'data'->>'City',
p_json->'data'->>'State',
p_json->'data'->>'PinCode',
p_json->'data'->>'bib_no',
p_json->'data'->>'Height',
p_json->'data'->>'Weight',
p_json->'data'->>'PhoneNo',
p_json->'data'->>'GUID',
p_json->'data'->>'DOB',
p_json->'data'->>'CharityAmount',
p_json->'data'->>'Nationality',
p_json->'data'->>'gender',
p_json->'data'->>'Pledgestate',
p_json->'data'->>'Pledgecity',
p_json->'data'->>'GroupName'
into
v_user_id, 
v_email_id,
v_payment_status,
v_payment_amount, 
v_category,
v_group_id, 
v_pledged_distance, 
v_user_name,
v_city, 
v_state_name, 
v_pincode,
v_bib_no, 
v_height, 
v_weight, 
v_mobile_no,
v_external_user_id,
v_dob,
v_charity_amount,
v_nationality,
v_gender,
v_pledged_state,
v_pledged_city,
v_group_name
;

 if  v_email_id is not null then
 if not exists(select 1 from labrao.labrao_user_master 
			  where upper(email_id)=upper(v_email_id))
then
v_user_id:=nextval('labrao.seq_labrao_user_id');

select max(bib_no)+1
from labrao.labrao_user_master
into v_bib_no;
----v_bib_no:= nextval('labrao.seq_labrao_user_bib_no');
 v_is_new_user:=1;
v_user_guid:= uuid_generate_v4();
 

	
INSERT INTO labrao.labrao_user_master(
	user_id,
	email_id,
	user_guid, 
	payment_status, 
	payment_amount,
	category, 
	pledged_distance, 
	group_id, 
	user_name, 
	city, 
	state_name, 
	pincode, 
	bib_no,
	height,
	weight,
	mobile_no, 
	external_user_id,
    dob,
    charity_amount,
nationality,
gender,
pledged_state,
pledged_city,
group_name)
 select v_user_id, 
v_email_id, 
v_user_guid,
v_payment_status,
v_payment_amount, 
v_category,
v_pledged_distance, 
v_group_id, 
v_user_name,
v_city, 
v_state_name, 
v_pincode,
v_bib_no, 
v_height, 
v_weight, 
v_mobile_no,
v_external_user_id,
v_dob,
v_charity_amount,
v_nationality,
v_gender,
v_pledged_state,
v_pledged_city,
v_group_name;
p_out:=1;
---end if;
else
v_bib_no:=0;
begin
select bib_no from labrao.labrao_user_master
	where upper(email_id)=upper(v_email_id)
	into v_bib_no;

exception when no_data_found then
v_bib_no:=0;
end;
if coalesce(v_bib_no,0)=0 then

select max(bib_no)+1
from labrao.labrao_user_master
into v_bib_no;
v_is_new_user:=1;


begin
select fast_n_up_code
from labrao.labrao_fast_n_up_code
where status=0
into v_fast_n_up_code;
 
update labrao.labrao_fast_n_up_code
set email_id=v_email_id,status=1
where fast_n_up_code=v_fast_n_up_code;

exception when no_data_found then
v_fast_n_up_code:=null;

end;

----v_bib_no:=nextval('labrao.seq_labrao_user_bib_no');

end if;

  
 /*if (select count(1) from labrao.labrao_user_master
	where upper(email_id)=upper(v_email_id)
	and bib_no is null)>0
	then
v_bib_no:= nextval('labrao.seq_labrao_user_bib_no');
	end if;*/
	
update labrao.labrao_user_master
set  
payment_status=v_payment_status,
payment_amount=v_payment_amount, 
category=v_category,
pledged_distance=v_pledged_distance,
group_id=v_group_id, 
user_name=v_user_name,
city=v_city, 
state_name=v_state_name, 
pincode=v_pincode, 
height=v_height, 
weight=v_weight, 
mobile_no=v_mobile_no,
dob=v_dob,
charity_amount=v_charity_amount,
nationality=v_nationality,
gender=v_gender,
external_user_id=coalesce(v_external_user_id,external_user_id),
pledged_state=v_pledged_state,
pledged_city=v_pledged_city,
group_name=v_group_name,
bib_no= case when coalesce(bib_no,0)=0 then v_bib_no else bib_no end
where upper(email_id)=upper(v_email_id);
---v_bib_no:=coalesce(v_bib_no,currval('labrao.seq_labrao_user_bib_no'));

p_out:=1;
end if;
else 
p_out:=2;
end if;

if p_out=1 then
select row_to_json(row) 
from (
	select v_user_id as user_id,
	v_email_id as email_id, 
	v_user_guid as user_guid, 
	v_payment_status as payment_status, 
	v_payment_amount as payment_amount,
	v_category as category, 
	v_pledged_distance as pledged_distance, 
	v_group_id as group_id, 
	v_user_name as user_name, 
	v_city as city, 
	v_state_name as state_name, 
	v_pincode as pincode, 
	v_bib_no as bib_no,
	v_height as height,
	v_weight as weight,
	v_mobile_no as mobile_no,  
	v_external_user_id as external_useR_id,
	v_dob as dob,
	v_charity_amount as charity_amount
	,v_nationality as nationality,v_gender as gender,
	v_pledged_state as pledged_state,
    v_pledged_city as pledged_city,
     v_group_name as group_name,
	coalesce(v_is_new_user,0) as is_new_user,
	v_fast_n_up_code as fast_n_up_code
	
	 ) row
	into p_user_json;

end if;

 /*
exception when others then 
p_out:=-1;
p_user_json:= null;*/
end;

$$;


--
