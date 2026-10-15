-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_del_image(numeric)
-- Type: FUNCTION

-- Name: labadkr_del_image(numeric); Type: FUNCTION; Schema: labadkr; Owner: -
--

CREATE FUNCTION labadkr.labadkr_del_image(p_image_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sysdate timestamp;
    
begin
	
    select current_timestamp into v_sysdate;
	
    update labadkr.labadkr_image
	set updated_date=v_sysdate,
    is_active=0,
    is_deleted=1,
    is_published=0
	where image_id=p_image_id;
    
    p_result := 1;
    
exception
	
    when others then
    	p_result := -1;
end ;

 $$;


--
