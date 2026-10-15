-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_get_user_name_isl(character varying)
-- Type: FUNCTION

-- Name: isl_ins_get_user_name_isl(character varying); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_get_user_name_isl(p_author_name character varying, OUT p_author_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_user_id numeric ; 
v_currenttimestamp    timestamp;

BEGIN

v_currenttimestamp := current_timestamp at time zone 'utc';

 if exists (select 1 from  isl.isl_user
            where upper(user_name) = upper(p_author_name)
           
           )
 then 
 		select user_id into p_author_id
        from  isl.isl_user
        where upper(user_name) = upper(p_author_name)
     
        ; 
 else 
 	v_user_id := nextval('isl.seq_isl_user_id') ;
    
 	
    insert into isl.isl_user
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
    values(v_user_id,
    		   p_author_name, 
            p_author_name,  
            p_author_name,
            0, 
        	  'isl@isl.com',
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
          
         p_author_id:= v_user_id; 
 end if ; 

END;

 

$$;


--
