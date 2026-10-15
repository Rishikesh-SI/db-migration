-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _upd_del_user_asset_comments(character varying, jsonb)
-- Type: FUNCTION

-- Name: _upd_del_user_asset_comments(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._upd_del_user_asset_comments(p_schema_prefix character varying, p_input_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$

/*
{
  "comment_id": "1",
  "option": "E/D",
  "comment_text": "",
  "user_guid": "",
  "source": "F/B"
}
*/
declare
	
     v_source char(1);
     v_user_guid character varying(500);
     v_comment_id numeric;
     v_option char(1);
     v_comment_text text;
     v_user_id numeric;
     v_current_timestamp timestamp := current_timestamp at time zone 'utc';
     v_parent_comment_id numeric;
     v_reply_count numeric;
     
begin
	
     select p_input_json->>'source', p_input_json->>'user_guid', p_input_json->>'comment_id', p_input_json->>'option',
     		p_input_json->>'comment_text'
     into v_source, v_user_guid, v_comment_id, v_option, v_comment_text;
     
     if v_source = 'F' then
		
          execute 'select user_id from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user where user_guid = $1'
          into v_user_id
          using v_user_guid;

     end if;
     
     if (((v_source = 'F' and v_user_id is not null) or (v_source = 'B' and v_user_id is null)) and v_comment_id is not null) then
     	
          if v_option = 'E' then
          	
               execute 'select user_asset_reaction_id
               		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                    	where user_asset_reaction_id = $1
                         and user_id = case $2 when 0 then user_id else $2 end'
			into v_comment_id
          	using v_comment_id, coalesce(v_user_id,0); 
               
               if v_comment_id is not null then
               	
                    execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_deleted_comments
               			select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date,
                              		parent_comment_id, is_reply_to, $3, $4, $5
						from labmi.labmi_user_asset_reaction
          				where user_asset_reaction_id = $1
                         	and user_id = case $2 when 0 then user_id else $2 end'
				using v_comment_id, coalesce(v_user_id,0), v_current_timestamp, v_option, v_source;
          		
          		execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                    		set comment_text = $3
                    		where user_asset_reaction_id = $1
                    		and user_id = case $2 when 0 then user_id else $2 end'
				using v_comment_id, coalesce(v_user_id,0), v_comment_text;
          		
          		p_result := 1;
                    
               else
               	
                    p_result := 0;
                    
               end if;
               
          elsif v_option = 'D' then
          	
               execute 'select coalesce(parent_comment_id,0)
               		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                    	where user_asset_reaction_id = $1
                         and user_id = case $2 when 0 then user_id else $2 end'
			into v_parent_comment_id
          	using v_comment_id, coalesce(v_user_id,0);
          	
               if v_parent_comment_id is not null then
               	
                    if v_parent_comment_id = 0 then
          		
               		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_deleted_comments
                         		select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date,
                                   		parent_comment_id, is_reply_to, $2, $3, $4
          					from labmi.labmi_user_asset_reaction
          					where (user_asset_reaction_id = $1 or parent_comment_id = $1)'
               		using v_comment_id, v_current_timestamp, v_option, v_source;
               		
               		execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                    			where (user_asset_reaction_id = $1 or parent_comment_id = $1)'
					using v_comment_id;
               		
          		else
          			
               		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_deleted_comments
                         		select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date,
                                   		parent_comment_id, is_reply_to, $2, $3, $4
          					from labmi.labmi_user_asset_reaction
          					where user_asset_reaction_id = $1'
               		using v_comment_id, v_current_timestamp, v_option, v_source;
               		
               		execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                         		where is_reply_to = $1'
               		into v_reply_count
               		using v_comment_id;
               		
               		if v_reply_count <> 0 then
               			
                    		execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                         			set is_reply_to = $2
               					where is_reply_to = $1'
						using v_comment_id,  v_parent_comment_id;
                    		
               		end if;
               		
               		execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction where
                    			user_asset_reaction_id = $1'
					using v_comment_id;
               		
          		end if;
          		
          		p_result := 1;
                    
               else
               	
                    p_result := 0;
                    
               end if;
               
          else
          	
               p_result := 0;
               
          end if;
          
	else
     	
          p_result := 0;
          
     end if;
	
/*exception
	when others then
     	p_result := -1;*/
     
end;

$_$;


--
