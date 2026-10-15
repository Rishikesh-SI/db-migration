-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ins_product_review(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_product_review(jsonb); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_ins_product_review(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
v_product_review_id 				numeric;
v_product_id						numeric;
v_userid 							numeric;
v_user_email_id 					character varying;
v_store								character varying;
v_replay_text						text;
v_rating							numeric;
v_review_title 						character varying;
v_review_desc						text;
v_sysdate 							timestamp;
v_created_by 						numeric;
V_updated_by						numeric;
V_review_guid						character varying;
v_is_approved						numeric;

BEGIN

		select current_timestamp
		into   v_sysdate;
		
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/* ** Get data from JSON	** */
		
		SELECT 	
				v_json->'review'->>'product_id',
				v_json->'review'->>'user_id',
				v_json->'review'->>'customer_email_id',
				v_json->'review'->>'store',
				v_json->'review'->>'replay_text',
				v_json->'review'->>'title',
				v_json->'review'->>'rating',
				v_json->'review'->>'review_text',
				v_json->'review'->>'created_by',
				v_json->'review'->>'updated_by',
				v_json->'review'->>'is_approved'
				
		INTO            
				v_product_id,
				v_userid,
				v_user_email_id,
				v_store,
				v_replay_text,
				v_review_title,
				v_rating,
				v_review_desc,				
				v_created_by,
				V_updated_by,
				v_is_approved
				;
		---------------------------------------------------------------        

		
			V_review_guid := uuid_generate_v4();	
			v_product_review_id   := nextval('dd.seq_dd_product_review_id');
            
            v_json 	         := jsonb_set(v_json, '{review,product_review_id}', v_product_review_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{review,review_guid}', ('"'||v_review_guid||'"')::text::jsonb, true);

			insert into dd.dd_product_review
			(
				product_review_id, product_id, store, user_id, customer_email_id, review_title, review_text, replay_text,
				rating, is_approved, review_json, review_date, created_date, updated_date, created_by, updated_by, review_guid,
				is_active, is_deleted, is_published	
			)    
			values
			(
				v_product_review_id, v_product_id, v_store, v_userid, v_user_email_id, v_review_title, v_review_desc, v_replay_text, 
				v_rating, v_is_approved, v_json, v_sysdate, v_sysdate, v_sysdate, v_created_by, V_updated_by, v_review_guid, 1, 0 ,1 
			);    
		
		

		p_result := 1;

		p_data := v_json;
		
/*	exception 
		when others then 
			p_result := -1;
			p_data := '{}';
*/		
END;

    

$$;


--
