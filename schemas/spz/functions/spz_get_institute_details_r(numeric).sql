-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_institute_details_r(numeric)
-- Type: FUNCTION

-- Name: spz_get_institute_details_r(numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_institute_details_r(p_instituteid numeric, OUT p_result numeric, OUT p_institutejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     
begin
     
     select '{ "data" :' || row_to_json(a) || '}'
	 into p_institutejson
     from (select i.* , c.city_name, c.state_id, s.state_name
           from spz.spz_institute_master i
           inner join spz.spz_city_master c 
           on (i.city_id = c.city_id) 
           inner join spz.spz_state_master s 
           on (c.state_id = s.state_id)
           where institute_id = p_instituteid
          )a 
      ;
     
     p_result := 1;
   
end;

 

$$;


--
