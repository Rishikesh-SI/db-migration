-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_url(character varying)
-- Type: FUNCTION

-- Name: labpkl_v1_get_url(character varying); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_url(p_url character varying, OUT p_new_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

declare
v_url varchar;
begin 

select regexp_replace(a,'[ ]+','-','g') into v_url from
(
	select regexp_replace(trim(p_url),'[^a-za-z0-9 ]','','g') as a
)as b;

p_new_url:=v_url;

end;

 $$;


--
