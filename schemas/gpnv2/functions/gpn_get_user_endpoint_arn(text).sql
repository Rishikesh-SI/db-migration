-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_get_user_endpoint_arn(text)
-- Type: FUNCTION

-- Name: gpn_get_user_endpoint_arn(text); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_get_user_endpoint_arn(p_device_token text, OUT p_endpoint_arn text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
v_user_id numeric;

begin

select endpoint_arn from gpnv2.gpn_user
where application_id in (4,5,6)
 and device_token=p_device_token
into p_endpoint_arn;

exception when others then
p_endpoint_arn:='';
 
end;
$$;


--
