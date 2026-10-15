-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_get_volunteer_detail(character varying)
-- Type: FUNCTION

-- Name: labpcm_get_volunteer_detail(character varying); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_get_volunteer_detail(p_volunteer_guid character varying, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

  
declare
v_json jsonb;
v_volunteer_detail_id numeric;
begin

select volunteer_detail_id ,data
from labpcm.labpcm_volunteer_detail
where volunteer_guid=p_volunteer_guid
into v_volunteer_detail_id,v_json;
p_result := 1;
p_json := jsonb_set(v_json, '{volunteer_detail_id}', ('"'||v_volunteer_detail_id||'"')::text::jsonb, true);  
         
exception when others 
then p_result := 0;

end;

$$;


--
