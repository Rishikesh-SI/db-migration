-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_ins_get_content_provider(character varying, character varying, character varying)
-- Type: FUNCTION

-- Name: stn_ins_get_content_provider(character varying, character varying, character varying); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_ins_get_content_provider(p_contect_provider_name character varying, p_content_provider_desc character varying, p_copyright_text character varying, OUT p_content_provider_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_content_provider_id numeric ; 
v_currenttimestamp    timestamp;

BEGIN

v_currenttimestamp := current_timestamp at time zone 'utc';

 if exists (select 1 from  stn.stn_content_provider
            where content_provider_name = p_contect_provider_name)
 then 
 		select content_provider_id into p_content_provider_id
        from  stn.stn_content_provider
        where content_provider_name = p_contect_provider_name
        ; 
 else 
 	v_content_provider_id := nextval('stn.seq_stn_content_provider_id') ;
    
 		insert into stn.stn_content_provider
		(content_provider_id, content_provider_name, created_date, updated_date,
    	 created_by, updated_by, is_active, is_deleted,
         content_provider_display_name, content_provider_desc, is_published, content_provider_guid, copyright_text)
		values(v_content_provider_id, p_contect_provider_name, v_currenttimestamp, v_currenttimestamp,
          1, 1 , 1, 0,
          p_contect_provider_name, p_content_provider_desc, 1, uuid_generate_v4(), p_copyright_text ) ;
        
 		p_content_provider_id := v_content_provider_id ; 
        
 end if ; 

END;

 

$$;


--
