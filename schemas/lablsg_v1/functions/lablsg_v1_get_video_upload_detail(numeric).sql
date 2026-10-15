-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_video_upload_detail(numeric)
-- Type: FUNCTION

-- Name: lablsg_v1_get_video_upload_detail(numeric); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_video_upload_detail(p_id numeric, OUT p_result numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
     
begin
	
    select video_json into p_videojson  from lablsg_v1.lablsg_v1_video_upload
	where video_upload_id = p_id ;
	
	p_result := 1 ;
     
exception	
     when others then
     	p_result := -1;
     
end;
$$;


--
