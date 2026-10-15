-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: labecn_upd_del_user_asset_comments(jsonb)
-- Type: FUNCTION

-- Name: labecn_upd_del_user_asset_comments(jsonb); Type: FUNCTION; Schema: labecn_bkp07062024; Owner: -
--

CREATE FUNCTION labecn_bkp07062024.labecn_upd_del_user_asset_comments(p_input_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
     v_comment_id numeric;
     v_option char(1);
     v_comment_text text;
     v_current_timestamp timestamp := current_timestamp at time zone 'utc';
     v_parent_comment_id numeric;
     v_reply_count numeric;
     
begin
	
     select p_input_json->>'comment_id', p_input_json->>'option', p_input_json->>'comment_text'
     into v_comment_id, v_option, v_comment_text;
     
	if v_option = 'E' then
     	
          insert into labecn.labecn_user_asset_deleted_comments
          select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
          		v_current_timestamp
          from labecn.labecn_user_asset_reaction
          where user_asset_reaction_id = v_comment_id;
          
          update labecn.labecn_user_asset_reaction
          set comment_text = v_comment_text
          where user_asset_reaction_id = v_comment_id;
          
          p_result := 1;
          
     elsif v_option = 'D' then
     	
          select parent_comment_id
          from labecn.labecn_user_asset_reaction
          where user_asset_reaction_id = v_comment_id
          into v_parent_comment_id;
          
          if v_parent_comment_id is null then
          	
               insert into labecn.labecn_user_asset_deleted_comments
          	select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
               		v_current_timestamp
          	from labecn.labecn_user_asset_reaction
          	where user_asset_reaction_id = v_comment_id;
               
               insert into labecn.labecn_user_asset_deleted_comments
          	select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
               		v_current_timestamp
          	from labecn.labecn_user_asset_reaction
          	where parent_comment_id = v_comment_id;
               
               delete from labecn.labecn_user_asset_reaction where user_asset_reaction_id = v_comment_id;
               
               delete from labecn.labecn_user_asset_reaction where parent_comment_id = v_comment_id;
               
          else
          	
               insert into labecn.labecn_user_asset_deleted_comments
          	select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
               		v_current_timestamp
          	from labecn.labecn_user_asset_reaction
          	where user_asset_reaction_id = v_comment_id;
               
               select count(1)
               from labecn.labecn_user_asset_reaction
               where is_reply_to = v_comment_id
               into v_reply_count;
               
               if v_reply_count <> 0 then
               	
                    update labecn.labecn_user_asset_reaction
               	set is_reply_to = v_parent_comment_id
               	where is_reply_to = v_comment_id;
                    
               end if;
               
               delete from labecn.labecn_user_asset_reaction where user_asset_reaction_id = v_comment_id;
               
          end if;
          
          p_result := 1;
          
     else
     	
          p_result := 0;
          
     end if;
	
exception
	when others then
     	p_result := -1;
     
end;
$$;


--
