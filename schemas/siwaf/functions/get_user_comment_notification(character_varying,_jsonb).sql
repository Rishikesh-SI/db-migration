-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_comment_notification(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_user_comment_notification(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_comment_notification(p_schema_prefix character varying, p_json jsonb, OUT p_user_comment_notification jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	v_user_guid character varying(256);
	v_user_id numeric;
	v_new jsonb;
	v_earlier jsonb;
	v_data jsonb := '{"new":null,"earlier":null}';
    v_date timestamp;
     
begin
	
     select p_json->>'user_guid' into v_user_guid;
	
	execute 'select user_id from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
     		where user_guid = '''||v_user_guid||''''
	into v_user_id;
	
     execute 'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
     		from (select comment_id, array_to_json(array_agg(row))as user_data
               		from (select comment_id, reaction_id, (reaction_date + ''5.5 hours''::interval) as reaction_date, tab.user_id, c.user_full_name, c.profile_picture_url,
                         			c.client_id, c.is_custom_image
                         		from (select a.user_asset_reaction_id as comment_id, b.reaction_id, b.user_id, b.reaction_date
                                   		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction a
                                             join '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction b
                                             on ((a.user_asset_reaction_id = b.parent_comment_id
                                             	or a.user_asset_reaction_id = b.is_reply_to))
									where a.user_id = '||v_user_id||'
                                       	and b.user_id <> '||v_user_id||'
                                   		and b.reaction_id = 4
                                   		and coalesce(b.is_read, 0) = 0
									union all
                                         	select a.user_asset_reaction_id as comment_id, b.reaction_id, b.user_id, b.reaction_date
								 	from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction a
									join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction b
                                   		on a.user_asset_reaction_id = b.comment_id
									where a.user_id =  '||v_user_id||'
                                    	and b.user_id <> '||v_user_id||'
                                   		and b.reaction_id <> 4
                                   		and coalesce(b.is_read, 0) = 0
                                   	) tab
                                   join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user c
                                   on tab.user_id = c.user_id
                                   order by reaction_date desc
						)row
					group by comment_id
                   
				)tab'
	into v_new;
  	
	if v_new is not null then
		v_data := jsonb_set(v_data::jsonb,'{new}',v_new,true);
	end if;
    
    	v_date := CURRENT_TIMESTAMP at time zone 'UTC' - '48 hours'::interval;
        
       
  	
     execute 'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
     		from (select comment_id, array_to_json(array_agg(row))as user_data
               		from (select comment_id, reaction_id, (reaction_date + ''5.5 hours''::interval) as reaction_date, tab.user_id, c.user_full_name, c.profile_picture_url,
                         			c.client_id, c.is_custom_image
                         		from (select a.user_asset_reaction_id as comment_id, b.reaction_id, b.user_id, b.reaction_date
                                   		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction a
                                             join '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction b
                                             on (a.user_asset_reaction_id = b.parent_comment_id
                                             	or a.user_asset_reaction_id = b.is_reply_to)
									where a.user_id = '||v_user_id||'
                                    	and b.user_id <> '||v_user_id||'
                                   		and b.reaction_id = 4
                                   		and b.is_read = 1                                      
									union all
                                         	select a.user_asset_reaction_id as comment_id, b.reaction_id, b.user_id, b.reaction_date
								 	from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction a
									join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction b
                                   		on a.user_asset_reaction_id = b.comment_id
									where a.user_id =  '||v_user_id||'
                                    	and b.user_id <> '||v_user_id||'
                                   		and b.reaction_id <> 4
                                   		and b.is_read = 1                                       
                                   	) tab
                                   join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user c
                                   on tab.user_id = c.user_id
                                   where reaction_date > '''||v_date||'''
                                   order by reaction_date desc
						)row
                        
					group by comment_id
                    
                   
				)tab'
	into v_earlier;
   
 	
	if v_earlier is not null then
		v_data := jsonb_set(v_data::jsonb,'{earlier}',v_earlier,true);
	end if;
	
     p_user_comment_notification := v_data;
     
end;

$$;


--
