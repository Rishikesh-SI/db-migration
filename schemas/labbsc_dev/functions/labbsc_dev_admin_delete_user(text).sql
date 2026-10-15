-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_admin_delete_user(text)
-- Type: FUNCTION

-- Name: labbsc_dev_admin_delete_user(text); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_admin_delete_user(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_user_id numeric;
v_user_guid text;
begin 


select user_id,user_guid
from labbsc_dev.labbsc_dev_web_user
where email_id=p_email_id
into v_user_id,v_user_guid;

if v_user_id is not null then

insert into labbsc_dev.labbsc_dev_admin_delete_user
  select * from labbsc_dev.labbsc_dev_web_user
where user_id=v_user_id;


delete from  labbsc_dev.labbsc_dev_user_tests
where user_id =v_user_id;


delete from  labbsc_dev.labbsc_dev_web_user
where user_id =v_user_id;


delete from  labbsc_dev.labbsc_dev_client_web_cust_model
where user_guid =v_user_guid;


update labbsc_dev.labbsc_dev_admin_delete_user
set updated_date=current_timestamp
where user_id=v_user_id;

p_out:=1;

else 
p_out:=2;
end if;



end;

$$;


--
