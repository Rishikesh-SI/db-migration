-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_ins_new_emailid()
-- Type: FUNCTION

-- Name: labstlz_ins_new_emailid(); Type: FUNCTION; Schema: labstlz; Owner: -
--

CREATE FUNCTION labstlz.labstlz_ins_new_emailid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

begin
	
     if tg_op = 'INSERT' then
          if not exists(select 1 from labstlz.labstlz_new_email_id where user_guid = new.user_guid) then
          	insert into labstlz.labstlz_new_email_id
    			select new.email_id,new.user_guid,0,CURRENT_TIMESTAMP at time zone 'utc',CURRENT_TIMESTAMP at time zone 'utc';
		end if;
    	elsif tg_op = 'UPDATE' then
          if exists(select 1 from labstlz.labstlz_new_email_id where user_guid = new.user_guid and email_id is null and status = 0) then
          	update labstlz.labstlz_new_email_id
               set email_id = new.email_id, updated_date = CURRENT_TIMESTAMP at time zone 'utc'
               where user_guid = new.user_guid;
		end if;
    	end if;
     
    	return null;
     
end;

$$;


--
