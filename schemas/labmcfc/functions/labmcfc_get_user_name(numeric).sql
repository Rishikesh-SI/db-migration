-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labmcfc_get_user_name(numeric); Type: FUNCTION; Schema: labmcfc; Owner: -
--

CREATE FUNCTION labmcfc.labmcfc_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labmcfc.labmcfc_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
