-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_get_user_display_name(numeric)
-- Type: FUNCTION

-- Name: utt_get_user_display_name(numeric); Type: FUNCTION; Schema: utt; Owner: -
--

CREATE FUNCTION utt.utt_get_user_display_name(p_userid numeric, OUT p_userdisplayname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_userdisplayname
	from   utt.utt_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_userdisplayname := ' ';

end;

 $$;


--
