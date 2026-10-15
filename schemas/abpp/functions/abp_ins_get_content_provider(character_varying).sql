-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_ins_get_content_provider(character varying)
-- Type: FUNCTION

-- Name: abp_ins_get_content_provider(character varying); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_ins_get_content_provider(p_contect_provider_name character varying, OUT p_content_provider_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_content_provider_id numeric ; 
v_currenttimestamp    timestamp;
v_content_provider_desc character varying := null ;
v_copyright_text character varying := null ;
BEGIN

v_currenttimestamp := current_timestamp at time zone 'utc';

 if exists (select 1 from  abp.abp_content_provider
            where content_provider_name = p_contect_provider_name)
 then 
 		select content_provider_id into p_content_provider_id
        from  abp.abp_content_provider
        where content_provider_name = p_contect_provider_name
        ; 
 else 
 	v_content_provider_id := nextval('abp.seq_abp_content_provider_id') ;
    
 		insert into abp.abp_content_provider
		(content_provider_id, content_provider_name, created_date, updated_date,
    	 created_by, updated_by, is_active, is_deleted,
         content_provider_display_name, content_provider_desc, is_published, content_provider_guid, copyright_text)
		values(v_content_provider_id, p_contect_provider_name, v_currenttimestamp, v_currenttimestamp,
          1, 1 , 1, 0,
          p_contect_provider_name, v_content_provider_desc, 1, uuid_generate_v4(), v_copyright_text ) ;
        
 		p_content_provider_id := v_content_provider_id ; 
        
 end if ; 

END;

 

$$;


--
