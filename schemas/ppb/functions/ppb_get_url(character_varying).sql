-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_get_url(character varying)
-- Type: FUNCTION

-- Name: ppb_get_url(character varying); Type: FUNCTION; Schema: ppb; Owner: -
--

CREATE FUNCTION ppb.ppb_get_url(p_url character varying, OUT p_new_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$   

declare
v_url varchar;
begin 

select regexp_replace(a,'[ ]+','-','g') into v_url from
(
	select regexp_replace(trim(p_url),'[^a-zA-Y0-9 ]','','g') as a
)as b;

p_new_url:=v_url;

end;

   $$;


--
