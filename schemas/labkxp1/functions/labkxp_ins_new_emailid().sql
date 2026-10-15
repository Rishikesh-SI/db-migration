-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_ins_new_emailid()
-- Type: FUNCTION

-- Name: labkxp_ins_new_emailid(); Type: FUNCTION; Schema: labkxp1; Owner: -
--

CREATE FUNCTION labkxp1.labkxp_ins_new_emailid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

begin
	
     if tg_op = 'INSERT' then
          if not exists(select 1 from labkxp.labkxp_new_email_id where user_guid = new.user_guid) then
          	insert into labkxp.labkxp_new_email_id
    			select new.email_id,new.user_guid,0,CURRENT_TIMESTAMP at time zone 'utc',CURRENT_TIMESTAMP at time zone 'utc';
		end if;
    	elsif tg_op = 'UPDATE' then
          if exists(select 1 from labkxp.labkxp_new_email_id where user_guid = new.user_guid and email_id is null and status = 0) then
          	update labkxp.labkxp_new_email_id
               set email_id = new.email_id, updated_date = CURRENT_TIMESTAMP at time zone 'utc'
               where user_guid = new.user_guid;
		end if;
    	end if;
     
    	return null;
     
end;

$$;


--
