-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_ins_upd_forget_password(character varying)
-- Type: FUNCTION

-- Name: khi_ins_upd_forget_password(character varying); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_ins_upd_forget_password(p_mailid character varying, OUT p_resetkey character varying, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	  v_userjson jsonb;
     -- v_userjson text;
     v_json varchar(30000) := '{"users":';
     v_forget_password_id numeric;
     v_reset_kay_guid character varying(256);
     v_currenttimestamp timestamp;
     v_emailid character varying := lower(p_mailid);
	 
begin
   
   v_currenttimestamp := current_timestamp at time zone 'utc';
   
   if (select 1 from khi.khi_user where email_id = p_mailid
       and is_published = 1 and is_active = 1 and is_deleted = 0)
   then
   		v_forget_password_id := nextval('khi.seq_khi_forget_password_id');
        v_reset_kay_guid := uuid_generate_v4();
        
       insert into khi.khi_forget_password 
       	(forget_password_id, user_id, email_id, reset_key_guid, key_expiry_date,
		created_date, updated_date, created_by, updated_by, is_active, is_deleted)
   		select v_forget_password_id, user_id , email_id, v_reset_kay_guid, v_currenttimestamp + interval '1' day,
        		v_currenttimestamp, v_currenttimestamp, 1, 1, 1 ,0
        from khi.khi_user 
	 	where lower(email_id) = v_emailid 
        and is_published = 1
        and is_active = 1 
        and is_deleted = 0;
     
    	p_resetkey := v_reset_kay_guid ;
     
     p_result := 1 ;
    
     
   else 
   		p_result := -2 ; -- email id not exists 
   end if ; 
	 
     
end;

$$;


--
