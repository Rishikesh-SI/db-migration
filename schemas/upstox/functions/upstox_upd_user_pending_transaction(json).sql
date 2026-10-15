-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_upd_user_pending_transaction(json)
-- Type: FUNCTION

-- Name: upstox_upd_user_pending_transaction(json); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_upd_user_pending_transaction(p_json json, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$	
	
	declare

	/*p_user_data jsonb := '{
  "eventjinidata": [
    {
      "user_guid": "2e178504-d9ae-408b-a4b2-3c8680403a71",
      "order_number": "10012020054710961-111",
      "payment_date": "2020-01-10T22:18:09",
      "transaction_id": "146363299",
      "transaction_guid": "9636b80f-d739-479b-8936-9e8509ee0c99",
      "pg_transaction_id": "443765801",
      "transaction_status": "Success",
      "email_id": "tHj+0hHAHM+YXibv02qJbxy4efAq9H+CB3/gUPQZBSjYtIPSa7pXsDL0Qq/YKmZC"
    },
    {
      "email_id": "IVQyTSFejJlInvuq0wJ9mOsIuxMFEMMGSYv02f57b8pxXgzVRbQB2RFR1LqpT3Lvi0/bFu6oIzhiTMV6utqc5A==",
      "user_guid": "01476ec6-1379-4940-9609-27310c16e4b8",
      "order_number": "11012020120258801-112",
      "payment_date": "2020-01-11T16:33:15",
      "transaction_id": "146415157",
      "transaction_guid": "9c22d8f5-abe0-4b12-aeec-90b32ce6ed09",
      "pg_transaction_id": "443935958",
      "transaction_status": "Success"
    },
    {
      "email_id": "BF4mEh2cM1Ihs1qdhM6/Sd9Oqf9Etp/gdhV9vsmUXAqFSMoinK/UfTs72x6q51AXL5wonhmjRPptQClVvCcFHQ==",
      "user_guid": "c9b4f601-f7e2-41d6-9f2b-e32537776ace",
      "order_number": "10012020031524407-106",
      "payment_date": "2020-01-10T19:47:19",
      "transaction_id": "146351486",
      "transaction_guid": "7e13315f-5eaf-490f-beae-6c7cfc432ae1",
      "pg_transaction_id": "443727321",
      "transaction_status": "Pending"
    	}
 	 ]
	}';*/

	i record ;
	
	begin

			for i in select b->>'user_guid' user_guid, b->>'order_number' order_number,
					   b->>'transaction_guid' transaction_guid, b->>'transaction_status' transaction_status
				from (
				select b
				from json_array_elements(p_json->'eventjinidata') b)as a 

				loop
					update upstox.upstox_user_transaction
					set transaction_status = i.transaction_status
				 	where transaction_guid = i.transaction_guid 
				 	and  user_guid = i.user_guid and lower(transaction_status)= 'pending';

				end loop;
				
				p_result := 1;

			exception when others then
     		p_result := 2;	
			
		
	end;

	$$;


--
