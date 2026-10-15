-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_pdf_detail()
-- Type: FUNCTION

-- Name: zeven_get_pdf_detail(); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_pdf_detail(OUT p_result numeric, OUT p_pdfjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_json			 varchar(4000) := '{"language":';
begin
	
     select array_to_json(array_agg(a))
      into p_pdfjson  
     from   ( select *
        		from zeven.zeven_pdf_master       
               )a ;
               
     p_pdfjson := v_json || p_pdfjson || '}' ;  
       p_result :=1 ;
     
end;
 

$$;


--
