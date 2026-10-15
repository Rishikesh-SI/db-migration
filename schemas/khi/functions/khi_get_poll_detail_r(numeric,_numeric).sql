-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_poll_detail_r(numeric, numeric)
-- Type: FUNCTION

-- Name: khi_get_poll_detail_r(numeric, numeric); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_poll_detail_r(p_pollid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_polljson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     
begin
	
     if p_versionnumber is null then
     	
          /*select      published_version_number
          into strict v_versionnumber
          from   	  khi.khi_poll
          where  	  poll_id = p_pollid;*/
          
          select version_number
          into strict v_versionnumber
          from khi.khi_asset_draft ad
          where asset_type_id = 6
          and asset_id = p_pollid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_polljson
     from   	  khi.khi_asset_draft
     where  	  asset_type_id  = 6
     and    	  asset_id       = p_pollid
	and    	  version_number = v_versionnumber;
     
     /*select image_path
     into   v_image_path
     from 	khi.khi_image
     where image_id = (
     select asset_id
     from   khi.khi_poll_asset_map
     where  poll_id = p_pollid
     and is_cover = 1);*/
     
     -- p_polljson := jsonb_set(p_polljson,'{data,image_path}',v_image_path::text::jsonb);
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.user_name
      from   khi.khi_user_role as ur
      join   khi.khi_user as u
      on     u.user_id = ur.user_id
      join   khi.khi_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 6
      and    aa.action_id = 4
      and    aa.asset_id = p_pollid) as row)
     into v_authorjsonarr;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     SELECT COUNT(1)
     INTO    v_author_count
     FROM    UNNEST(v_authorjsonarr) author_id;
     
     IF v_author_count > 0 THEN
     	v_json1 := substring(v_json1,1,(length(v_json1)-1));
     else
     	V_JSON1:= substring(v_json1,1,(length(v_json1)));
     end if;
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
     p_result := 1;
     
exception
	
     when others then
     	p_result := -1;
     
end;

$$;


--
