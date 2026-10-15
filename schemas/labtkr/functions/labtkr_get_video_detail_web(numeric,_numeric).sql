-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_get_video_detail_web(numeric, numeric)
-- Type: FUNCTION

-- Name: labtkr_get_video_detail_web(numeric, numeric); Type: FUNCTION; Schema: labtkr; Owner: -
--

CREATE FUNCTION labtkr.labtkr_get_video_detail_web(p_videoid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_versionnumber numeric;
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     
begin
	
     if p_versionnumber is null then
     	
          /*select      published_version_number
          into strict v_versionnumber
          from   	  labtkr.labtkr_video
          where  	  video_id = p_videoid;*/
          
          select version_number
          into strict v_versionnumber
          from labtkr.labtkr_asset_draft ad
          where asset_type_id = 4
          and asset_id = p_videoid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_videojson
     from   	  labtkr.labtkr_asset_draft
     where  	  asset_type_id  = 4
     and    	  asset_id       = p_videoid
	and    	  version_number = v_versionnumber;
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.user_name
      from   labtkr.labtkr_user_role as ur
      join   labtkr.labtkr_user as u
      on     u.user_id = ur.user_id
      join   labtkr.labtkr_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 4
      and    aa.action_id = 4
      and    aa.asset_id = p_videoid) as row)
     into v_authorjsonarr;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     v_json1 := substring(v_json1,1,(length(v_json1)-1));
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
exception
	
     when others then
     	p_result := -1;
     
end;

 $$;


--
