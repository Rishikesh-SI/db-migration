-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_user_photobooth_uploadcount(character varying)
-- Type: FUNCTION

-- Name: labwis_get_user_photobooth_uploadcount(character varying); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_user_photobooth_uploadcount(p_user_guid character varying, OUT v_uploadcount numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
	
BEGIN
   
	SELECT COUNT(gallery_id) 
    INTO v_uploadcount
    FROM labwis.labwis_gallery
    WHERE user_guid = p_user_guid AND gallery_path = 'photobooth'; 

EXCEPTION
    WHEN OTHERS THEN
        
        v_uploadcount := 0;
END;
$$;


--
