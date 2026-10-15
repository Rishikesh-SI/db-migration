-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_ins_upd_user_registration_12082021(jsonb)
-- Type: FUNCTION

-- Name: labmao_ins_upd_user_registration_12082021(jsonb); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_ins_upd_user_registration_12082021(p_json jsonb, OUT p_out numeric, OUT p_user_json jsonb) RETURNS record
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
	v_donation_amount character varying(500);
	v_ticket_amount  varchar(500);
	v_racetee_amount  varchar(500);
	v_medal_amount  varchar(500);
	v_gst_amount  varchar(500);
	v_country  varchar(500);
	v_address varchar(500);
	v_teesize  varchar(500);
	v_runclub_name varchar(500);
	v_password text;
	v_web_user_id numeric;
	v_pancard character varying;
	v_firstname text;
	v_lastname text;
	v_ngo text;
	v_corporate text;
	v_transaction_no text;
	v_addons jsonb;
	-- v_userid numeric;
	
begin
select 
p_json->'data'->>'EmailId', 
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
p_json->'data'->>'Mobile',
p_json->'data'->>'Dob',
p_json->'data'->>'CharityAmount',
p_json->'data'->>'Nationality',
p_json->'data'->>'Gender',
p_json->'data'->>'Pledgestate',
p_json->'data'->>'Pledgecity',
p_json->'data'->>'GroupName',
p_json->'data'->>'DonationAmount',
 p_json->'data'->>'TicketAmount',
 p_json->'data'->>'RaceteeAmount',
p_json->'data'->> 'MedalAmount',
 p_json->'data'->>'GstAmount',
p_json->'data'->> 'Country',
p_json->'data'->> 'Address',
p_json->'data'->> 'Teesize',
p_json->'data'->> 'RunclubName',
p_json->'data'->> 'Password',
p_json->'data'->> 'pancard_name',

p_json->'data'->> 'firstName',
p_json->'data'->> 'lastName',
p_json->'data'->> 'Ngo',
p_json->'data'->> 'corporate',
p_json->'data'->> 'transactionNo',
p_json->'data'-> 'addons',
p_json->'data'->> 'userId'

 
into
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
v_dob,
v_charity_amount,
v_nationality,
v_gender,
v_pledged_state,
v_pledged_city,
v_group_name,
v_donation_amount,
	v_ticket_amount,
	v_racetee_amount,
	v_medal_amount,
	v_gst_amount,
	v_country,
	v_address,
	v_teesize,
	v_runclub_name,
	v_password ,
	v_pancard,	
	v_firstname,
	v_lastname,
	v_ngo,
	v_corporate,
	v_transaction_no,
	v_addons,
	v_external_user_id;
	
raise notice '%',v_transaction_no;
---select 1/0;
 if  v_email_id is not null or v_mobile_no is not null then
 if not exists(select 1 from labmao.labmao_user_master 
			  where upper(email_id)=upper(v_email_id) or upper(mobile_no)=upper(v_mobile_no))
then
v_user_id:=nextval('labmao.seq_labmao_user_id');
 
select max(bib_no)+1
from labmao.labmao_user_master
where bib_no is not null
into v_bib_no;

if v_bib_no is null
then 
v_bib_no:=1001; 
end if;
 
 
 
 v_user_guid:= uuid_generate_v4();

	v_is_new_user:=1;
INSERT INTO labmao.labmao_user_master(
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
	group_name,
	donation_amount,
	ticket_amount,
	racetee_amount,
	medal_amount,
	gst_amount,
	country,
	address,
	teesize,
	runclub_name,
	usr_password,
	pancard,
	firstname,
	lastname,
     ngo,
     corporate,
     transaction_no,
     addons)
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
v_group_name,
v_donation_amount,
v_ticket_amount,
v_racetee_amount,
v_medal_amount,
v_gst_amount,
v_country,
v_address,
v_teesize,
v_runclub_name,
v_password,
v_pancard ,
v_firstname,
v_lastname,
v_ngo,
v_corporate,
v_transaction_no,
v_addons;

p_out:=1;
---end if;
else
 
 begin
  select bib_no from labmao.labmao_user_master
	where upper(email_id)=upper(v_email_id) or upper(mobile_no)=upper(v_mobile_no)
	into v_bib_no;

exception when no_data_found then
v_bib_no:=0;
end;
if coalesce(v_bib_no,0)=0 then

 
v_is_new_user:=1;
 
select max(bib_no)+1
from labmao.labmao_user_master
where bib_no is not null
into v_bib_no;

if v_bib_no is null
then 
v_bib_no:=1001; 
end if;
 

end if;

  
 /*if (select count(1) from labmao.labmao_user_master
	where upper(email_id)=upper(v_email_id)
	and bib_no is null)>0
	then
v_bib_no:= nextval('labmao.seq_labmao_user_bib_no');
	end if;*/
	
update labmao.labmao_user_master
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
bib_no= case when coalesce(bib_no,0)=0 then v_bib_no else bib_no end,
donation_amount=v_donation_amount,
ticket_amount=v_ticket_amount,
racetee_amount=v_racetee_amount,
medal_amount=v_medal_amount,
gst_amount=v_gst_amount,
country=v_country,
address=v_address,
teesize=v_teesize,
runclub_name=v_runclub_name,
usr_password=v_password ,
pancard=v_pancard,
firstname = v_firstname ,
lastname  = v_lastname,
ngo = v_ngo,
corporate = v_corporate,
transaction_no = v_transaction_no,
addons = v_addons

where upper(email_id)=upper(v_email_id) or upper(mobile_no) = upper(v_mobile_no);
---v_bib_no:=coalesce(v_bib_no,currval('labmao.seq_labmao_user_bib_no'));

p_out:=3;
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
	v_fast_n_up_code as fast_n_up_code,
	v_donation_amount as donation_amount,
v_ticket_amount as ticket_amount,
v_racetee_amount as racetee_amount,
v_medal_amount as medal_amount ,
v_gst_amount as gst_amount,
v_country as country,
v_address as address,
v_teesize as teesize,
v_runclub_name as runclub_name,
v_password as usr_password,
v_firstname  as firstname,
v_lastname as lastname,
v_ngo as ngo ,
v_corporate as corporate,
	v_password as usr_password
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
