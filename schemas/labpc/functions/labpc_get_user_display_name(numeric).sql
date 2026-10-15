-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_get_user_display_name(numeric)
-- Type: FUNCTION

-- Name: labpc_get_user_display_name(numeric); Type: FUNCTION; Schema: labpc; Owner: -
--

CREATE FUNCTION labpc.labpc_get_user_display_name(p_userid numeric, OUT p_userdisplayname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_userdisplayname
	from   labpc.labpc_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_userdisplayname := ' ';

end;

 $$;


--
