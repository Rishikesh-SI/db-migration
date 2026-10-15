-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_video_upload_detail(numeric)
-- Type: FUNCTION

-- Name: labpkl_v1_get_video_upload_detail(numeric); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_video_upload_detail(p_id numeric, OUT p_result numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

declare
	
     
begin
	
    select video_json into p_videojson  from labpkl_v1.labpkl_v1_video_upload
	where video_upload_id = p_id ;
	
	p_result := 1 ;
     
exception	
     when others then
     	p_result := -1;
     
end;

 
$$;


--
