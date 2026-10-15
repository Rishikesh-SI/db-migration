-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_user_asset_reaction_1103(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_user_asset_reaction_1103(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_user_asset_reaction_1103(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_asset_reaction_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from siwaf._ins_upd_user_asset_reaction_1103(
	'labmi',-- <p_schema_prefix character varying>, 
	'{
  "user_guid": null,
  "asset_id": "1",
  "asset_type_id": "1",
  "comment_id": 6,
  "reaction_id": 1,
  "comment_text": null,
  "parent_comment_id": null
}'-- <p_json jsonb>, 
);
*/

declare
	
     v_user_guid character varying(50);
     v_asset_id numeric;
     v_asset_type_id numeric;
     v_reaction_id numeric;
     v_comment_text text;
     v_comment_id numeric;
     v_parent_comment_id numeric;
     v_user_id numeric;
     v_user_asset_reaction_count numeric;
	v_user_asset_reaction_id numeric;
     v_current_timestamp timestamp := current_timestamp at time zone 'utc';
     v_comment_reaction_count numeric;
     v_asset_comment_reaction_id numeric;
     v_is_reply_to numeric;
     v_json jsonb;
     v_client_user_id numeric;
    v_reaction_date_1 timestamp;
	
begin
     
     select p_json->>'user_guid', p_json->>'asset_id', p_json->>'asset_type_id', p_json->>'reaction_id', p_json->>'comment_text', p_json->>'comment_id',
     		p_json->>'parent_comment_id'
	into v_user_guid, v_asset_id, v_asset_type_id, v_reaction_id, v_comment_text, v_comment_id, v_parent_comment_id;
	
    v_reaction_id := case v_reaction_id when 0 then 1 else v_reaction_id end;
    
	execute 'select user_id from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
     		where user_guid = '''||v_user_guid||''''
	into v_user_id;
    
    select source_value into v_client_user_id from siwaf.siwaf_client_comment_source_map where client_code = p_schema_prefix and source_id = 1;
     
     if v_user_id is not null then
     
     execute '   select max(reaction_date)  
				 from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
				 where reaction_id = 4 and user_id = '||v_user_id
	into v_reaction_date_1;

	if  (v_reaction_date_1 + '3 seconds'::interval) > v_current_timestamp and v_reaction_id = 4 then

        p_result := 2;
        p_asset_reaction_json := '{"data":[]}'::jsonb;

	else
     	
          if v_reaction_id <> 4 then
		  
		 
          	
     		if v_comment_id is null then
               	
          		execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
						where asset_id = '||v_asset_id||'
						and asset_type_id = '||v_asset_type_id||'
						and user_id = '||v_user_id||'
						and reaction_id = '||v_reaction_id
				into v_user_asset_reaction_count;
				
				 
                    
				if v_user_asset_reaction_count = 0 then
               		
                         execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                         		where asset_id = '||v_asset_id||'
                              	and asset_type_id = '|| v_asset_type_id||'
							and user_id = '||v_user_id||'
							and reaction_id <> 4';
					
					execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_user_asset_reaction_id'')'
                    	into v_user_asset_reaction_id
                    	using p_schema_prefix;
                         
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction(user_asset_reaction_id, user_id, asset_id,
                         																	asset_type_id, reaction_id, comment_text,
                                                                                                         	reaction_date, parent_comment_id)
							select $1, $2, $3, $4, $5, $6, $7, $8'
					using v_user_asset_reaction_id, v_user_id, v_asset_id, v_asset_type_id, v_reaction_id, v_comment_text, v_current_timestamp,
                         		v_parent_comment_id;
					
				else
							
                         execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                         		where asset_id = '||v_asset_id||'
                              	and asset_type_id = '|| v_asset_type_id||'
							and user_id = '||v_user_id||'
							and reaction_id = '||v_reaction_id;
					
				end if;
                    
          	else
               	
          		execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
						where asset_id = '||v_asset_id||'
						and asset_type_id = '||v_asset_type_id||'
						and comment_id = '||v_comment_id||'
                         	and user_id = '||v_user_id||'
						and reaction_id = '||v_reaction_id
				into v_comment_reaction_count;
                    
				if v_comment_reaction_count = 0 then
               		
                         execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                         		where asset_id = '||v_asset_id||'
                              	and asset_type_id = '||v_asset_type_id||'
                              	and user_id = '||v_user_id||'
							and comment_id = '||v_comment_id;
					
                         execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_comment_reaction_id'')'
                    	into v_asset_comment_reaction_id
                    	using p_schema_prefix;
					
                         execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction(asset_comment_reaction_id, asset_id,
                         																		asset_type_id, user_id, comment_id,
                                                                                                              	reaction_id, reaction_date)
							select $1, $2, $3, $4, $5, $6, $7'
					using v_asset_comment_reaction_id, v_asset_id, v_asset_type_id, v_user_id, v_comment_id, v_reaction_id, v_current_timestamp;
                         
				else
					
                         execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                    			where asset_id = '||v_asset_id||'
                              	and asset_type_id = '||v_asset_type_id||'
                              	and user_id = '||v_user_id||'
							and comment_id = '||v_comment_id||'
							and reaction_id = '||v_reaction_id;
					
				end if;
                    
          	end if;
               
     	else
               
               v_is_reply_to := v_parent_comment_id;
               
     		loop
          		exit when v_parent_comment_id is null;
          		execute 'select user_asset_reaction_id, parent_comment_id from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
               			where user_asset_reaction_id = '||v_parent_comment_id
				into v_comment_id, v_parent_comment_id;
          	end loop;
               
               v_parent_comment_id := v_comment_id;
               
     		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_user_asset_reaction_id'')'
          	into v_comment_id
          	using p_schema_prefix;
               
			execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction(user_asset_reaction_id, user_id, asset_id,
               																	asset_type_id, reaction_id, comment_text,
                                                                                                    reaction_date, parent_comment_id, is_reply_to)
					select $1, $2, $3, $4, $5, $6, $7, $8, $9'
			using v_comment_id, v_user_id, v_asset_id, v_asset_type_id, v_reaction_id, v_comment_text, v_current_timestamp, v_parent_comment_id,
               		v_is_reply_to;
			
               v_parent_comment_id := v_is_reply_to;
               
     	end if;
          
          if v_parent_comment_id is null then
          	
			
               if v_comment_id is null then
               	v_comment_id := 0;
               end if;
			   raise notice '%', v_comment_id;
               
				execute 'select (''{"data":[{"asset_reaction_json":''||string_agg(row_to_json(row)::text,'','')||''}]}'')::jsonb
               		from (select uar.asset_id, uar.asset_type_id,
                         			coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                        		where uar1.asset_id = uar.asset_id
                                                  and uar1.asset_type_id = uar.asset_type_id
                                                  and uar1.reaction_id <> 4),0) as reactions_count,
								coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                        		where uar1.asset_id = uar.asset_id
                                                  and uar1.asset_type_id = uar.asset_type_id
                                                  and uar1.reaction_id = 4
                                                  and uar1.parent_comment_id is null),0) as comments_count,
								coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                        		where uar1.asset_id = uar.asset_id
                                                  and uar1.asset_type_id = uar.asset_type_id
                                                  and uar1.reaction_id <> 4
                                                  and uar1.user_id = '||v_user_id||'),0) as user_reaction,
								(select array_to_json(array_agg(row))
                                        	from (select wu.user_full_name, wu.profile_picture_url, wu.client_id, wu.is_custom_image,
                                            				case wu.user_id when '||coalesce(v_client_user_id,0)||' then 1 else 0 end is_admin_user,
                                                       	uar1.comment_text, uar1.user_asset_reaction_id as comment_id,uar1.reaction_date,
                                                            case wu.user_id when '||v_user_id||' then 1 else 0 end is_edit_delete_allowed,
                                                            coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                            		where acr.comment_id = uar1.user_asset_reaction_id),0) as reactions_count,
												coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                            		where acr.comment_id = uar1.user_asset_reaction_id
                                                                      and acr.user_id = '||v_user_id||'),0) as user_reaction,
												null as latest_reply,
                                                            coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar2
                                                                      where uar2.parent_comment_id = uar1.user_asset_reaction_id),0) as total_replies
											from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                                       join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                                                       on wu.user_id = uar1.user_id
                                                       where uar1.user_asset_reaction_id = '||v_comment_id||'
										) row
               					) as comments
							from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                                   where uar.asset_id = '||v_asset_id||'
                                   and uar.asset_type_id = '||v_asset_type_id||'
                                   group by uar.asset_id, uar.asset_type_id
						) as row'
			into p_asset_reaction_json;
			
			
		
          else
          	
               execute 'select (''{"data":[{"asset_reaction_json":''||string_agg(row_to_json(row)::text,'','')||''}]}'')::jsonb
               		from (select uar.asset_id, uar.asset_type_id,
                         			coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                        		where uar1.asset_id = uar.asset_id
                                                  and uar1.asset_type_id = uar.asset_type_id
                                                  and uar1.reaction_id <> 4),0) as reactions_count,
								coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                        		where uar1.asset_id = uar.asset_id
                                                  and uar1.asset_type_id = uar.asset_type_id
                                                  and uar1.reaction_id = 4
                                                  and uar1.parent_comment_id is null),0) as comments_count,
								coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                        		where uar1.asset_id = uar.asset_id
                                                  and uar1.asset_type_id = uar.asset_type_id
                                                  and uar1.reaction_id <> 4
                                                  and uar1.user_id = '||v_user_id||'),0) as user_reaction,
								(select array_to_json(array_agg(row))
                                        	from (select wu.user_full_name, wu.profile_picture_url, wu.client_id, wu.is_custom_image,
                                            				case wu.user_id when '||v_client_user_id||' then 1 else 0 end is_admin_user,
                                                            case wu.user_id when '||v_user_id||' then 1 else 0 end is_edit_delete_allowed,
                                                        	uar1.comment_text, uar1.user_asset_reaction_id as comment_id,
                                                            coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                            		where acr.comment_id = uar1.user_asset_reaction_id),0) as reactions_count,
												coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                            		where acr.comment_id = uar1.user_asset_reaction_id
                                                                      and acr.user_id = '||v_user_id||'),0) as user_reaction,
												(select array_to_json(array_agg(row))
                                                            	from (select uar2.user_id, wu1.user_full_name, wu1.profile_picture_url, wu1.client_id, wu1.is_custom_image,
                                                                			case wu1.user_id when '||coalesce(v_client_user_id,0)||' then 1 else 0 end is_admin_user,
                                                                           case wu1.user_id when '||v_user_id||' then 1 else 0 end is_edit_delete_allowed,
                                                                 			uar2.user_asset_reaction_id as comment_id, uar2.comment_text,
                                                                                coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                                                		where acr.comment_id = uar2.user_asset_reaction_id),0) as reactions_count,
																coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                                                		where acr.comment_id = uar2.user_asset_reaction_id
                                                                                          and acr.user_id = '||v_user_id||'),0) as user_reaction
															from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar2
                                                                           join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu1
                                                                           on wu1.user_id = uar2.user_id
                                                                           where uar2.user_asset_reaction_id = '||v_comment_id||'
														) row
												) as latest_reply,
                                                            coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar2
                                                                      where uar2.parent_comment_id = uar1.user_asset_reaction_id),0) as total_replies
											from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                                       join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                                                       on wu.user_id = uar1.user_id
                                                       where uar1.user_asset_reaction_id = '||v_parent_comment_id||'
										) row
               					) as comments
							from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                                   where uar.asset_id = '||v_asset_id||'
                                   and uar.asset_type_id = '||v_asset_type_id||'
                                   group by uar.asset_id, uar.asset_type_id	
						) as row'
			into p_asset_reaction_json;
               
          end if;
     	
          if p_asset_reaction_json is not null then
          	p_result := 1;
		else
          	p_result := 0;
          end if;
          
        end if;  
          
     else
     	
          p_result := 0;
     	p_asset_reaction_json := '{"data":[]}'::jsonb;
          
     end if;
     
	
/*exception
	when others then
		p_result := -1;
		p_asset_reaction_json := '{"data":[]}'::jsonb;*/
end;

$_$;


--
