-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_upd_del_user_asset_comments(jsonb)
-- Type: FUNCTION

-- Name: labrg_upd_del_user_asset_comments(jsonb); Type: FUNCTION; Schema: labrg; Owner: -
--

CREATE FUNCTION labrg.labrg_upd_del_user_asset_comments(p_input_json jsonb, OUT p_result numeric) RETURNS numeric
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
     	
          insert into labrg.labrg_user_asset_deleted_comments
          select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
          		v_current_timestamp
          from labrg.labrg_user_asset_reaction
          where user_asset_reaction_id = v_comment_id;
          
          update labrg.labrg_user_asset_reaction
          set comment_text = v_comment_text
          where user_asset_reaction_id = v_comment_id;
          
          p_result := 1;
          
     elsif v_option = 'D' then
     	
          select parent_comment_id
          from labrg.labrg_user_asset_reaction
          where user_asset_reaction_id = v_comment_id
          into v_parent_comment_id;
          
          if v_parent_comment_id is null then
          	
               insert into labrg.labrg_user_asset_deleted_comments
          	select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
               		v_current_timestamp
          	from labrg.labrg_user_asset_reaction
          	where user_asset_reaction_id = v_comment_id;
               
               insert into labrg.labrg_user_asset_deleted_comments
          	select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
               		v_current_timestamp
          	from labrg.labrg_user_asset_reaction
          	where parent_comment_id = v_comment_id;
               
               delete from labrg.labrg_user_asset_reaction where user_asset_reaction_id = v_comment_id;
               
               delete from labrg.labrg_user_asset_reaction where parent_comment_id = v_comment_id;
               
          else
          	
               insert into labrg.labrg_user_asset_deleted_comments
          	select user_asset_reaction_id, user_id, asset_id, asset_type_id, comment_text, reaction_date, parent_comment_id, is_reply_to,
               		v_current_timestamp
          	from labrg.labrg_user_asset_reaction
          	where user_asset_reaction_id = v_comment_id;
               
               select count(1)
               from labrg.labrg_user_asset_reaction
               where is_reply_to = v_comment_id
               into v_reply_count;
               
               if v_reply_count <> 0 then
               	
                    update labrg.labrg_user_asset_reaction
               	set is_reply_to = v_parent_comment_id
               	where is_reply_to = v_comment_id;
                    
               end if;
               
               delete from labrg.labrg_user_asset_reaction where user_asset_reaction_id = v_comment_id;
               
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
