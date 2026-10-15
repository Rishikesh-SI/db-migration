-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_get_video_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labdsp_get_video_detail(numeric, numeric); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_get_video_detail(p_videoid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_guid text;
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number,video_guid
          into strict v_versionnumber,v_guid
          from   	  labdsp.labdsp_video
          where  	  video_id = p_videoid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
          select    video_guid
          into strict v_guid
          from   	  labdsp.labdsp_video
          where  	  video_id = p_videoid;
          
     end if;
     
     select 	  asset_data
     into strict p_videojson
     from   	  labdsp.labdsp_asset_draft
     where  	  asset_type_id  = 4
     and    	  asset_id       = p_videoid
	and    	  version_number = v_versionnumber;
     
      
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.user_name
      from   labdsp.labdsp_user_role as ur
      join   labdsp.labdsp_user as u
      on     u.user_id = ur.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0) as row)
     into v_authorjsonarr;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     v_json1 := substring(v_json1,1,(length(v_json1)-1));
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     p_result := 1;
     
      p_videojson:= jsonb_set(p_videojson, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
     
exception
	
    when others then
    	p_result := -1;
     
end;

 

$$;


--
