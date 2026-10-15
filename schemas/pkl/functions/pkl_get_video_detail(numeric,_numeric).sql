-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_get_video_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: pkl_get_video_detail(numeric, numeric); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_get_video_detail(p_videoid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$  

declare
	
     v_versionnumber numeric;
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  pkl.pkl_video
          where  	  video_id = p_videoid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_videojson
     from   	  pkl.pkl_asset_draft
     where  	  asset_type_id  = 4
     and    	  asset_id       = p_videoid
	and    	  version_number = v_versionnumber;
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.user_name
      from   pkl.pkl_user_role as ur
      join   pkl.pkl_user as u
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
     
exception
	
     when others then
     	p_result := -1;
     
end;

  $$;


--
