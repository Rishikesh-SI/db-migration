-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_upd_user_transaction(json)
-- Type: FUNCTION

-- Name: labmao_upd_user_transaction(json); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_upd_user_transaction(p_json json, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$	
	declare
		/*
		p_json jsonb :='{
  			"eventjinidata": {
    		"transaction_id": "143745878",
    		"amount": "2.00",
    		"order_number": "03122019052648136",
    		"pg_transaction_id": "435519642",
    		"reason": "Transaction Failed - Bank Declined Transaction - 0399-failure",
   			 "payment_date": "2019-12-03 17:27:44",
   			 "status": "Failure",
    		 "transaction_guid": "06788c4e-1032-42f8-a948-9e375cb56032",
    		 "user_guid": ""
	  			}
			}';
				*/
		v_transaction_id character varying(256);
		v_total_payment numeric;
		v_transaction_status text;
		v_payment_date timestamp;
		v_reason text;
		v_order_number character varying(1000);
		v_pg_transaction_id character varying(1000);
		v_transaction_guid character varying(1000);
		v_user_guid character varying(1000);
		v_email_id character varying(1000);
		v_user_full_name character varying(1000);
		v_subject text;
		v_json jsonb;
		v_msg text;
		v_transaction_status_1 text;
		v_race_category_name text;
		v_user_id numeric;
		v_race_category_id numeric;
		v_bib_no numeric;
		v_subject_bib text;
		v_mail_sent numeric;
	begin	
	
	
		select 	p_json->'eventjinidata'->>'transaction_id',
				p_json->'eventjinidata'->>'amount',
				p_json->'eventjinidata'->>'order_number',
				p_json->'eventjinidata'->>'pg_transaction_id',
				p_json->'eventjinidata'->>'reason',
				p_json->'eventjinidata'->>'payment_date',
				p_json->'eventjinidata'->>'status',
				p_json->'eventjinidata'->>'transaction_guid',
				p_json->'eventjinidata'->>'user_guid'
		into 	v_transaction_id,
				v_total_payment,
				v_order_number,
				v_pg_transaction_id,
				v_reason,
				v_payment_date,
				v_transaction_status,
				v_transaction_guid,
				v_user_guid;
			
			select a.email_id,a.user_full_name ,b.transaction_status,c.race_category_name,a.user_id,
				   a.race_category_id
			into v_email_id , v_user_full_name,v_transaction_status_1,v_race_category_name,v_user_id,
				 v_race_category_id
	 		from labmao.labmao_web_user a
			left join labmao.labmao_user_transaction b on a.user_guid=b.user_guid
			left join labmao.labmao_race_category c on  a.race_category_id= c.race_category_id
	 		where 	a.user_guid = v_user_guid;
			
			
			if lower(v_transaction_status)= 'success' then
				
				select max(bib_no)+1 into v_bib_no from labmao.labmao_user_transaction;
				
				v_subject_bib := 'Download your Run As One e-bib now!';
				
				v_mail_sent  = 1;
				
			end if;
			
			raise notice '%',v_user_id;
			
			if lower(v_transaction_status_1) = 'success' then
				
				v_msg := 'Thank You for registering for Run As One. Get set and lace up, race day is round the conrer!';
				v_subject := 'Run As Run | Your Run As One Registration is successful!';						
			else
			
					update labmao.labmao_user_transaction
					set transaction_id= v_transaction_id,
						total_payment = v_total_payment,
						transaction_status = v_transaction_status,
						payment_date= v_payment_date,
						reason= v_reason,
						order_number=v_order_number,
						pg_transaction_id = v_pg_transaction_id,
						transaction_json = p_json,
						bib_no = v_bib_no,
						mail_sent = v_mail_sent						
					where transaction_guid = v_transaction_guid
					and user_guid = v_user_guid;
			
	 		end if;
	 
	 
	 	if lower(v_transaction_status) = 'failure' then
			v_msg := 'Transaction Failed. Please Try again';
			v_subject := 'Your Run As One registration could not be completed';
		elseif lower(v_transaction_status) = 'success' then
			v_msg := 'Thank You for registering for Run As One. Get set and lace up, race day is round the conrer!';
			v_subject := 'Thank You for Registering for Run As One';
		end if;	 
		
		
		insert into labmao.labmao_user_transaction_history(user_transaction_history_id,user_id,email_id,user_guid,transaction_id,
											total_payment,transaction_status,transaction_date,
											race_category_id,transaction_json,transaction_guid,reason,pg_transaction_id,
											payment_date,order_number)	 
		values(nextval('labmao.seq_labmao_user_transaction_history_id'),v_user_id,v_email_id,v_user_guid,v_transaction_id,
						  v_total_payment,v_transaction_status,current_timestamp at time zone 'utc',
			   			  v_race_category_id,p_json,uuid_generate_v4(),v_reason,v_pg_transaction_id,
			   			  v_payment_date,v_order_number);
	
			v_json := p_json::jsonb;
			
			v_json := jsonb_set(v_json, '{eventjinidata,email_id}', ('"'||v_email_id||'"')::text::jsonb, true);	
			v_json := jsonb_set(v_json, '{eventjinidata,user_name}', ('"'||v_user_full_name||'"')::text::jsonb, true);	 
			v_json := jsonb_set(v_json, '{eventjinidata,subject}', ('"'||v_subject||'"')::text::jsonb, true);	
			v_json := jsonb_set(v_json, '{eventjinidata,msg}', ('"'||v_msg||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{eventjinidata,race_category_name}', ('"'||v_race_category_name||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{eventjinidata,bib_no}', ('"'||coalesce(v_bib_no::text,'')||'"')::jsonb, true);
			v_json := jsonb_set(v_json, '{eventjinidata,subject_bib}', ('"'||coalesce(v_subject_bib::text,'')||'"')::jsonb, true);
			
			
			p_user_data := v_json;	
			
			exception when others then
     		p_user_data := '{}';
		
	end;

	$$;


--
