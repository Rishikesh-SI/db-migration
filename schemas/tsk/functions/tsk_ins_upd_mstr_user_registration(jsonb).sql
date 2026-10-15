-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_ins_upd_mstr_user_registration(jsonb)
-- Type: FUNCTION

-- Name: tsk_ins_upd_mstr_user_registration(jsonb); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_ins_upd_mstr_user_registration(p_json jsonb, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    v_user_id numeric;
    v_email_id text;
    v_login_password text;
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
	v_dob character varying;
	v_charity_amount varchar(500);
    v_nationality varchar(500);
	v_gender varchar(50);
	v_user_guid text;
	v_pledged_state varchar(500);
	v_pledged_city varchar(500);
	v_group_name varchar(500);
	v_is_new_user numeric;
	v_fast_n_up_code varchar(50);
	v_epoch_timestamp  character varying;
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
	v_order_id numeric;
	v_race_type character varying;
	i record;
	v_social_id character varying;
	v_upper_email_id character varying;
	v_tickets jsonb;
	v_is_active numeric;
	v_is_deleted numeric;
	v_created_by numeric; 
	v_updated_by numeric;
	v_status numeric;
	v_emailsent numeric;
	v_stat character varying;
	stat numeric;
	-- v_user_guid character varying ;
	-- v_userid numeric;

begin
	select 
		p_json->>'emailId', 
		p_json->>'amountPaid',
		p_json->>'firstName',
		p_json->>'city',
		p_json->>'state',
		p_json->>'pincode',
		p_json->'tickets'->'timingDetails'->>'bib_no',
		p_json->>'mobileNum',
		p_json->>'dateOfBirth',
		p_json->>'charityAmount',
		p_json->>'nationality',
		p_json->>'gender',
		p_json->>'runningGroup',
		p_json->>'country',
		p_json->>'address',
		p_json->'charity'->'panCardName',
		p_json->>'firstName',
		p_json->>'lastName',
		p_json->>'corporate',
		p_json->>'addons',
		p_json->>'userId',
		p_json->>'user_guid',
		p_json->>'orderId',
		p_json->>'social_id',
		p_json->>'tickets',
		p_json->>'status'

	into
		v_email_id,
		v_payment_amount, 
		v_user_name,
		v_city, 
		v_state_name, 
		v_pincode,
		v_bib_no,  
		v_mobile_no,
		v_dob,
		v_charity_amount,
		v_nationality,
		v_gender,
		v_group_name,
		v_country,
		v_address,
		v_pancard,	
		v_firstname,
		v_lastname,
		v_corporate,
		v_addons,
		v_external_user_id,
		v_user_guid,
		v_order_id,
		v_social_id,
		v_tickets,
		v_stat;
		
		v_upper_email_id := v_email_id;
		
		v_status=0;
		
		
		if not exists(select 1 from tsk.tsk_web_user where social_id = v_social_id)
			then 
			
				v_web_user_id := nextval('tsk.seq_tsk_user_id');               
				v_user_guid := uuid_generate_v4();                 
				v_is_active := 1;
				v_is_deleted := 0;
				v_created_by := 1;
				v_updated_by := 1;              
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
				
				
				insert into tsk.tsk_web_user(user_id, client_id, user_full_name, email_id, upper_email_id,
				social_id, dob, city, mobile_no, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
				 gender, epoch_timestamp,pincode,address,first_name,last_name)
				select v_web_user_id,11,  v_user_name, v_email_id, v_upper_email_id,
				v_social_id,v_dob, v_city, v_mobile_no, v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,
				1,v_gender, v_epoch_timestamp, v_pincode, v_address,v_firstname,v_lastname ;
				
				v_is_new_user:=1;
				v_status = 1 ;
				v_emailsent:=1;
				--select to_json(v_status) into p_user_json;
		ELSE
				v_is_new_user:=0;
					
			update  tsk.tsk_web_user set
				user_full_name=coalesce(v_user_name,user_full_name),
				social_id=coalesce(v_social_id,social_id),
				dob=coalesce(v_dob,dob),
				city=coalesce(v_city,city),
				mobile_no=coalesce(v_mobile_no,mobile_no),
				gender=coalesce(v_gender,gender),
				pincode=coalesce(v_pincode,pincode),
				address=coalesce(v_address,address),
				first_name=coalesce(v_firstname,first_name),
				last_name=coalesce(v_lastname,last_name)
				where client_id=11 and upper(email_id)=v_email_id or mobile_no=v_mobile_no;
				
				
				v_status= 1 ;
				v_emailsent:=0;
				
				select user_guid into v_user_guid from tsk.tsk_web_user
				where client_id=11 and upper(email_id)=v_email_id or mobile_no=v_mobile_no;
				
				-- select to_json(v_status) into p_user_json;
				
		end if;
		
		for i in select b->>'raceType' as rtype,b->>'name' as name from jsonb_array_elements(v_tickets::jsonb) b
			loop
				if not exists(select 1 from tsk.tsk_user_master where external_user_id=v_external_user_id and order_id=v_order_id and race_type=i.rtype)
				then
				
					v_user_id:=nextval('tsk.seq_tsk_user_id');
					
					--raise notice '%' , i.rtype;
					
					select bib_no into v_bib_no from tsk.tsk_user_master where user_guid=v_user_guid;
					
					if v_bib_no is null then
					
						select max(bib_no)+1
						from tsk.tsk_user_master
						where bib_no is not null
						into v_bib_no;
						
						if v_bib_no is null
						then 
							v_bib_no:=1001; 
					end if;
					
					end if;

					

					-- v_user_guid:= uuid_generate_v4();

					v_is_new_user:=1;
					
					INSERT INTO tsk.tsk_user_master(
					user_id,
					email_id,
					user_guid,
					payment_amount,
					user_name, 
					city, 
					state_name, 
					pincode, 
					bib_no,
					mobile_no, 
					external_user_id,
					dob,
					charity_amount,
					nationality,
					gender,
					group_name,
					country,
					address,
					pancard,
					firstname,
					lastname,			
					corporate,
					addons,
					order_id,
					race_type,
					payment_status,
					category	
					)
					select v_user_id, 
					v_email_id, 
					v_user_guid,
					v_payment_amount, 
					v_user_name,
					v_city, 
					v_state_name, 
					v_pincode,
					v_bib_no, 
					v_mobile_no,
					v_external_user_id,
					v_dob,
					v_charity_amount,
					v_nationality,
					v_gender,
					v_group_name,
					v_country,
					v_address,
					v_pancard ,
					v_firstname,
					v_lastname,
					v_corporate,
					p_json,
					v_order_id,
					i.rtype,
					case when v_stat='SUCCESS' then 1 else 0 end as payment_status,
					i.name;
					
					v_status = 1;
					
					select to_json(v_status) into p_user_json;
					
				ELSE
					if v_stat= 'SUCCESS' then 
						stat:=1;
					else 
						stat:=0;
					end if;
					
					update tsk.tsk_user_master set
					payment_amount=coalesce(v_payment_amount,payment_amount),
					user_name=coalesce(v_user_name,user_name),
					city=coalesce(v_city,city),
					state_name=coalesce(v_state_name,state_name),
					pincode=coalesce(v_pincode,pincode),
					bib_no=coalesce(v_bib_no,bib_no),
					mobile_no=coalesce(v_mobile_no,mobile_no),
					external_user_id=coalesce(v_external_user_id,external_user_id),
					dob=coalesce(v_dob,dob),
					charity_amount=coalesce(v_charity_amount,charity_amount),
					nationality=coalesce(v_nationality,nationality),
					gender=coalesce(v_gender,gender),
					group_name=coalesce(v_group_name,group_name),
					country=coalesce(v_country,country),
					address=coalesce(v_address,address),
					pancard=coalesce(v_pancard,pancard),
					firstname=coalesce(v_firstname,firstname),
					lastname=coalesce(v_lastname,lastname),
					corporate=coalesce(v_corporate,corporate),
					addons=coalesce(p_json,addons),
					order_id=coalesce(v_order_id,order_id),
					race_type=coalesce(i.rtype,race_type),
					payment_status=coalesce(stat,0),
					category = coalesce(i.name,category)
								
					where external_user_id=v_external_user_id and order_id=v_order_id and race_type = i.rtype;
					
					v_status=1;
					--select to_json(v_status) into p_user_json;
					
				end if;
			end loop;
			
		p_user_json := '{
 "status": "'||coalesce(v_status::varchar,'')||'",
"sendmail": "'||coalesce(v_emailsent::varchar,'')||'",
"email_sender_name": "tsk2021",
"email_subject": "User Registered" }'
;
 
 
end;
$$;


--
