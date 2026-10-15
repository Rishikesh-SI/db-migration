-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_content_provider_data(numeric)
-- Type: FUNCTION

-- Name: labhkind_get_content_provider_data(numeric); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_content_provider_data(p_content_provider_id numeric, OUT p_content_provider_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_author_json jsonb;
 	
begin
 

/*select ('{"author":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
from (select author_id,author_name 
	from  labhkind.labhkind_provider_author_map 
 where content_provider_id=p_content_provider_id
)row
into v_author_json;*/

		         select  row_to_json(row) 
		       from   (select content_provider_id,content_provider_name,
					   is_active,is_deleted
					   from  labhkind.labhkind_content_provider  
					  where content_provider_id=p_content_provider_id
					  )row
					    into p_content_provider_json;
               
               
			   
             
/*exception
	when others then
    	p_result := -1;
       p_match_json := '{}'::jsonb;*/
end;
$$;


--
