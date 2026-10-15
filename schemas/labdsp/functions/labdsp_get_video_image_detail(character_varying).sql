-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_get_video_image_detail(character varying)
-- Type: FUNCTION

-- Name: labdsp_get_video_image_detail(character varying); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_get_video_image_detail(p_video_url character varying, OUT p_result numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

declare
v_video_url text;
v_json text := '{"Data":';

begin
v_video_url:= p_video_url;


execute'select row_to_json(row) as a
     		from (select a.video_id,a.title,a.title_alias,a.video_url,
            a.video_guid,b.image_id,b.image_path,b.image_file_name
            from labdsp.labdsp_video a
            join labdsp.labdsp_image b on a.image_id = b.image_id
            where a.video_url like ''%'||v_video_url||'%'')row'
into p_videojson;

p_result = 1;
p_videojson = v_json||p_videojson||'}';



end;

$$;


--
