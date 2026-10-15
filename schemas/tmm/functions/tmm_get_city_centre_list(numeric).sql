-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_city_centre_list(numeric)
-- Type: FUNCTION

-- Name: tmm_get_city_centre_list(numeric); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_city_centre_list(p_city_id numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare 
err_msg text;
v_centre_json jsonb;

begin

select '{"data":{"city":['||string_agg(row_to_json(row)::text,',')||']}}' into  p_data
from (
select city_id,name
from tmm.tmm_city
    where is_active = 1
	)row;
	
select '['||string_agg(row_to_json(row)::text,',')||']' into v_centre_json
from (	
select centre_id,name,city_id
from tmm.tmm_city_center
where city_id=p_city_id
)row;

--raise notice '% ',v_centre_json;
 p_data   := jsonb_set(p_data, '{data,centre}', coalesce(v_centre_json,'[]'), true);

 exception 
    when others then
	    --err_code := SQLSTATE;
          err_msg := SQLERRM;
		 -- p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(err_msg, '')||'"}}';

end ;

$$;


--
