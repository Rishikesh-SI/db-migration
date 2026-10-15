-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_get_new_emailid()
-- Type: FUNCTION

-- Name: labstlz_get_new_emailid(); Type: FUNCTION; Schema: labstlz; Owner: -
--

CREATE FUNCTION labstlz.labstlz_get_new_emailid(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
	v_email_id_arr text[];
	v_count numeric;
    
begin
	
    select count(1) from labstlz.labstlz_new_email_id where updated_date::date = (CURRENT_TIMESTAMP at time zone 'utc' )::date and status = 1
	into v_count;

	if v_count < 2000 then
       	select array(select email_id from labstlz.labstlz_new_email_id 
                     where status = 0 and email_id is not null
                  	 order by email_id limit 200) 
       	into v_email_id_arr;

 		update labstlz.labstlz_new_email_id
        set status = 2,
        updated_date = CURRENT_TIMESTAMP at time zone 'utc' 
        where email_id in(select unnest(v_email_id_arr))
        and status = 0 ;
      
        select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
        from (select email_id, user_guid from labstlz.labstlz_new_email_id 
              where email_id in(select unnest(v_email_id_arr)) and status = 2)row
		into p_json;
	else 
  		p_json:= '{"data":[]}';
	end if;  
  
end;

$$;


--
