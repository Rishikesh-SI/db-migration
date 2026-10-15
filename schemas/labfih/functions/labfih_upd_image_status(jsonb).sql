-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_upd_image_status(jsonb)
-- Type: FUNCTION

-- Name: labfih_upd_image_status(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_upd_image_status(p_assetjson jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_image_id numeric;
i jsonb;
v_status numeric;
begin

for i in select * from jsonb_array_elements(p_assetjson)
      loop
	  
	  select i->>'image_id',
	    	 i->>'status'
	   into
	   v_image_id,
	   v_status;

update labfih.labfih_image 
set is_displayed = v_status
where image_id = v_image_id
--and is_displayed = 1;
and (is_displayed is null or is_displayed = 0);

end loop;

p_result:=1;

end;
$$;


--
