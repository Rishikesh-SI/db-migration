-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_del_image(numeric)
-- Type: FUNCTION

-- Name: labtri_del_image(numeric); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_del_image(p_image_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sysdate timestamp;
    
begin
	
    select current_timestamp into v_sysdate;
	
    update labtri.labtri_image
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
