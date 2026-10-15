-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_registered_user_list_r(text)
-- Type: FUNCTION

-- Name: labbsc_dev_get_registered_user_list_r(text); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_registered_user_list_r(p_email_id text, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
-- select * from labbsc_dev.labbsc_dev_user limit 1
begin
if p_email_id is not null and exists(select 1 from labbsc_dev.labbsc_dev_web_user
									 where email_id = p_email_id) then
		select '{"data":'||row_to_json(row)||'}'
          from
          (
			    select user_id,user_guid,partner_name,module_name,email_id,
			  first_name,last_name,created_date
                    from labbsc_dev.labbsc_dev_web_user
			  where email_id=p_email_id
			  
			  )as row
			  into p_user_json;
              
else 
p_user_json:='{"data":{}}';
end if;

end;
$$;


--
