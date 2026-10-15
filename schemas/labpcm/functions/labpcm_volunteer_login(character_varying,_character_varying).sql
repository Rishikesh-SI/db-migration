-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_volunteer_login(character varying, character varying)
-- Type: FUNCTION

-- Name: labpcm_volunteer_login(character varying, character varying); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_volunteer_login(p_user_name character varying, p_login_password character varying, OUT p_status numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 declare 
 
 v_username character varying(500);
 v_volunteer_guid character varying(500);
 v_volunteer_detail_id numeric;
 v_json jsonb;
  begin
  
  
	begin
		select volunteer_guid,volunteer_detail_id
		  into  v_volunteer_guid,v_volunteer_detail_id
		from labpcm.labpcm_volunteer_detail
        where username =p_user_name
		 and login_password =p_login_password
		;
	exception when no_data_found then 
	v_volunteer_guid := null;
	end;	 
		 
		 
		 if v_volunteer_guid is not null
		 then
		 p_status := 1;
		 
		 select row_to_json(row) as jsonrow
		 from (select v_volunteer_detail_id as volunteer_detail_id,
			         v_volunteer_guid as volunteer_guid,
			         p_user_name as username) as row
					into v_json ;
		 
		-- v_json :=   jsonb_set('{volunteer_guid}', ('"'||v_volunteer_guid||'"')::text::jsonb, true); 
		--- v_json :=   jsonb_set(v_json, '{username}', ('"'||p_user_name||'"')::text::jsonb, true);  

         else
		 p_status := 0;
		 v_json := null;
		 
           end if;
      p_json := v_json;
exception when others
then
 null;

  end;
  
   

$$;


--
