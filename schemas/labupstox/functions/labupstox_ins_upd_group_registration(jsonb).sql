-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_ins_upd_group_registration(jsonb)
-- Type: FUNCTION

-- Name: labupstox_ins_upd_group_registration(jsonb); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_ins_upd_group_registration(p_json jsonb, OUT p_out numeric, OUT p_group_reg_detail jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
v_group_id numeric ;
v_group_name varchar(500);
v_no_of_runners numeric;
v_pledged_distance varchar(500);
v_ind_1_50km varchar(500);
v_ind_51_100km varchar(500);
v_ind_101_above  varchar(500);
v_ov_1_50km varchar(500);
v_ov_51_100km varchar(500);
v_ov_101_above  varchar(500);
v_total_fees varchar(500);
v_invoice_address text;
v_group_contact_name text;
v_group_contact_email text;
v_group_contact_number text;
v_group_pancard_number text;
v_group_gst_number text;
v_state_name varchar(500);
v_state_code varchar(500);
v_no_of_participants_indian numeric;
v_no_of_participants_overseas numeric;
v_tier varchar(50);
v_corporate_type numeric;
begin

select p_json->'data'->>'group_id',
p_json->'data'->>'group_name',
p_json->'data'->>'no_of_runners',
p_json->'data'->>'pledged_distance',
p_json->'data'->>'ind_1_50km',
p_json->'data'->>'ind_51_100km',
p_json->'data'->>'ind_101_above',
p_json->'data'->>'ov_1_50km',
p_json->'data'->>'ov_51_100km',
p_json->'data'->>'ov_101_above',
p_json->'data'->>'total_fees',
p_json->'data'->>'invoice_address',
p_json->'data'->>'group_contact_name',
p_json->'data'->>'group_contact_email',
p_json->'data'->>'group_contact_number',
p_json->'data'->>'group_pancard_number',
p_json->'data'->>'group_gst_number',
p_json->'data'->>'state',
p_json->'data'->>'corporate_type' 
into v_group_id  ,
v_group_name,
v_no_of_runners,
v_pledged_distance,
v_ind_1_50km,
v_ind_51_100km,
v_ind_101_above  ,
v_ov_1_50km,
v_ov_51_100km,
v_ov_101_above ,
v_total_fees,
v_invoice_address,
v_group_contact_name,
v_group_contact_email,
v_group_contact_number,
v_group_pancard_number,
v_group_gst_number,
v_state_name,
v_corporate_type;
 

 if v_group_id =0 then
 if not exists(select 1 from labupstox.labupstox_group where upper(group_name)=upper(v_group_name)
			   or upper(group_contact_email)=upper(v_group_contact_email)) then
 select nextval('labupstox.seq_labupstox_group_id') 
 into v_group_id;
--- raise notice '%',v_group_id;
 insert into labupstox.labupstox_group 
(group_id  ,
group_name ,
no_of_runners,
pledged_distance ,
ind_1_50km ,
ind_51_100km ,
ind_101_above  ,
ov_1_50km ,
ov_51_100km ,
ov_101_above  ,
total_fees ,
invoice_address ,
group_contact_name ,
group_contact_email ,
group_contact_number ,
group_pancard_number ,
group_gst_number ,
state_name ,
corporate_type)
select 
 v_group_id   ,
v_group_name,
v_no_of_runners,
v_pledged_distance,
v_ind_1_50km ,
v_ind_51_100km ,
v_ind_101_above  ,
v_ov_1_50km ,
v_ov_51_100km ,
v_ov_101_above  ,
v_total_fees,
v_invoice_address,
v_group_contact_name,
v_group_contact_email,
v_group_contact_number,
v_group_pancard_number,
v_group_gst_number,
v_state_name,
v_corporate_type;
 
p_out:=1;
---raise notice '%',v_group_id;
else
	p_out:=2;																		   
	p_group_reg_detail:=null;																		   
   end if;
else

update labupstox.labupstox_group 
set  
group_name =v_group_name,
no_of_runners=v_no_of_runners,
pledged_distance=v_pledged_distance ,
ind_1_50km=v_ind_1_50km ,
ind_51_100km=v_ind_51_100km ,
ind_101_above=v_ind_101_above ,
ov_1_50km=v_ov_1_50km ,
ov_51_100km=v_ov_51_100km ,
ov_101_above=v_ov_101_above ,
total_fees=v_total_fees ,
invoice_address=v_invoice_address ,
group_contact_name=v_group_contact_name ,
group_contact_email =v_group_contact_email,
group_contact_number=v_group_contact_number ,
group_pancard_number =v_group_pancard_number,
group_gst_number=v_group_gst_number ,
state_name=v_state_name ,
corporate_type=v_corporate_type
where group_id=v_group_id;
p_out:=1;
 
end if;
 
if p_out=1  then
if v_group_id <>0 then
    
select row_to_json(row) 
from (select group_id  ,
group_name ,
no_of_runners,
pledged_distance ,
ind_1_50km ,
ind_51_100km ,
ind_101_above  ,
ov_1_50km ,
ov_51_100km ,
ov_101_above
total_fees ,
invoice_address ,
group_contact_name ,
group_contact_email ,
group_contact_number ,
group_pancard_number ,
group_gst_number ,
state_name ,
	  corporate_type
	  from labupstox.labupstox_group 
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
