-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_get_pdf_detail()
-- Type: FUNCTION

-- Name: kxp_get_pdf_detail(); Type: FUNCTION; Schema: kxp; Owner: -
--

CREATE FUNCTION kxp.kxp_get_pdf_detail(OUT p_result numeric, OUT p_pdfjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_json			 varchar(4000) := '{"language":';
begin
	
     select array_to_json(array_agg(a))
      into p_pdfjson  
     from   ( select *
        		from kxp.kxp_pdf_master       
               )a ;
               
     p_pdfjson := v_json || p_pdfjson || '}' ;  
       p_result :=1 ;
     
end;
 

$$;


--
