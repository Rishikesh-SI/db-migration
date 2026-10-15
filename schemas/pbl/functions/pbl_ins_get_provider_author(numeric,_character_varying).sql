-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_ins_get_provider_author(numeric, character varying)
-- Type: FUNCTION

-- Name: pbl_ins_get_provider_author(numeric, character varying); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_ins_get_provider_author(p_provider_id numeric, p_author_name character varying, OUT p_author_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
v_author_id numeric ; 
v_currenttimestamp    timestamp;

BEGIN

v_currenttimestamp := current_timestamp at time zone 'utc';

 if exists (select 1 from  pbl.pbl_provider_author_map
            where author_name = p_author_name
            and content_provider_id = p_provider_id
           )
 then 
 		select author_id into p_author_id
        from  pbl.pbl_provider_author_map
        where author_name = p_author_name
        and content_provider_id = p_provider_id
        ; 
 else 
 	v_author_id := nextval('pbl.seq_pbl_author_id') ;
    
 	insert into pbl.pbl_provider_author_map
	(provider_author_map_id, content_provider_id, author_id, author_name, 
     created_date, updated_date, created_by, updated_by, is_active , is_deleted )
	values(nextval('pbl.seq_pbl_provider_author_map_id'), p_provider_id, v_author_id, p_author_name,
           v_currenttimestamp, v_currenttimestamp, 1, 1 , 1, 0 ) ;
        
 		p_author_id := v_author_id ;     
    
    
    insert into pbl.pbl_user
    (user_id ,
    user_name,
    full_name ,
    display_name ,
    partner_id ,
    email_id ,
    profile_picture_url,
    created_date,
    updated_date ,
    created_by ,
    updated_by,
    is_active ,
    is_deleted ,
    is_published ,
    user_guid ,
    user_pwd ,
    reset_key ,
    key_expiry_date ,
    failed_attempts ,
    unlock_date )
    values(v_author_id,
    		p_author_name, 
            p_author_name,  
            p_author_name,
            1, 
        	'yahoo@yahoo.com',
           null,
           v_currenttimestamp,
           v_currenttimestamp,
           1,
           1,
           1,
           0,
           1,
           uuid_generate_v4(),
           '45537343653232554145595446476D72326B316655773D3D',
           null,
           null,
           0,
           null
           );
      
      insert into  pbl.pbl_user_role
		(user_role_id, user_id, role_id,  created_date,  updated_date, created_by, updated_by ,
    	is_active , is_deleted,  is_published ,  user_role_guid )
	  values( nextval('pbl.seq_pbl_user_role_id'), v_author_id, 4, v_currenttimestamp,v_currenttimestamp,
		1, 1, 1,0,1 , uuid_generate_v4()) ;
		
 end if ; 

END;

 

 $$;


--
