-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_match_cent_ser_det_r(numeric)
-- Type: FUNCTION

-- Name: labhkind_get_match_cent_ser_det_r(numeric); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_match_cent_ser_det_r(p_series_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
begin
	if p_series_id is not null then 
	
	select match_centre_json into p_json
	from labhkind.labhkind_match_centre
	where series_id=p_series_id and is_active=1 and is_published=1;
	end if ;
exception when others then 	
   p_json :=null;
end;

$$;


--
