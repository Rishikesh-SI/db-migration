-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_ins_get_content_provider_bak(character varying)
-- Type: FUNCTION

-- Name: pbl_ins_get_content_provider_bak(character varying); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_ins_get_content_provider_bak(p_contect_provider_name character varying, OUT p_content_provider_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
v_content_provider_id numeric ; 
v_currenttimestamp    timestamp;

BEGIN

v_currenttimestamp := current_timestamp at time zone 'utc';

 if exists (select 1 from  pbl.pbl_content_provider
            where content_provider_name = p_contect_provider_name)
 then 
 		select content_provider_id into p_content_provider_id
        from  pbl.pbl_content_provider
        where content_provider_name = p_contect_provider_name
        ; 
 else 
 	v_content_provider_id := nextval('pbl.seq_pbl_content_provider_id') ;
    
 		insert into pbl.pbl_content_provider
		(content_provider_id, content_provider_name, created_date, updated_date,
    	 created_by, updated_by, is_active, is_deleted)
		values(v_content_provider_id, p_contect_provider_name, v_currenttimestamp, v_currenttimestamp,
          1, 1 , 1, 0 ) ;
        
 		p_content_provider_id := v_content_provider_id ; 
        
 end if ; 

END;

 
 $$;


--
