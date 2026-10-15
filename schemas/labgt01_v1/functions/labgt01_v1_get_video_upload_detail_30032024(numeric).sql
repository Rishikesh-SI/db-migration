-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_video_upload_detail_30032024(numeric)
-- Type: FUNCTION

-- Name: labgt01_v1_get_video_upload_detail_30032024(numeric); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_video_upload_detail_30032024(p_id numeric, OUT p_result numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
     
begin
	
    select video_json into p_videojson  from labgt01_v1.labgt01_v1_video_upload
	where video_upload_id = p_id ;
	
	p_result := 1 ;
     
exception	
     when others then
     	p_result := -1;
     
end;
$$;


--
