-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_get_content_provider(numeric)
-- Type: FUNCTION

-- Name: labso_get_content_provider(numeric); Type: FUNCTION; Schema: labso_bkp; Owner: -
--

CREATE FUNCTION labso_bkp.labso_get_content_provider(p_content_provider_id numeric, OUT p_contentprovider_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 
declare
	v_json varchar(30000) := '{"contentsourcelist":';
	   
begin
	
    select array_to_json(array_agg(a)) jsonrow
     from
     ( 
		 select * from  labso.labso_content_provider
		 where (content_provider_id = p_content_provider_id or coalesce(p_content_provider_id,0) = 0)
		 and is_active = 1 
		 and is_deleted = 0 	 
     ) a    
    into   p_contentprovider_json;
    
    p_contentprovider_json := v_json || p_contentprovider_json||'}';
    
end;

 

 $$;


--
