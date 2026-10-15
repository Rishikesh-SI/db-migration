-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_user_asset_reaction_dk(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_user_asset_reaction_dk(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_user_asset_reaction_dk(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_asset_reaction_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from siwaf._ins_upd_user_asset_reaction_dk(
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
	v_is_app numeric;
	v_platform_id numeric;
    v_user_id numeric;
	v_user_full_name text;
	v_profile_picture_url text;
	v_client_id numeric;
	v_is_custom_image numeric;
	v_is_admin_user numeric;
	v_client_user_id numeric;
	v_client_reaction_id_arr integer[];
	v_user_asset_reaction_count numeric;
	v_user_asset_reaction_id numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_user_comment_reaction_count numeric;
	v_asset_comment_reaction_id numeric;
    v_is_reply_to numeric;
	v_reactions_count numeric:=0;
	v_user_reaction numeric;
	v_comments_count numeric:=0;
	v_comment_reaction_count numeric:=0;
	v_comment_user_reaction numeric ;
	v_comment_total_reply numeric:=0;
	v_reaction_date timestamp;
	v_is_edit_delete_allowed numeric;
	v_user_exist_reaction numeric;
    v_user_exist_comment_reaction numeric;
    v_comment_text_org text;
	v_asset_reaction_id numeric;
	v_comment_reaction_id numeric;
	v_exists_in_master numeric:=0; 
	v_exists_in_comment_master numeric:=0;
	v_asset_reaction_date timestamp;
	v_comment_reaction_date timestamp;
	v_parent_reaction_count numeric;
	v_parent_total_reply numeric;
	v_parent_user_id numeric;
	v_parent_full_name text;
	 v_parent_profile_picture_url text; 
	 v_parent_client_id numeric;
	  v_parent_is_custom_image numeric;
	   v_parent_is_admin_user numeric;
v_parent_comment_text text;
v_parent_edit_allowed numeric;
v_user_parent_comment_reaction numeric;
v_parent_reaction_date timestamp;
begin
	
	set enable_seqscan = false;
	
	select p_json->>'user_guid', p_json->>'asset_id', p_json->>'asset_type_id', p_json->>'reaction_id', p_json->>'comment_text',
			p_json->>'comment_id', p_json->>'parent_comment_id', p_json->>'is_app', p_json->>'platform_id'
	into v_user_guid, v_asset_id, v_asset_type_id, v_reaction_id, v_comment_text, v_comment_id, v_parent_comment_id, v_is_app, v_platform_id;
	
	select source_value
	into v_client_user_id
	from siwaf.siwaf_client_comment_source_map
	where client_code = p_schema_prefix
	and source_id = 1;
	
	
	execute 'select user_id, user_full_name, profile_picture_url, client_id, is_custom_image,
					case user_id when $1 then 1 else 0 end is_admin_user
				from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
				where user_guid = $2 '
	into v_user_id, v_user_full_name, v_profile_picture_url, v_client_id, v_is_custom_image, v_is_admin_user 
	using coalesce(v_client_user_id,0),v_user_guid;
   ----v_user_id:= v_user_guid;

	execute ' select count(1) from  '||p_schema_prefix||'.'||p_schema_prefix||'_comment_asset_master
	              where asset_id =$1
				  and asset_type_id =$2'
			into v_exists_in_master
			using v_asset_id,v_asset_type_id;

 if v_exists_in_master =0
 then
  execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_comment_asset_master(asset_id,asset_type_id,total_reactions,total_comments)
				  select $1,$2,0,0'
				 using v_asset_id,v_asset_type_id;

 end if;

	
    if v_user_id is not null then
	
			 execute 'select  reaction_id,user_asset_reaction_id,reaction_date
							from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk
							where asset_id = $1
							and asset_type_id = $2
							and user_id = $3
							and reaction_id <>4 '	
                       into  v_user_exist_reaction,v_asset_reaction_id,v_asset_reaction_date
					   using v_asset_id,v_asset_type_id,v_user_id;

   if v_comment_id is not null
   then

   	execute 'select reaction_id,asset_comment_reaction_id,reaction_date
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction_dk
							where asset_id = $1
							and asset_type_id = $2
							and comment_id = $3
                         	and user_id = $4 ' 
				 into v_user_exist_comment_reaction,v_comment_reaction_id,v_comment_reaction_date
				 using v_asset_id,v_asset_type_id,v_comment_id,v_user_id;

   end if;

			 	
		
		
	if v_reaction_id=4 then
		if v_parent_comment_id is not null then
				v_is_reply_to := v_parent_comment_id;
			    
     			
					execute 'select   parent_comment_id
								from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk
               					where user_asset_reaction_id = $1' 
					into  v_parent_comment_id
					using v_parent_comment_id;
					
					if v_parent_comment_id is null 
					then
					v_parent_comment_id:=v_is_reply_to;
					end if;
					 
          			
				
			end if;
			
     		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_user_asset_reaction_id'')'
          	into v_comment_id
          	using p_schema_prefix;
			
			execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk(user_asset_reaction_id, user_id, asset_id,
																									asset_type_id, reaction_id, comment_text,
																									reaction_date, parent_comment_id,
																									is_reply_to, is_app, platform_id)
						select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11'
			using v_comment_id, v_user_id, v_asset_id, v_asset_type_id, v_reaction_id, v_comment_text, v_current_timestamp,  coalesce(v_parent_comment_id,v_is_reply_to),
					v_is_reply_to, v_is_app, v_platform_id;

             
			  execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_comment_asset_master
			  set total_comments=total_comments+1
			  where asset_id =$1 
			  and asset_type_id=$2'
			  using v_asset_id,v_asset_type_id; 
			 
			 if v_parent_comment_id is not null
			   then
			 execute ' select count(1)
			  from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master
			  where comment_id=$1 '
			  into v_exists_in_comment_master
			   using v_parent_comment_id; 

			   if v_exists_in_comment_master=0 then

			    
			 execute 'select  comment_text,user_id
							from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk
							where user_asset_reaction_id =$1 '	
                       into  v_parent_comment_text,v_parent_user_id
					   using v_parent_comment_id;

			    execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master(comment_id,total_reactions,total_reply,user_id,comment_text)
				  select $1,0,1,$2,$3'
				 using v_parent_comment_id,v_parent_user_id,v_parent_comment_text;  

				 else
				 execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master
			  set total_reply=total_reply+1
			  where comment_id=$1'
			  using v_parent_comment_id; 

			   end if;
			   
			 end if;

			    

			  
      
          
 	else
	
	if v_comment_id is null then
				
				
				if ( v_user_exist_reaction=v_reaction_id) then
				execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk
								where user_asset_reaction_id = $1'
								 using v_asset_reaction_id;
								 
                     execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_comment_asset_master
								  set total_reactions=total_reactions-1
								  where asset_id =$1 
								  and asset_type_id=$2'
								  using v_asset_id,v_asset_type_id; 
			 
                            
				 elsif (v_user_exist_reaction<>v_reaction_id and v_user_exist_reaction is not null) then
				 execute 'update   '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk
				 set reaction_id = $1
								where user_asset_reaction_id =$2' 
							  using v_reaction_id,v_asset_reaction_id;

               v_user_reaction:=v_reaction_id;

				elsif (v_user_exist_reaction is null) then
					
					execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_user_asset_reaction_id'')'
					into v_user_asset_reaction_id
					using p_schema_prefix;
					
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk(user_asset_reaction_id, user_id,
																											asset_id, asset_type_id,
																											reaction_id, comment_text,
																											reaction_date, parent_comment_id,
																											is_app, platform_id)
								select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10'
					using v_user_asset_reaction_id, v_user_id, v_asset_id, v_asset_type_id, v_reaction_id, null, v_current_timestamp,
							v_parent_comment_id, v_is_app, v_platform_id;

							execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_comment_asset_master
								  set total_reactions=total_reactions+1
								  where asset_id =$1 
								  and asset_type_id=$2'
								  using v_asset_id,v_asset_type_id; 

             
			v_user_reaction:=v_reaction_id;
					 
				end if;

			 
						 
           
		     	
			else

				 execute ' select count(1)
			  from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master
			  where comment_id=$1 '
			  into v_exists_in_comment_master
			   using v_comment_id; 

			   if v_exists_in_comment_master=0 then

			    execute 'select  comment_text,user_id
							from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction_dk
							where user_asset_reaction_id =$1 '	
                       into  v_parent_comment_text,v_parent_user_id
					   using v_comment_id;

			    execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master(comment_id,total_reactions,total_reply,user_id,comment_text)
				  select $1,0,0,$2,$3'
				 using v_comment_id,v_parent_user_id,v_parent_comment_text;  

			   end if;
               	
          		 
	

			if (v_user_exist_comment_reaction=v_reaction_id) then	

             execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction_dk
								where asset_comment_reaction_id = $1' 
              using v_comment_reaction_id;
				
			  execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master
				  set total_reactions=total_reactions-1
				  where comment_id=$1'
				  using v_comment_id; 
							

           

		   elsif (v_user_exist_comment_reaction<>v_reaction_id and v_user_exist_comment_reaction is not null) then	

		   execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction_dk
		             set reaction_id =  $1
								where asset_comment_reaction_id = $2' 
			  using v_reaction_id ,v_comment_reaction_id;
                
				v_comment_user_reaction:=v_reaction_id;
				
		   

				elsif (v_user_exist_comment_reaction is null) then
					
				  execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_comment_reaction_id'')'
					into v_asset_comment_reaction_id
					using p_schema_prefix;
					
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction_dk(asset_comment_reaction_id, asset_id,
																											asset_type_id, user_id, comment_id,
																											reaction_id, reaction_date)
								select $1, $2, $3, $4, $5, $6, $7'
					using v_asset_comment_reaction_id, v_asset_id, v_asset_type_id, v_user_id, v_comment_id, v_reaction_id, v_current_timestamp
							;
                    v_comment_user_reaction:=v_reaction_id;
                    
					 execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master
				  set total_reactions=total_reactions+1
				  where comment_id=$1'
				  using v_comment_id; 

				end if;

		 	
      	end if; 
	
	 end if;

	  execute 'select    total_comments,total_reactions
							from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_asset_master
							where asset_id = '||v_asset_id||'
							and asset_type_id = '||v_asset_type_id	 
				into v_comments_count,v_reactions_count;

   
   
   if (v_comment_id is not null and v_reaction_id <>4) then

     execute ' select total_reactions,total_reply,comment_text
			  from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master
			  where comment_id=$1 '
			  into   v_comment_reaction_count,v_comment_total_reply,v_comment_text
			   using v_comment_id; 

   end if;

    if (v_parent_comment_id is not null) then

     execute ' select total_reactions,total_reply,user_id,comment_text,case when  user_id = $2 then 1 else 0 end is_edit_delete_allowed
			  from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_reaction_master
			  where comment_id=$1 '
			  into   v_parent_reaction_count,v_parent_total_reply,v_parent_user_id,v_parent_comment_text,v_parent_edit_allowed
			   using v_parent_comment_id,v_user_id; 

    
   	execute 'select reaction_id,reaction_date
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction_dk
							where asset_id = $1
							and asset_type_id = $2
							and comment_id = $3
                         	and user_id = $4 ' 
				 into v_user_parent_comment_reaction,v_parent_reaction_date
				 using v_asset_id,v_asset_type_id,v_parent_comment_id,v_user_id;
  
   execute 'select  user_full_name, profile_picture_url, client_id, is_custom_image,
					case user_id when $1 then 1 else 0 end is_admin_user
				from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
				where user_id = $2 '
	into  v_parent_full_name, v_parent_profile_picture_url, v_parent_client_id, v_parent_is_custom_image, v_parent_is_admin_user 
	using coalesce(v_client_user_id,0),v_parent_user_id;
   

   end if;

	 
	 	
	
if v_parent_comment_id is null
then
 execute 'select (''{"data":[{"asset_reaction_json":''||string_agg(row_to_json(row)::text,'','')||''}]}'')::jsonb
						from (select $1 as asset_id, $2 as asset_type_id, $3 as reactions_count, $4 as comments_count, $5 as user_reaction,
										(select array_to_json(array_agg(row))
											from (select $6 as user_full_name, $7 as profile_picture_url, $8 as client_id, $9 as is_custom_image,
															$10 as is_admin_user, $14 as comment_text, $15 as comment_id, $16 as reaction_date,
															$17 as is_edit_delete_allowed, 0 as is_edit_delete_allowed,
                                                            $11 as reactions_count, $12 as user_reaction, null as latest_reply,
                                                            $13 as total_replies
												) row
               							) as comments
							) as row'
			into p_asset_reaction_json
			using v_asset_id, v_asset_type_id,  v_reactions_count ,  v_comments_count ,  v_user_reaction ,
					coalesce(v_user_full_name,''), coalesce(v_profile_picture_url,''), coalesce(v_client_id,0), coalesce(v_is_custom_image,0),
					v_is_admin_user, coalesce(v_comment_reaction_count,0), coalesce(v_comment_user_reaction, 0),
					coalesce(v_comment_total_reply, 0), coalesce(v_comment_text_org,v_comment_text), v_comment_id, v_reaction_date, v_is_edit_delete_allowed;
	 
else

execute 'select (''{"data":[{"asset_reaction_json":''||string_agg(row_to_json(row)::text,'','')||''}]}'')::jsonb
						from (select $1 as asset_id, $2 as asset_type_id,
										$3 as reactions_count,
										$4 as comments_count,
										 $5 as user_reaction,
										(select array_to_json(array_agg(row))
                                        	from (select $6 as user_full_name, $7 as profile_picture_url, $8 as client_id, $9 as is_custom_image,
                                            				 $10 as is_admin_user,
                                                            $11 as is_edit_delete_allowed,
                                                        	$12 as comment_text,
															$13 as comment_id,
															$14 as reaction_date,
                                                            $15 as reactions_count,
															$16 as user_reaction,
															(select array_to_json(array_agg(row))
                                                            	from (select $17 as user_id, $18 as user_full_name, $19 as profile_picture_url,
																				$20 as client_id, $21 as is_custom_image,
																				 $22 as is_admin_user,
																				 1 as is_edit_delete_allowed,
                                                                 				 $23 as comment_id,  $24 as  comment_text,
																				 $25 as reaction_date,
                                                                                $26 as reactions_count,
																				$27 as user_reaction
																		 
																	) row
															) as latest_reply,
                                                          $28 as total_replies
													 
												) row
               							) as comments ) as row'
			into p_asset_reaction_json
		using v_asset_id, v_asset_type_id,  v_reactions_count ,  v_comments_count ,  v_user_exist_reaction ,
		v_parent_full_name, v_parent_profile_picture_url, v_parent_client_id, v_parent_is_custom_image, v_parent_is_admin_user,coalesce(v_parent_edit_allowed,0),
		v_parent_comment_text,v_parent_comment_id,v_parent_reaction_date,  v_parent_reaction_count, v_user_parent_comment_reaction,v_user_id,
		coalesce(v_user_full_name,''), coalesce(v_profile_picture_url,''), coalesce(v_client_id,0), coalesce(v_is_custom_image,0),
					v_is_admin_user,v_comment_id,v_comment_text,v_reaction_date,v_comment_reaction_count,v_user_reaction,v_parent_total_reply;
		
		

 end if;
      	
		if p_asset_reaction_json is not null then
          	p_result := 1;
		else
          	p_result := 0;
		end if; 
		
	else
		p_result := 0;
     	p_asset_reaction_json := '{"data":[]}'::jsonb;
		
	end if;
	

end;

$_$;


--
